class DailyLimitReachedException  implements Exception{
  final String message = 'dailyLimitReached';
  String getErrorMessage() {
    return message;
  }

  String toString() => message;
}