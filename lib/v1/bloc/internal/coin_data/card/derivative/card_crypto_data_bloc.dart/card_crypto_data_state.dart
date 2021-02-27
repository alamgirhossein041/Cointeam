import 'package:coinsnap/v1/data/model/internal/coin_data/card/derivative/card_crypto_data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CardCryptoDataState extends Equatable {}

class CardCryptoDataInitialState extends CardCryptoDataState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CardCryptoDataLoadingState extends CardCryptoDataState {

  @override
  List<Object> get props => [];
}

class CardCryptoDataLoadedState extends CardCryptoDataState {

  final CoinMarketCapCoinLatestModel coinListMap;

  CardCryptoDataLoadedState({this.coinListMap});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CardCryptoDataErrorState extends CardCryptoDataState {

  final String errorMessage;

  CardCryptoDataErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}