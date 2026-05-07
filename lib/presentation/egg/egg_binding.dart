import 'package:get/get.dart';
import '../../data/repositories/market_repository.dart';
import '../../data/models/market_models.dart';

class EggController extends GetxController {
  final MarketRepository _repo = MarketRepository();
  final Rxn<EggModel> egg = Rxn<EggModel>();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listen();
  }

  void _listen() {
    isLoading(true);
    _repo.getEggStream().listen(
      (data) {
        egg.value = data;
        isLoading(false);
      },
      onError: (e) {
        error(e.toString());
        isLoading(false);
      },
    );
  }
}

class EggBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EggController>(() => EggController());
  }
}
