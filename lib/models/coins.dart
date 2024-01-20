import 'package:velocity_x/velocity_x.dart';

class Coins {
  final num? cash;
  final num? coins;
  final String? uid;

  const Coins({this.cash, this.coins, this.uid});

  factory Coins.fromMap(Map<String, dynamic> map) {
    return Coins(cash: map['cash'], coins: map['coins'], uid: map['uid']);
  }

  Map<String, dynamic> toMap() {
    return {'cash': cash, 'coins': coins, 'uid': uid};
  }

  double get totalAmount {
    // 100 TK Coin = $8
    return (8 * (coins ?? 0) / 100);
  }

  double get usedCoinAmount {
    // 100 TK Coin = $8
    return (8 * getUsedCoins((coins ?? 0).toInt()) / 100);
  }

  static double convertAmountToCoin(double amount) {
    return ((100 * amount) / 8);
  }

  static int getUsedCoins(int coins) {
    if (coins.toString().length == 1) return coins;
    String firstNumber = coins.toString().substring(0, 1);
    String mergedNumber =
        firstNumber + List.generate((coins.length - 1), (_) => '0').join();
    return int.parse(mergedNumber);
  }
}
