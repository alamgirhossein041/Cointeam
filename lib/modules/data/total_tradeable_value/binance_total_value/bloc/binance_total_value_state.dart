import 'package:coinsnap/modules/portfolio/models/exchanges/binance_get_portfolio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetTotalValueState extends Equatable {}

class GetTotalValueInitialState extends GetTotalValueState {

  @override
  List<Object> get props => [];
}

class GetTotalValueLoadingState extends GetTotalValueState {

  @override
  List<Object> get props => [];
}

class GetTotalValueResponseState extends GetTotalValueState {

  final List<BinanceGetAllModel> binanceGetAllModelList;
  final Map binanceGetPricesMap;

  GetTotalValueResponseState({@required this.binanceGetAllModelList, @required this.binanceGetPricesMap});

  @override
  List<Object> get props => [];
}

class GetTotalValueLoadedState extends GetTotalValueState {

  final Map binanceGetPricesMap;
  final double totalValue;
  final double btcSpecial;
  final double btcQuantity;
  final double usdSpecial;
  final List<BinanceGetAllModel> coinListReceived;

  GetTotalValueLoadedState({@required this.totalValue, @required this.btcSpecial, this.btcQuantity, this.usdSpecial, @required this.coinListReceived, @required this.binanceGetPricesMap});

  @override
  List<Object> get props => null;
}

class GetTotalValueErrorState extends GetTotalValueState {

  final String errorMessage;

  GetTotalValueErrorState({@required this.errorMessage});

  @override
  List<Object> get props => null;
}