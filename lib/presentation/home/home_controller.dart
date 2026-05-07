import 'package:get/get.dart';
import '../../data/repositories/market_repository.dart';
import '../../data/models/vegetable_model.dart';

class HomeController extends GetxController {
  final MarketRepository _repo = MarketRepository();

  // Quick summary data for home screen cards
  final RxList<VegetableModel> topVegetables = <VegetableModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString lastUpdated = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    try {
      isLoading(true);
      final vegs = await _repo.getVegetables();
      topVegetables.assignAll(vegs.take(3).toList());

      if (vegs.isNotEmpty && vegs.first.updatedAt != null) {
        final dt = vegs.first.updatedAt!;
        lastUpdated.value =
            '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
      }
    } catch (_) {
      // silent fail on home - user can navigate to detail screens
    } finally {
      isLoading(false);
    }
  }

  @override
  Future<void> refresh() => _loadSummary();
}
