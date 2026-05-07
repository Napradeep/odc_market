import 'package:get/get.dart';
import '../../data/repositories/market_repository.dart';
import '../../data/models/market_models.dart';

class GoldController extends GetxController {
  final MarketRepository _repo = MarketRepository();
  final Rxn<GoldModel> gold = Rxn<GoldModel>();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listen();
  }

  void _listen() {
    isLoading(true);
    _repo.getGoldStream().listen(
      (data) {
        gold.value = data;
        isLoading(false);
      },
      onError: (e) {
        error(e.toString());
        isLoading(false);
      },
    );
  }
}

class GoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoldController>(() => GoldController());
  }
}
