import 'package:get/get.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/home/home_binding.dart';
import '../../presentation/vegetables/vegetable_screen.dart';
import '../../presentation/vegetables/vegetable_binding.dart';
import '../../presentation/egg/egg_screen.dart';
import '../../presentation/egg/egg_binding.dart';
import '../../presentation/fuel/fuel_screen.dart';
import '../../presentation/fuel/fuel_binding.dart';
import '../../presentation/gold/gold_screen.dart';
import '../../presentation/gold/gold_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.vegetables,
      page: () => const VegetableScreen(),
      binding: VegetableBinding(),
    ),
    GetPage(
      name: AppRoutes.egg,
      page: () => const EggScreen(),
      binding: EggBinding(),
    ),
    GetPage(
      name: AppRoutes.fuel,
      page: () => const FuelScreen(),
      binding: FuelBinding(),
    ),
    GetPage(
      name: AppRoutes.gold,
      page: () => const GoldScreen(),
      binding: GoldBinding(),
    ),
  ];
}
