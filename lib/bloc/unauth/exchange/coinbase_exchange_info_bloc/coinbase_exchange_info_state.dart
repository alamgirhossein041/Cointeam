import 'package:coinsnap/data/model/unauth/exchange/coinbase_exchange_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CoinbaseExchangeInfoState extends Equatable {}

class CoinbaseExchangeInfoInitialState extends CoinbaseExchangeInfoState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CoinbaseExchangeInfoLoadingState extends CoinbaseExchangeInfoState {

  @override
  List<Object> get props => [];
}

class CoinbaseExchangeInfoLoadedState extends CoinbaseExchangeInfoState {

  List<CoinbaseExchangeInfoModel> coinbaseExchangeInfoModel;

  CoinbaseExchangeInfoLoadedState({@required this.coinbaseExchangeInfoModel});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CoinbaseExchangeInfoErrorState extends CoinbaseExchangeInfoState {

  String errorMessage;

  CoinbaseExchangeInfoErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}