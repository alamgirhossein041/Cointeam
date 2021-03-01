import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BinanceGetAllState extends Equatable {}

class BinanceGetAllInitialState extends BinanceGetAllState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class BinanceGetAllLoadingState extends BinanceGetAllState {

  @override
  List<Object> get props => [];
}

class BinanceGetAllLoadedState extends BinanceGetAllState {
  var binanceGetAll;
  // BinanceGetAllLoadedState({@required this.coinPrice});
  BinanceGetAllLoadedState({this.binanceGetAll});


  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class BinanceGetAllErrorState extends BinanceGetAllState {

  final String errorMessage;

  BinanceGetAllErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}