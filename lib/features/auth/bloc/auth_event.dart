// lib/features/auth/bloc/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChanged extends AuthEvent {
  final User? user;
  const AuthStateChanged(this.user);
  @override
  List<Object?> get props => [user];
}

class SignOutRequested extends AuthEvent {
  final List<ChangeNotifier> providersToReset;
  const SignOutRequested({this.providersToReset = const []});
}

class SignInWithGoogleRequested extends AuthEvent {}
class SignInWithFacebookRequested extends AuthEvent {}
class SignInWithAppleRequested extends AuthEvent {}

// MỚI BẮT ĐẦU
class SignInAnonymouslyRequested extends AuthEvent {}
class DeleteAccountRequested extends AuthEvent {}
// MỚI KẾT THÚC