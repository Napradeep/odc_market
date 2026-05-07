import 'package:get/get.dart';
import 'vegetable_controller.dart';

class VegetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VegetableController>(() => VegetableController());
  }
}
