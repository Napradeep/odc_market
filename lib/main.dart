import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  // Uncomment after adding google-services.json:
  // await Firebase.initializeApp();

  runApp(const SandhaiRateApp());
}

class SandhaiRateApp extends StatelessWidget {
  const SandhaiRateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sandhai Rate - சந்தை விலை',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
      locale: const Locale('ta', 'IN'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
