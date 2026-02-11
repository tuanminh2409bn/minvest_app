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

class SignInWithEmailRequested extends AuthEvent {
  final String email;
  final String password;
  const SignInWithEmailRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class SignUpWithEmailRequested extends AuthEvent {
  final String email;
  final String password;
  final String displayName;
  const SignUpWithEmailRequested({
    required this.email,
    required this.password,
    required this.displayName,
  });
  @override
  List<Object?> get props => [email, password, displayName];
}
// MỚI KẾT THÚC