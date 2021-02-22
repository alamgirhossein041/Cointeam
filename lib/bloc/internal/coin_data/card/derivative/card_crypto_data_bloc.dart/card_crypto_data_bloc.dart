import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_event.dart';
import 'package:coinsnap/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_state.dart';
import 'package:coinsnap/data/repository/internal/coin_data/card/coinmarketcap_coin_latest.dart';
import 'package:meta/meta.dart';

// class FirestoreGetUserDataBloc extends Bloc<FirestoreGetUserDataEvent, FirestoreGetUserDataState> {
  
  // FirestoreGetUserDataBloc({@required this.repository}) : super(FirestoreGetUserDataInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class CardCryptoDataBloc extends Bloc<CardCryptoDataEvent, CardCryptoDataState> {

  CardCryptoDataBloc({@required this.cardCryptoDataRepository}) : super(CardCryptoDataInitialState());

  CoinMarketCapCoinLatestRepositoryImpl cardCryptoDataRepository;

  @override
  Stream<CardCryptoDataState> mapEventToState(CardCryptoDataEvent event) async* {
    if (event is FetchCardCryptoDataEvent) {
      yield CardCryptoDataLoadingState();

      try {

        log("Hello bzzz");

        var data = await cardCryptoDataRepository.getCoinMarketCapCoinLatest();
        log("Hello + " + data.toString());
        yield CardCryptoDataLoadedState(coinListMap: data);
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        log(e.toString());
        yield CardCryptoDataErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }