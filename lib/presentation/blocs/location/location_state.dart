import 'package:equatable/equatable.dart';
import '../../../core/services/location_service.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final UserLocation? location;
  final String marketCity;
  final String marketCityName;

  const LocationLoaded({
    this.location,
    this.marketCity = 'oddanchatram',
    this.marketCityName = 'Oddanchatram',
  });

  @override
  List<Object?> get props => [location, marketCity, marketCityName];

  LocationLoaded copyWith({
    UserLocation? location,
    String? marketCity,
    String? marketCityName,
  }) {
    return LocationLoaded(
      location: location ?? this.location,
      marketCity: marketCity ?? this.marketCity,
      marketCityName: marketCityName ?? this.marketCityName,
    );
  }
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object?> get props => [message];
}
