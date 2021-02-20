class ServerException implements Exception {
  String message = "serverError";
  String getErrorMessage() {
    return message;
  }

  String toString() => message;
}