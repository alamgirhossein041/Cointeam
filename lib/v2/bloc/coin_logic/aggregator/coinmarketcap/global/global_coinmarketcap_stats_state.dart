import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/chart/global_coinmarketcap_stats_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GlobalCoinmarketcapStatsState extends Equatable {}

class GlobalCoinmarketcapStatsInitialState extends GlobalCoinmarketcapStatsState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class GlobalCoinmarketcapStatsLoadingState extends GlobalCoinmarketcapStatsState {

  @override
  List<Object> get props => [];
}

class GlobalCoinmarketcapStatsLoadedState extends GlobalCoinmarketcapStatsState {

  final GlobalCoinmarketcapStatsModel globalStats;

  GlobalCoinmarketcapStatsLoadedState({this.globalStats});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GlobalCoinmarketcapStatsErrorState extends GlobalCoinmarketcapStatsState {

  final String errorMessage;

  GlobalCoinmarketcapStatsErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}