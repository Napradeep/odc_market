import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/market_repository.dart';
import 'market_event.dart';
import 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketRepository _repository;

  MarketBloc({required MarketRepository repository})
      : _repository = repository,
        super(MarketInitial()) {
    on<LoadMarketData>(_onLoadMarketData);
  }

  Future<void> _onLoadMarketData(
    LoadMarketData event,
    Emitter<MarketState> emit,
  ) async {
    emit(MarketLoading());
    try {
      final city = event.city;
      final allData = await _repository.getAllData(city: city);
      final vegs = allData['vegetable'] ?? [];
      final egg = await _repository.getEgg(city: city);
      final fuel = await _repository.getFuel(city: city);
      final gold = await _repository.getGold(city: city);
 
      emit(MarketLoaded(
        topVegetables: vegs.take(5).toList(),
        allData: allData,
        eggModel: egg,
        fuelModel: fuel,
        goldModel: gold,
      ));
    } catch (e) {
      emit(MarketError(e.toString()));
    }
  }
}
