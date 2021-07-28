import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StartupState extends Equatable {}

class StartupInitialState extends StartupState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class StartupLoadingState extends StartupState {

  @override
  List<Object> get props => [];
}

// class StartupCoinListState extends StartupState {
//   // StartupCoinListState({this.coinList});

//   // final List coinList;

//   @override
//   /// TODO: implement props
//   List<Object> get props => null;
// }

// class StartupGlobalStatsState extends StartupState {

//   @override
//   List<Object> get props => [];
// }

class StartupLoadedState extends StartupState {
  StartupLoadedState({this.totalValue, this.coinListData, this.coingeckoModelMap, this.currency,
                      this.coinList, this.btcSpecial, this.ethSpecial, this.binanceGetAllModel,
                      this.usdTotal, this.btcTotal, this.coingeckoModelList, this.securitiesFilter});
  final totalValue;
  final coinListData;
  final coingeckoModelMap;
  final coinList;
  final btcSpecial;
  final ethSpecial;
  final String currency;
  final double usdTotal;
  final double btcTotal;
  final List<BinanceGetAllModel> binanceGetAllModel;
  final List<CoingeckoListTop100Model> coingeckoModelList;
  final List<String> securitiesFilter;

  // StartupLoadedState({this.coinList, this.coinBalancesMap});

  // final List coinList;
  // final coinBalancesMap;

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class StartupErrorState extends StartupState {

  final String errorMessage;

  StartupErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}