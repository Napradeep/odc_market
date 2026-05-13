import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/location_service.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;

  LocationBloc({required LocationService locationService})
      : _locationService = locationService,
        super(LocationInitial()) {
    on<LoadLocation>(_onLoadLocation);
    on<UpdateMarketCity>(_onUpdateMarketCity);
  }

  Future<void> _onLoadLocation(
    LoadLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      final location = await _locationService.getCurrentLocation();
      
      String marketCity = 'oddanchatram';
      String marketCityName = 'Oddanchatram';
      
      // If district is Dindigul, explicitly set market to Oddanchatram
      if (location.district.toLowerCase().contains('dindigul')) {
        marketCity = 'oddanchatram';
        marketCityName = 'Oddanchatram';
      }

      emit(LocationLoaded(
        location: location,
        marketCity: marketCity,
        marketCityName: marketCityName,
      ));
    } catch (e) {
      final cached = _locationService.getCachedLocation();
      if (cached != null) {
        emit(LocationLoaded(location: cached));
      } else {
        // Emit Loaded with null location to allow manual city selection even if GPS fails
        emit(const LocationLoaded(location: null));
      }
    }
  }

  void _onUpdateMarketCity(
    UpdateMarketCity event,
    Emitter<LocationState> emit,
  ) {
    if (state is LocationLoaded) {
      emit((state as LocationLoaded).copyWith(
        marketCity: event.citySlug,
        marketCityName: event.cityName,
      ));
    } else {
      emit(LocationLoaded(
        location: null,
        marketCity: event.citySlug,
        marketCityName: event.cityName,
      ));
    }
  }
}
