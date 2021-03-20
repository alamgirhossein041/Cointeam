import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Top100TotalValueState extends Equatable {}

class Top100TotalValueInitialState extends Top100TotalValueState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class Top100TotalValueLoadingState extends Top100TotalValueState {

  @override
  List<Object> get props => [];
}

class Top100TotalValueLoadedState extends Top100TotalValueState {

  final List<dynamic> coinList;

  Top100TotalValueLoadedState({this.coinList});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class Top100TotalValueErrorState extends Top100TotalValueState {

  final String errorMessage;

  Top100TotalValueErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}