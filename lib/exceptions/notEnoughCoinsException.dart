class NotEnoughCoinsException  implements Exception{
  NotEnoughCoinsException(this.balance, this.price);

  static final String message = 'notEnoughCoins';
  int balance;
  int price;

  @override
  String toString() => message;
}