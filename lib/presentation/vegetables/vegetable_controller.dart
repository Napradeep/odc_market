import 'package:get/get.dart';
import '../../data/repositories/market_repository.dart';
import '../../data/models/vegetable_model.dart';

class VegetableController extends GetxController {
  final MarketRepository _repo = MarketRepository();

  final RxList<VegetableModel> vegetables = <VegetableModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;

  List<VegetableModel> get filtered {
    if (searchQuery.isEmpty) return vegetables;
    final q = searchQuery.value.toLowerCase();
    return vegetables
        .where((v) =>
            v.englishName.toLowerCase().contains(q) ||
            v.tamilName.contains(q))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    _listenToVegetables();
  }

  void _listenToVegetables() {
    isLoading(true);
    _repo.getVegetablesStream().listen(
      (list) {
        vegetables.assignAll(list);
        isLoading(false);
        error('');
      },
      onError: (e) {
        error(e.toString());
        isLoading(false);
      },
    );
  }

  void search(String q) => searchQuery(q);
}
