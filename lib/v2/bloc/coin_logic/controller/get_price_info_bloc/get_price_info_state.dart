import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetPriceInfoState extends Equatable {}

class GetPriceInfoInitialState extends GetPriceInfoState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class GetPriceInfoLoadingState extends GetPriceInfoState {

  @override
  List<Object> get props => [];
}

class GetPriceInfoLoadedState extends GetPriceInfoState {

  /// List<GetTotalValueModel> GetTotalValueModel; /// there is no model /// instead we just add existing models
  
  // List<BinanceGetAllModel> binanceGetAllModel;
  // List<CoinbaseGetAccountModel> coinbaseGetAccountModel;
  // FtxGetBalanceModel ftxGetBalanceModel;
  


  // double totalValue;
  // double btcSpecial;

  var coinPrice;

  // GetPriceInfoLoadedState({@required this.totalValue, @required this.btcSpecial});
  GetPriceInfoLoadedState({@required this.coinPrice});


  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetPriceInfoErrorState extends GetPriceInfoState {

  final String errorMessage;

  GetPriceInfoErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}