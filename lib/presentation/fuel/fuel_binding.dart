import 'package:get/get.dart';
import '../../data/repositories/market_repository.dart';
import '../../data/models/market_models.dart';

class FuelController extends GetxController {
  final MarketRepository _repo = MarketRepository();
  final Rxn<FuelModel> fuel = Rxn<FuelModel>();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listen();
  }

  void _listen() {
    isLoading(true);
    _repo.getFuelStream().listen(
      (data) {
        fuel.value = data;
        isLoading(false);
      },
      onError: (e) {
        error(e.toString());
        isLoading(false);
      },
    );
  }
}

class FuelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FuelController>(() => FuelController());
  }
}
