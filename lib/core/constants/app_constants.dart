class AppConstants {
  // Firebase Collection Paths
  static const String ratesCollection = 'rates';
  static const String latestDoc = 'latest';
  
  // Categories matching scraper
  static const String vegCat = 'vegetable';
  static const String fruitCat = 'fruit';
  static const String flowerCat = 'flower';
  static const String eggCat = 'egg';
  static const String fuelCat = 'petrol'; // scraper uses petrol/diesel separately but often grouped
  static const String goldCat = 'gold';

  // Helper for dynamic paths
  static String latestPath(String city, String category) =>
      '$ratesCollection/$city/$category/$latestDoc';

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

  // Market Cities - All 38 Districts of Tamil Nadu + Oddanchatram
  static const List<Map<String, String>> marketCities = [
    {'name': 'Oddanchatram', 'slug': 'oddanchatram', 'tamil': 'ஒட்டன்சத்திரம்'},
    {'name': 'Chennai', 'slug': 'chennai', 'tamil': 'சென்னை'},
    {'name': 'Madurai', 'slug': 'madurai', 'tamil': 'மதுரை'},
    {'name': 'Coimbatore', 'slug': 'coimbatore', 'tamil': 'கோயம்புத்தூர்'},
    {'name': 'Trichy', 'slug': 'tiruchirappalli', 'tamil': 'திருச்சி'},
    {'name': 'Salem', 'slug': 'salem', 'tamil': 'சேலம்'},
    {'name': 'Ariyalur', 'slug': 'ariyalur', 'tamil': 'அரியலூர்'},
    {'name': 'Chengalpattu', 'slug': 'chengalpattu', 'tamil': 'செங்கல்பட்டு'},
    {'name': 'Cuddalore', 'slug': 'cuddalore', 'tamil': 'கடலூர்'},
    {'name': 'Dharmapuri', 'slug': 'dharmapuri', 'tamil': 'தர்மபுரி'},
    {'name': 'Dindigul', 'slug': 'dindigul', 'tamil': 'திண்டுக்கல்'},
    {'name': 'Erode', 'slug': 'erode', 'tamil': 'ஈரோடு'},
    {'name': 'Kallakurichi', 'slug': 'kallakurichi', 'tamil': 'கள்ளக்குறிச்சி'},
    {'name': 'Kanchipuram', 'slug': 'kanchipuram', 'tamil': 'காஞ்சிபுரம்'},
    {'name': 'Kanyakumari', 'slug': 'kanyakumari', 'tamil': 'கன்னியாகுமரி'},
    {'name': 'Karur', 'slug': 'karur', 'tamil': 'கரூர்'},
    {'name': 'Krishnagiri', 'slug': 'krishnagiri', 'tamil': 'கிருஷ்ணகிரி'},
    {'name': 'Mayiladuthurai', 'slug': 'mayiladuthurai', 'tamil': 'மயிலாடுதுறை'},
    {'name': 'Nagapattinam', 'slug': 'nagapattinam', 'tamil': 'நாகப்பட்டினம்'},
    {'name': 'Namakkal', 'slug': 'namakkal', 'tamil': 'நாமக்கல்'},
    {'name': 'Nilgiris', 'slug': 'nilgiris', 'tamil': 'நீலகிரி'},
    {'name': 'Perambalur', 'slug': 'perambalur', 'tamil': 'பெரம்பலூர்'},
    {'name': 'Pudukkottai', 'slug': 'pudukkottai', 'tamil': 'புதுக்கோட்டை'},
    {'name': 'Ramanathapuram', 'slug': 'ramanathapuram', 'tamil': 'இராமநாதபுரம்'},
    {'name': 'Ranipet', 'slug': 'ranipet', 'tamil': 'ராணிப்பேட்டை'},
    {'name': 'Sivaganga', 'slug': 'sivaganga', 'tamil': 'சிவகங்கை'},
    {'name': 'Tenkasi', 'slug': 'tenkasi', 'tamil': 'தென்காசி'},
    {'name': 'Thanjavur', 'slug': 'thanjavur', 'tamil': 'தஞ்சாவூர்'},
    {'name': 'Theni', 'slug': 'theni', 'tamil': 'தேனி'},
    {'name': 'Thoothukudi', 'slug': 'thoothukudi', 'tamil': 'தூத்துக்குடி'},
    {'name': 'Tirunelveli', 'slug': 'tirunelveli', 'tamil': 'திருநெல்வேலி'},
    {'name': 'Tirupathur', 'slug': 'tirupathur', 'tamil': 'திருப்பத்தூர்'},
    {'name': 'Tiruppur', 'slug': 'tiruppur', 'tamil': 'திருப்பூர்'},
    {'name': 'Tiruvallur', 'slug': 'tiruvallur', 'tamil': 'திருவள்ளூர்'},
    {'name': 'Tiruvannamalai', 'slug': 'tiruvannamalai', 'tamil': 'திருவண்ணாமலை'},
    {'name': 'Tiruvarur', 'slug': 'tiruvarur', 'tamil': 'திருவாரூர்'},
    {'name': 'Vellore', 'slug': 'vellore', 'tamil': 'வேலூர்'},
    {'name': 'Viluppuram', 'slug': 'viluppuram', 'tamil': 'விழுப்புரம்'},
    {'name': 'Virudhunagar', 'slug': 'virudhunagar', 'tamil': 'விருதுநகர்'},
  ];

  // Misc
  static const String currency = '₹';
  static const String appVersion = '1.0.0';
}
