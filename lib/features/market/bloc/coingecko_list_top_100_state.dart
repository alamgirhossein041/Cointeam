import 'package:coinsnap/features/market/models/coingecko_list_top_100_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CoingeckoListTop100State extends Equatable {}

class CoingeckoListTop100InitialState extends CoingeckoListTop100State {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CoingeckoListTop100LoadingState extends CoingeckoListTop100State {

  @override
  List<Object> get props => [];
}

class CoingeckoListTop100LoadedState extends CoingeckoListTop100State {

  final List<CoingeckoListTop100Model> coingeckoModelList;

  CoingeckoListTop100LoadedState({this.coingeckoModelList});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CoingeckoListTop100ErrorState extends CoingeckoListTop100State {

  final String errorMessage;

  CoingeckoListTop100ErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}