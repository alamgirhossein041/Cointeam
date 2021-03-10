import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ListTotalValueState extends Equatable {}

class ListTotalValueInitialState extends ListTotalValueState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class ListTotalValueLoadingState extends ListTotalValueState {

  @override
  List<Object> get props => [];
}

class ListTotalValueLoadedState extends ListTotalValueState {

  final CoinMarketCapCoinLatestModel coinList;

  ListTotalValueLoadedState({this.coinList});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class ListTotalValueErrorState extends ListTotalValueState {

  final String errorMessage;

  ListTotalValueErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}