import 'package:coinsnap/v1/data/model/auth/get_all/binance_get_all_model.dart';
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

  List<BinanceGetAllModel> binanceGetAllModel;

  BinanceGetAllLoadedState({@required this.binanceGetAllModel});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class BinanceGetAllErrorState extends BinanceGetAllState {

  String errorMessage;

  BinanceGetAllErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}