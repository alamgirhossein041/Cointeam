import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ListTotalValueState extends Equatable {}

class ListTotalValueInitialState extends ListTotalValueState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class ListTotalValueLoadingState extends ListTotalValueState {

  @override
  List<Object> get props => [];
}

class ListTotalValueResponseState extends ListTotalValueState {

  // final List<BinanceGetAllModel> binanceGetAllModelList;
  // final Map binanceGetPricesMap;

  // ListTotalValueResponseState({@required this.binanceGetAllModelList, @required this.binanceGetPricesMap});

  @override
  List<Object> get props => [];
}

class ListTotalValueLoadedState extends ListTotalValueState {

  final List coinList;
  final CardCoinmarketcapListModel cardCoinmarketcapListModel;

  ListTotalValueLoadedState({this.coinList, this.cardCoinmarketcapListModel});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class ListTotalValueErrorState extends ListTotalValueState {

  final String errorMessage;

  ListTotalValueErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}