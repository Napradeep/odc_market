import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/theme/app_theme.dart';
import 'di/injection.dart' as di;
import 'presentation/blocs/location/location_bloc.dart';
import 'presentation/blocs/location/location_event.dart';
import 'presentation/blocs/market/market_bloc.dart';
import 'presentation/blocs/market/market_event.dart';
import 'presentation/blocs/language/language_bloc.dart';
import 'presentation/blocs/language/language_event.dart';
import 'presentation/blocs/language/language_state.dart';
import 'presentation/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  await di.init();

  runApp(const SandhaiRateApp());
}

class SandhaiRateApp extends StatelessWidget {
  const SandhaiRateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<LanguageBloc>()..add(LoadLanguage()),
        ),
        BlocProvider(
          create: (_) => di.sl<LocationBloc>()..add(LoadLocation()),
        ),
        BlocProvider(
          create: (_) => di.sl<MarketBloc>()..add(LoadMarketData()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Sandhai Rate - சந்தை விலை',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
            locale: state.isEnglish
                ? const Locale('en', 'US')
                : const Locale('ta', 'IN'),
            supportedLocales: const [Locale('ta', 'IN'), Locale('en', 'US')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
