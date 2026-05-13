import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vegetable_model.dart';
import '../models/market_models.dart';
import '../../core/constants/app_constants.dart';

class MarketRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _defaultCity = 'oddanchatram';

  // Supported Categories
  static const List<String> categories = [
    'vegetable', 'fruit', 'flower', 'egg', 'fish', 'chicken', 
    'mutton', 'pork', 'beef', 'petrol', 'diesel', 'lpg', 
    'autogas', 'gold', 'silver', 'platinum'
  ];

  Future<Map<String, List<VegetableModel>>> getAllData({String? city}) async {
    final Map<String, List<VegetableModel>> results = {};
    
    // Fetch all in parallel
    final futures = categories.map((cat) => getCategoryData(cat, city: city));
    final lists = await Future.wait(futures);
    
    for (var i = 0; i < categories.length; i++) {
      results[categories[i]] = lists[i];
    }
    
    return results;
  }

  Future<List<VegetableModel>> getCategoryData(String category, {String? city}) async {
    try {
      final doc = await _firestore
          .doc(AppConstants.latestPath(city ?? _defaultCity, category))
          .get();
      return VegetableModel.fromScraperDoc(doc);
    } catch (e) {
      return [];
    }
  }

  // Legacy support for specific methods if needed elsewhere
  Future<List<VegetableModel>> getVegetables({String? city}) => getCategoryData('vegetable', city: city);
  Future<List<VegetableModel>> getFruits({String? city}) => getCategoryData('fruit', city: city);
  Future<List<VegetableModel>> getFlowers({String? city}) => getCategoryData('flower', city: city);
  
  Future<EggModel?> getEgg({String? city}) async {
    final data = await getCategoryData('egg', city: city);
    if (data.isEmpty) return null;
    final item = data.first;
    return EggModel(
      pricePerEgg: item.todayPrice,
      pricePerTray: item.todayPrice * 30,
      pricePer100: item.todayPrice * 100,
      yesterdayPerEgg: item.yesterdayPrice,
      updatedAt: item.updatedAt,
    );
  }

  Future<FuelModel?> getFuel({String? city}) async {
    final petrol = await getCategoryData('petrol', city: city);
    final diesel = await getCategoryData('diesel', city: city);
    
    return FuelModel(
      petrolPrice: petrol.isNotEmpty ? petrol.first.todayPrice : 0,
      dieselPrice: diesel.isNotEmpty ? diesel.first.todayPrice : 0,
      yesterdayPetrol: petrol.isNotEmpty ? petrol.first.yesterdayPrice : 0,
      yesterdayDiesel: diesel.isNotEmpty ? diesel.first.yesterdayPrice : 0,
      updatedAt: petrol.isNotEmpty ? petrol.first.updatedAt : null,
    );
  }

  Future<GoldModel?> getGold({String? city}) async {
    final gold = await getCategoryData('gold', city: city);
    final silver = await getCategoryData('silver', city: city);
    
    double g22 = 0, g24 = 0;
    for (var g in gold) {
      if (g.englishName.contains('22')) g22 = g.todayPrice;
      if (g.englishName.contains('24')) g24 = g.todayPrice;
    }

    return GoldModel(
      gold22k: g22,
      gold24k: g24,
      silver: silver.isNotEmpty ? silver.first.todayPrice : 0,
      yesterdayGold22k: g22,
      yesterdayGold24k: g24,
      yesterdaySilver: silver.isNotEmpty ? silver.first.yesterdayPrice : 0,
      updatedAt: gold.isNotEmpty ? gold.first.updatedAt : null,
    );
  }
  Future<List<VegetableModel>> getMeat({String? city}) async {
    final meatList = <VegetableModel>[];
    try {
      final categories = ['chicken', 'mutton', 'fish'];
      for (var cat in categories) {
        final data = await getCategoryData(cat, city: city);
        meatList.addAll(data);
      }
      return meatList;
    } catch (e) {
      return meatList;
    }
  }
}
