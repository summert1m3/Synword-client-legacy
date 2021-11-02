class ServerUnavailableException implements Exception {
  String message = "serverError";

  @override
  String toString() => message;
}