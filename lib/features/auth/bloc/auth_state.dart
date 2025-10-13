// lib/features/auth/bloc/auth_state.dart
part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loggingOut }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
  });

  const AuthState.unknown() : this._();
  const AuthState.authenticated(User user, {String? errorMessage})
      : this._(status: AuthStatus.authenticated, user: user, errorMessage: errorMessage);

  const AuthState.unauthenticated({String? errorMessage})
      : this._(status: AuthStatus.unauthenticated, errorMessage: errorMessage);

  const AuthState.loggingOut() : this._(status: AuthStatus.loggingOut);

  @override
  List<Object?> get props => [status, user, errorMessage];
}