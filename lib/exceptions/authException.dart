class AuthException  implements Exception{
  final String message = 'authException';

  @override
  String toString() => message;
}