// lib/core/exceptions/auth_exceptions.dart

class SuspendedAccountException implements Exception {
  final String reason;
  SuspendedAccountException(this.reason);

  @override
  String toString() => 'SuspendedAccountException: $reason';
}