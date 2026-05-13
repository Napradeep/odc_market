import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/location_service.dart';
import '../presentation/blocs/location/location_bloc.dart';
import '../presentation/blocs/market/market_bloc.dart';
import '../presentation/blocs/language/language_bloc.dart';
import '../data/repositories/market_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Core / Services
  sl.registerLazySingleton(() => LocationService(sl()));

  // Repositories
  sl.registerLazySingleton(() => MarketRepository());

  // BLoCs
  sl.registerFactory(
    () => LanguageBloc(prefs: sl()),
  );
  sl.registerFactory(
    () => LocationBloc(locationService: sl()),
  );
  sl.registerFactory(
    () => MarketBloc(repository: sl()),
  );
}
