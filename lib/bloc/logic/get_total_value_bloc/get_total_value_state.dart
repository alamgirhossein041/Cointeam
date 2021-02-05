import 'package:coinsnap/data/model/auth/get_all/binance_get_all_model.dart';
import 'package:coinsnap/data/model/auth/get_all/coinbase_get_account_model.dart';
import 'package:coinsnap/data/model/auth/get_all/ftx_get_balance_model.dart';
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

class GetTotalValueLoadedState extends GetTotalValueState {

  /// List<GetTotalValueModel> GetTotalValueModel; /// there is no model /// instead we just add existing models
  
  // List<BinanceGetAllModel> binanceGetAllModel;
  // List<CoinbaseGetAccountModel> coinbaseGetAccountModel;
  // FtxGetBalanceModel ftxGetBalanceModel;
  


  double totalValue;
  double btcSpecial;

  GetTotalValueLoadedState({@required this.totalValue, @required this.btcSpecial});


  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetTotalValueErrorState extends GetTotalValueState {

  String errorMessage;

  GetTotalValueErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}