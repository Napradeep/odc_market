import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LoadLocation extends LocationEvent {}

class UpdateMarketCity extends LocationEvent {
  final String citySlug;
  final String cityName;

  const UpdateMarketCity(this.citySlug, this.cityName);

  @override
  List<Object?> get props => [citySlug, cityName];
}
