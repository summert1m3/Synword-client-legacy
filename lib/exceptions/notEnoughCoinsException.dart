class NotEnoughCoinsException  implements Exception{
  static final String message = 'notEnoughCoins';

  @override
  String toString() => message;
}