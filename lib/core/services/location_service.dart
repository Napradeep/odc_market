import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserLocation {
  final double lat;
  final double lng;
  final String district;
  final String state;
  final String area;

  UserLocation({
    required this.lat,
    required this.lng,
    required this.district,
    required this.state,
    required this.area,
  });

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
        'district': district,
        'state': state,
        'area': area,
      };

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        lat: json['lat'],
        lng: json['lng'],
        district: json['district'],
        state: json['state'],
        area: json['area'],
      );
}

class LocationService {
  final SharedPreferences _prefs;
  static const String _locationCacheKey = 'cached_location';

  LocationService(this._prefs);

  Future<UserLocation> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        
        final userLoc = UserLocation(
          lat: position.latitude,
          lng: position.longitude,
          district: place.subAdministrativeArea ?? place.locality ?? 'Unknown',
          state: place.administrativeArea ?? 'Unknown',
          area: place.subLocality ?? place.street ?? 'Unknown',
        );

        // Cache the location
        await _prefs.setString(_locationCacheKey, jsonEncode(userLoc.toJson()));
        
        return userLoc;
      } else {
         throw Exception('Could not determine area details from coordinates.');
      }
    } catch (e) {
       // Fallback to cache if available and offline/failed
       final cachedLoc = getCachedLocation();
       if (cachedLoc != null) {
         return cachedLoc;
       }
       throw Exception('Failed to get location: $e');
    }
  }

  UserLocation? getCachedLocation() {
    final str = _prefs.getString(_locationCacheKey);
    if (str != null) {
      try {
        return UserLocation.fromJson(jsonDecode(str));
      } catch (_) {}
    }
    return null;
  }
}
