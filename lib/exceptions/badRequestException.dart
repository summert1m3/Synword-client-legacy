class BadRequestException implements Exception {
  String message;

  BadRequestException(this.message);

  @override
  String toString() => message;
}