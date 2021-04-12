class AuthException  implements Exception{
  final String message = 'authException';
  String getErrorMessage() {
    return message;
  }

  String toString() => message;
}