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

  static EggModel? fromScraperDoc(DocumentSnapshot doc) {
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    final rates = data['rates'] as List? ?? [];
    if (rates.isEmpty) return null;

    final updatedAtStr = data['scraped_at'] as String?;
    final updatedAt = updatedAtStr != null ? DateTime.tryParse(updatedAtStr) : null;

    // Find the egg item
    final eggData = rates.firstWhere(
      (r) => (r['item'] as String).toLowerCase().contains('egg'),
      orElse: () => rates.first,
    );

    final price = (eggData['price'] ?? 0).toDouble();

    return EggModel(
      pricePerEgg: price,
      pricePerTray: price * 30,
      pricePer100: price * 100,
      yesterdayPerEgg: price, // No history in latest doc
      updatedAt: updatedAt,
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

  static FuelModel? fromScraperDoc(DocumentSnapshot petrolDoc, DocumentSnapshot dieselDoc) {
    if (!petrolDoc.exists && !dieselDoc.exists) return null;
    
    double petrol = 0;
    double diesel = 0;
    DateTime? updatedAt;

    if (petrolDoc.exists) {
      final data = petrolDoc.data() as Map<String, dynamic>;
      final rates = data['rates'] as List? ?? [];
      if (rates.isNotEmpty) {
        petrol = (rates[0]['price'] ?? 0).toDouble();
      }
      final upStr = data['scraped_at'] as String?;
      if (upStr != null) updatedAt = DateTime.tryParse(upStr);
    }

    if (dieselDoc.exists) {
      final data = dieselDoc.data() as Map<String, dynamic>;
      final rates = data['rates'] as List? ?? [];
      if (rates.isNotEmpty) {
        diesel = (rates[0]['price'] ?? 0).toDouble();
      }
    }

    return FuelModel(
      petrolPrice: petrol,
      dieselPrice: diesel,
      yesterdayPetrol: petrol,
      yesterdayDiesel: diesel,
      updatedAt: updatedAt,
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

  static GoldModel? fromScraperDoc(DocumentSnapshot goldDoc, DocumentSnapshot silverDoc) {
    if (!goldDoc.exists && !silverDoc.exists) return null;

    double g22 = 0;
    double g24 = 0;
    double sil = 0;
    DateTime? updatedAt;

    if (goldDoc.exists) {
      final data = goldDoc.data() as Map<String, dynamic>;
      final rates = data['rates'] as List? ?? [];
      for (var r in rates) {
        final name = (r['item'] as String).toLowerCase();
        final price = (r['price'] ?? 0).toDouble();
        if (name.contains('22')) g22 = price;
        if (name.contains('24')) g24 = price;
      }
      final upStr = data['scraped_at'] as String?;
      if (upStr != null) updatedAt = DateTime.tryParse(upStr);
    }

    if (silverDoc.exists) {
      final data = silverDoc.data() as Map<String, dynamic>;
      final rates = data['rates'] as List? ?? [];
      if (rates.isNotEmpty) {
        sil = (rates[0]['price'] ?? 0).toDouble();
      }
    }

    return GoldModel(
      gold22k: g22,
      gold24k: g24,
      silver: sil,
      yesterdayGold22k: g22,
      yesterdayGold24k: g24,
      yesterdaySilver: sil,
      updatedAt: updatedAt,
    );
  }
}
