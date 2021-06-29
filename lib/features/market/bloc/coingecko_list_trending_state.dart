import 'package:coinsnap/features/market/models/coingecko_list_trending_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CoingeckoListTrendingState extends Equatable {}

class CoingeckoListTrendingInitialState extends CoingeckoListTrendingState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CoingeckoListTrendingLoadingState extends CoingeckoListTrendingState {

  @override
  List<Object> get props => [];
}

class CoingeckoListTrendingLoadedState extends CoingeckoListTrendingState {

  final List<CoingeckoListTrendingModel> coingeckoModelList;

  CoingeckoListTrendingLoadedState({this.coingeckoModelList});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CoingeckoListTrendingErrorState extends CoingeckoListTrendingState {

  final String errorMessage;

  CoingeckoListTrendingErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}