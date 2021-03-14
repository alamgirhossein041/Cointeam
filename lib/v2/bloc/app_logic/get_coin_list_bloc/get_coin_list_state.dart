import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetCoinListState extends Equatable {}

class GetCoinListInitialState extends GetCoinListState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class GetCoinListLoadingState extends GetCoinListState {

  @override
  List<Object> get props => [];
}

class GetCoinListCoinListState extends GetCoinListState {
  GetCoinListCoinListState({this.coinList});

  final List coinList;

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetCoinListLoadedState extends GetCoinListState {

  GetCoinListLoadedState({this.coinList, this.coinBalancesMap});

  final List coinList;
  final coinBalancesMap;

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetCoinListErrorState extends GetCoinListState {

  final String errorMessage;

  GetCoinListErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}