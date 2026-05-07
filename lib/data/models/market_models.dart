import 'package:cloud_firestore/cloud_firestore.dart';

class EggModel {
  final double pricePerEgg;
  final double pricePerTray; // 30 eggs
  final double pricePer100;
  final double yesterdayPerEgg;
  final DateTime? updatedAt;

  EggModel({
    required this.pricePerEgg,
    required this.pricePerTray,
    required this.pricePer100,
    required this.yesterdayPerEgg,
    this.updatedAt,
  });

  double get priceDiff => pricePerEgg - yesterdayPerEgg;
  bool get isPriceUp => priceDiff > 0;
  bool get isPriceDown => priceDiff < 0;
  bool get isPriceStable => priceDiff == 0;

  factory EggModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final perEgg = (data['price_per_egg'] ?? 0).toDouble();
    return EggModel(
      pricePerEgg: perEgg,
      pricePerTray: (data['price_per_tray'] ?? perEgg * 30).toDouble(),
      pricePer100: (data['price_per_100'] ?? perEgg * 100).toDouble(),
      yesterdayPerEgg: (data['yesterday_price'] ?? 0).toDouble(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
    );
  }
}

class FuelModel {
  final double petrolPrice;
  final double dieselPrice;
  final double yesterdayPetrol;
  final double yesterdayDiesel;
  final DateTime? updatedAt;

  FuelModel({
    required this.petrolPrice,
    required this.dieselPrice,
    required this.yesterdayPetrol,
    required this.yesterdayDiesel,
    this.updatedAt,
  });

  double get petrolDiff => petrolPrice - yesterdayPetrol;
  double get dieselDiff => dieselPrice - yesterdayDiesel;
  bool get isPetrolUp => petrolDiff > 0;
  bool get isDieselUp => dieselDiff > 0;

  factory FuelModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FuelModel(
      petrolPrice: (data['petrol'] ?? 0).toDouble(),
      dieselPrice: (data['diesel'] ?? 0).toDouble(),
      yesterdayPetrol: (data['yesterday_petrol'] ?? 0).toDouble(),
      yesterdayDiesel: (data['yesterday_diesel'] ?? 0).toDouble(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
    );
  }
}

class GoldModel {
  final double gold22k;
  final double gold24k;
  final double silver;
  final double yesterdayGold22k;
  final double yesterdayGold24k;
  final double yesterdaySilver;
  final DateTime? updatedAt;

  GoldModel({
    required this.gold22k,
    required this.gold24k,
    required this.silver,
    required this.yesterdayGold22k,
    required this.yesterdayGold24k,
    required this.yesterdaySilver,
    this.updatedAt,
  });

  double get gold22kDiff => gold22k - yesterdayGold22k;
  double get gold24kDiff => gold24k - yesterdayGold24k;
  double get silverDiff => silver - yesterdaySilver;

  factory GoldModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GoldModel(
      gold22k: (data['gold_22k'] ?? 0).toDouble(),
      gold24k: (data['gold_24k'] ?? 0).toDouble(),
      silver: (data['silver'] ?? 0).toDouble(),
      yesterdayGold22k: (data['yesterday_gold_22k'] ?? 0).toDouble(),
      yesterdayGold24k: (data['yesterday_gold_24k'] ?? 0).toDouble(),
      yesterdaySilver: (data['yesterday_silver'] ?? 0).toDouble(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
    );
  }
}
