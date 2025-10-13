// lib/features/auth/bloc/auth_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/exceptions/auth_exceptions.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/services/session_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final SessionService _sessionService;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc({
    required AuthService authService,
    required SessionService sessionService,
  })  : _authService = authService,
        _sessionService = sessionService,
        super(const AuthState.unknown()) {
    _userSubscription = _authService.authStateChanges.listen(
          (user) => add(AuthStateChanged(user)),
    );

    on<AuthStateChanged>(_onAuthStateChanged);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignInWithFacebookRequested>(_onSignInWithFacebookRequested);
    on<SignInWithAppleRequested>(_onSignInWithAppleRequested);
    on<SignInAnonymouslyRequested>(_onSignInAnonymouslyRequested);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
  }

  Future<void> _onDeleteAccountRequested(
      DeleteAccountRequested event, Emitter<AuthState> emit) async {
    final currentUser = state.user;
    if (currentUser == null) {
      emit(const AuthState.unauthenticated(errorMessage: 'Không tìm thấy người dùng để xóa.'));
      return;
    }
    try {
      emit(const AuthState.loggingOut()); // Hiển thị màn hình loading
      await _authService.deleteAccountAndData();
      // Xóa thành công, authStateChanges sẽ phát ra null -> tự động chuyển về unauthenticated
    } catch (e) {
      // Nếu có lỗi, quay lại trạng thái đã xác thực và báo lỗi
      emit(AuthState.authenticated(
        currentUser, // Dùng user đã lấy từ state
        errorMessage: 'Lỗi xóa tài khoản: ${e.toString()}',
      ));
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    print("AuthBloc: Yêu cầu đăng xuất. Bắt đầu dọn dẹp provider...");

    _authService.stopListeningForSessionChanges();

    for (var provider in event.providersToReset) {
      if (provider is UserProvider) {
        await provider.stopListeningAndReset();
      }
      if (provider is NotificationProvider) {
        await provider.stopListeningAndReset();
      }
    }

    print("AuthBloc: Dọn dẹp provider hoàn tất.");
    emit(const AuthState.loggingOut());
    print("AuthBloc: Đã phát ra trạng thái loggingOut.");
    await Future.delayed(const Duration(milliseconds: 50));
    print("AuthBloc: Thực hiện đăng xuất khỏi Firebase.");
    await _authService.signOut();
  }

  void _onAuthStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      print("AuthBloc: User authenticated. Updating session and starting listener...");
      _sessionService.updateUserSession().then((_) {
        print("AuthBloc: Session updated. Now starting to listen for changes.");
        _authService.listenForSessionChanges();
      }).catchError((error) {
        print("AuthBloc: Error during session update/listen setup: $error");
      });
      emit(AuthState.authenticated(event.user!));
    } else {
      print("AuthBloc: User is unauthenticated. Stopping session listener.");
      _authService.stopListeningForSessionChanges();
      if (state.errorMessage == null) {
        emit(const AuthState.unauthenticated());
      }
    }
  }

  Future<void> _handleSignIn(Future<User?> Function() signInMethod, Emitter<AuthState> emit) async {
    try {
      await signInMethod();
    } on SuspendedAccountException catch (e) {
      emit(AuthState.unauthenticated(errorMessage: e.reason));
    } catch (e) {
      emit(AuthState.unauthenticated(errorMessage: e.toString()));
    }
  }

  Future<void> _onSignInWithGoogleRequested(
      SignInWithGoogleRequested event, Emitter<AuthState> emit) async {
    await _handleSignIn(_authService.signInWithGoogle, emit);
  }

  Future<void> _onSignInWithFacebookRequested(
      SignInWithFacebookRequested event, Emitter<AuthState> emit) async {
    await _handleSignIn(_authService.signInWithFacebook, emit);
  }

  Future<void> _onSignInWithAppleRequested(
      SignInWithAppleRequested event, Emitter<AuthState> emit) async {
    await _handleSignIn(_authService.signInWithApple, emit);
  }

  Future<void> _onSignInAnonymouslyRequested(
      SignInAnonymouslyRequested event, Emitter<AuthState> emit) async {
    await _handleSignIn(_authService.signInAnonymously, emit);
  }


  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _authService.stopListeningForSessionChanges();
    return super.close();
  }
}