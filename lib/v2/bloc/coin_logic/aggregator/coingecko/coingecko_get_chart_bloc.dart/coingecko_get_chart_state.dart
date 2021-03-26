import 'package:coinsnap/v2/model/coin_model/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CoingeckoGetChartState extends Equatable {}

class CoingeckoGetChartInitialState extends CoingeckoGetChartState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CoingeckoGetChartLoadingState extends CoingeckoGetChartState {

  @override
  List<Object> get props => [];
}

class CoingeckoGetChartLoadedState extends CoingeckoGetChartState {
  final List coingeckoGetChartDataList;
  final timeSelection;

  // final List<CoingeckoList250Model> coingeckoGetChartModel;
  // final Map<String, dynamic> coingeckoGetChartMap;

  CoingeckoGetChartLoadedState({this.coingeckoGetChartDataList, this.timeSelection});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CoingeckoGetChartErrorState extends CoingeckoGetChartState {

  final String errorMessage;

  CoingeckoGetChartErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}