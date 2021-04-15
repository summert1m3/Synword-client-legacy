class ServerException implements Exception {
  String? message = "serverError";

  ServerException([String? message]){
    this.message = message;
  }

  String toString() => message!;
}