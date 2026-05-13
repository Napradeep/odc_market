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
  }

  Future<void> _onLoadLocation(
    LoadLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      final location = await _locationService.getCurrentLocation();
      emit(LocationLoaded(location));
    } catch (e) {
      // Try to fallback to cached location
      final cached = _locationService.getCachedLocation();
      if (cached != null) {
        emit(LocationLoaded(cached));
      } else {
        emit(LocationError(e.toString()));
      }
    }
  }
}
