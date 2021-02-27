import 'package:coinsnap/v1/data/model/unauth/exchange/binance_exchange_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BinanceExchangeInfoState extends Equatable {}

class BinanceExchangeInfoInitialState extends BinanceExchangeInfoState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class BinanceExchangeInfoLoadingState extends BinanceExchangeInfoState {

  @override
  List<Object> get props => [];
}

class BinanceExchangeInfoLoadedState extends BinanceExchangeInfoState {

  List<BinanceExchangeInfoModel> binanceExchangeInfoModel;

  BinanceExchangeInfoLoadedState({@required this.binanceExchangeInfoModel});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class BinanceExchangeInfoErrorState extends BinanceExchangeInfoState {

  String errorMessage;

  BinanceExchangeInfoErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}