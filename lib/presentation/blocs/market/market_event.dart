import 'package:equatable/equatable.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent();

  @override
  List<Object?> get props => [];
}

class LoadMarketData extends MarketEvent {
  final String? city;
  const LoadMarketData({this.city});

  @override
  List<Object?> get props => [city];
}
