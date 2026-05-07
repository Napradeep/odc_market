import '../models/vegetable_model.dart';
import '../models/market_models.dart';

class MarketRepository {
  // Use mock data for now since Firebase is not yet configured
  final bool _useMock = true;

  // ─── Vegetables ───────────────────────────────────────────────
  Stream<List<VegetableModel>> getVegetablesStream() {
    if (_useMock) {
      return Stream.value([
        VegetableModel(
            id: '1',
            tamilName: 'தக்காளி',
            englishName: 'Tomato',
            todayPrice: 14,
            yesterdayPrice: 12),
        VegetableModel(
            id: '2',
            tamilName: 'வெங்காயம்',
            englishName: 'Onion',
            todayPrice: 22,
            yesterdayPrice: 25),
        VegetableModel(
            id: '3',
            tamilName: 'உருளைக்கிழங்கு',
            englishName: 'Potato',
            todayPrice: 30,
            yesterdayPrice: 30),
        VegetableModel(
            id: '4',
            tamilName: 'கேரட்',
            englishName: 'Carrot',
            todayPrice: 45,
            yesterdayPrice: 40),
        VegetableModel(
            id: '5',
            tamilName: 'பீன்ஸ்',
            englishName: 'Beans',
            todayPrice: 60,
            yesterdayPrice: 70),
      ]);
    }
    // Real Firestore code (commented out until Firebase is configured)
    /*
    return FirebaseFirestore.instance
        .collection('${AppConstants.marketBase()}/${AppConstants.vegetablesPath}')
        .orderBy('english_name')
        .snapshots()
        .map((snap) => snap.docs.map((d) => VegetableModel.fromFirestore(d)).toList());
    */
    return Stream.value([]);
  }

  Future<List<VegetableModel>> getVegetables() async {
    if (_useMock) {
      return [
        VegetableModel(
            id: '1',
            tamilName: 'தக்காளி',
            englishName: 'Tomato',
            todayPrice: 14,
            yesterdayPrice: 12),
        VegetableModel(
            id: '2',
            tamilName: 'வெங்காயம்',
            englishName: 'Onion',
            todayPrice: 22,
            yesterdayPrice: 25),
        VegetableModel(
            id: '3',
            tamilName: 'உருளைக்கிழங்கு',
            englishName: 'Potato',
            todayPrice: 30,
            yesterdayPrice: 30),
      ];
    }
    return [];
  }

  // ─── Egg ──────────────────────────────────────────────────────
  Stream<EggModel?> getEggStream() {
    if (_useMock) {
      return Stream.value(EggModel(
        pricePerEgg: 5.80,
        pricePerTray: 174,
        pricePer100: 580,
        yesterdayPerEgg: 5.60,
        updatedAt: DateTime.now(),
      ));
    }
    return Stream.value(null);
  }

  Future<EggModel?> getEgg() async {
    return null;
  }

  // ─── Fuel ─────────────────────────────────────────────────────
  Stream<FuelModel?> getFuelStream() {
    if (_useMock) {
      return Stream.value(FuelModel(
        petrolPrice: 102.45,
        dieselPrice: 94.10,
        yesterdayPetrol: 102.45,
        yesterdayDiesel: 93.80,
        updatedAt: DateTime.now(),
      ));
    }
    return Stream.value(null);
  }

  Future<FuelModel?> getFuel() async {
    return null;
  }

  // ─── Gold ─────────────────────────────────────────────────────
  Stream<GoldModel?> getGoldStream() {
    if (_useMock) {
      return Stream.value(GoldModel(
        gold22k: 7250,
        gold24k: 7900,
        silver: 92,
        yesterdayGold22k: 7200,
        yesterdayGold24k: 7850,
        yesterdaySilver: 90,
        updatedAt: DateTime.now(),
      ));
    }
    return Stream.value(null);
  }

  Future<GoldModel?> getGold() async {
    return null;
  }
}
