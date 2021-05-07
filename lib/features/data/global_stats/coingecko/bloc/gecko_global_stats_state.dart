import 'package:coinsnap/modules/data/global_stats/coingecko/models/gecko_global_stats.dart';
import 'package:equatable/equatable.dart';

abstract class GeckoGlobalStatsState extends Equatable {}

class GeckoGlobalStatsInitialState extends GeckoGlobalStatsState {

  @override
  List<Object> get props => [];
}

class GeckoGlobalStatsLoadingState extends GeckoGlobalStatsState {

  @override
  List<Object> get props => [];
}

class GeckoGlobalStatsLoadedState extends GeckoGlobalStatsState {
  final GeckoGlobalStats geckoGlobalStats;
  final String currency;
  GeckoGlobalStatsLoadedState({this.geckoGlobalStats, this.currency});
  
  @override
  List<Object> get props => [];
}

class GeckoGlobalStatsErrorState extends GeckoGlobalStatsState {
  final String errorMessage;
  GeckoGlobalStatsErrorState({this.errorMessage});

  @override
  List<Object> get props => [];
}