import 'package:coinsnap/modules/app_load/models/coingecko_list_250.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CoingeckoList250State extends Equatable {}

class CoingeckoList250InitialState extends CoingeckoList250State {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CoingeckoList250LoadingState extends CoingeckoList250State {

  @override
  List<Object> get props => [];
}

class CoingeckoList250LoadedState extends CoingeckoList250State {

  final List<CoingeckoList250Model> coingeckoModelList;
  final Map<String, dynamic> coingeckoMap;

  CoingeckoList250LoadedState({this.coingeckoModelList, this.coingeckoMap});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CoingeckoList250ErrorState extends CoingeckoList250State {

  final String errorMessage;

  CoingeckoList250ErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}