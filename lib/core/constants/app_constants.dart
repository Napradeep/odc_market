class AppConstants {
  // Firebase Collection Paths
  static const String districtPath = 'districts';
  static const String dindigulId = 'dindigul';
  static const String marketsPath = 'markets';
  static const String oddanchatramId = 'oddanchatram';
  static const String vegetablesPath = 'vegetables';
  static const String eggPath = 'egg';
  static const String fuelPath = 'fuel';
  static const String goldPath = 'gold';

  // Full Firestore paths helper
  static String marketBase() =>
      '$districtPath/$dindigulId/$marketsPath/$oddanchatramId';

  // AdMob IDs (test IDs - replace with real ones before publish)
  // Android test IDs
  static const String androidBannerAdId =
      'ca-app-pub-3940256099942544/6300978111';
  // iOS test IDs
  static const String iosBannerAdId =
      'ca-app-pub-3940256099942544/2934735716';

  // SharedPrefs Keys
  static const String langKey = 'selected_language';
  static const String lastSyncKey = 'last_sync_time';

  // Misc
  static const String currency = '₹';
  static const String appVersion = '1.0.0';
}
