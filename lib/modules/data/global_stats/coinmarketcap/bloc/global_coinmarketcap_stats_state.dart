import 'package:coinsnap/modules/data/global_stats/coinmarketcap/models/global_coinmarketcap_stats_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GlobalCoinmarketcapStatsState extends Equatable {}

class GlobalCoinmarketcapStatsInitialState extends GlobalCoinmarketcapStatsState {

  @override
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
  List<Object> get props => null;
}

class GlobalCoinmarketcapStatsErrorState extends GlobalCoinmarketcapStatsState {

  final String errorMessage;

  GlobalCoinmarketcapStatsErrorState({@required this.errorMessage});

  @override
  List<Object> get props => null;
}