import 'package:coinsnap/v1/data/repository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetTotalValueState extends Equatable {}

class GetTotalValueInitialState extends GetTotalValueState {

  @override
  /// TODO: stuff
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

// class GetTotalValueCoinListReceivedState extends GetTotalValueState {

//   var coinListReceived;

//   GetTotalValueCoinListReceivedState({@required this.coinListReceived});


//   @override
//   List<Object> get props => [];
// }

class GetTotalValueLoadedState extends GetTotalValueState {

  final double totalValue;
  final double btcSpecial;
  final coinListReceived;

  GetTotalValueLoadedState({@required this.totalValue, @required this.btcSpecial, @required this.coinListReceived});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetTotalValueErrorState extends GetTotalValueState {

  final String errorMessage;

  GetTotalValueErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}