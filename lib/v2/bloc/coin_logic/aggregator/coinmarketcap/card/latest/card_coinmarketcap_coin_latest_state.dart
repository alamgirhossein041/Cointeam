import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardCoinmarketcapCoinLatestState extends Equatable {}

class CardCoinmarketcapCoinLatestInitialState extends CardCoinmarketcapCoinLatestState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CardCoinmarketcapCoinLatestLoadingState extends CardCoinmarketcapCoinLatestState {

  @override
  List<Object> get props => [];
}

class CardCoinmarketcapCoinLatestLoadedState extends CardCoinmarketcapCoinLatestState {

  final CoinMarketCapCoinLatestModel coinListMap;

  CardCoinmarketcapCoinLatestLoadedState({this.coinListMap});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CardCoinmarketcapCoinLatestErrorState extends CardCoinmarketcapCoinLatestState {

  final String errorMessage;

  CardCoinmarketcapCoinLatestErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}