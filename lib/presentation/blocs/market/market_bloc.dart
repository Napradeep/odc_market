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
      final vegs = await _repository.getVegetables();
      final egg = await _repository.getEgg();
      final fuel = await _repository.getFuel();
      final gold = await _repository.getGold();

      emit(MarketLoaded(
        topVegetables: vegs.take(5).toList(),
        eggModel: egg,
        fuelModel: fuel,
        goldModel: gold,
      ));
    } catch (e) {
      emit(MarketError(e.toString()));
    }
  }
}
