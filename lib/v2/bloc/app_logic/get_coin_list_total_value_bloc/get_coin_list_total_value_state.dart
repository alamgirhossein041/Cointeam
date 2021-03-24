import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetCoinListTotalValueState extends Equatable {}

class GetCoinListTotalValueInitialState extends GetCoinListTotalValueState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class GetCoinListTotalValueLoadingState extends GetCoinListTotalValueState {

  @override
  List<Object> get props => [];
}

// class GetCoinListTotalValueResponseState extends GetCoinListTotalValueState {

//   @override
//   List<Object> get props => [];
// }

class GetCoinListTotalValueLoadedState extends GetCoinListTotalValueState {

  final double totalValue;
  final Map coinBalancesMap;
  final coinListData;
  final List coinList;

  GetCoinListTotalValueLoadedState({this.totalValue, this.coinBalancesMap, this.coinListData, this.coinList});

  /// List<GetTotalValueModel> GetTotalValueModel; /// there is no model /// instead we just add existing models
  
  // List<BinanceGetAllModel> binanceGetAllModel;
  // List<CoinbaseGetAccountModel> coinbaseGetAccountModel;
  // FtxGetBalanceModel ftxGetBalanceModel;
  


  // double totalValue;
  // double btcSpecial;

  // var coinPrice;

  // GetCoinListTotalValueLoadedState({@required this.totalValue, @required this.btcSpecial});


  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetCoinListTotalValueErrorState extends GetCoinListTotalValueState {

  final String errorMessage;

  GetCoinListTotalValueErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}