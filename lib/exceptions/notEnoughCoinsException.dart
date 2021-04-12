class NotEnoughCoinsException  implements Exception{
  static final String message = 'notEnoughCoins';
  String getErrorMessage() {
    return message;
  }

  String toString() => message;
}