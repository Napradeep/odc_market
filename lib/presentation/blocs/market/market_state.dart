import 'package:equatable/equatable.dart';
import '../../../data/models/vegetable_model.dart';
import '../../../data/models/market_models.dart';

abstract class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object?> get props => [];
}

class MarketInitial extends MarketState {}

class MarketLoading extends MarketState {}

class MarketLoaded extends MarketState {
  final List<VegetableModel> topVegetables;
  final EggModel? eggModel;
  final FuelModel? fuelModel;
  final GoldModel? goldModel;

  const MarketLoaded({
    required this.topVegetables,
    this.eggModel,
    this.fuelModel,
    this.goldModel,
  });

  @override
  List<Object?> get props => [topVegetables, eggModel, fuelModel, goldModel];
}

class MarketError extends MarketState {
  final String message;

  const MarketError(this.message);

  @override
  List<Object> get props => [message];
}
