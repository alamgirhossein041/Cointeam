import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_state.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:meta/meta.dart';

// class FirestoreGetUserDataBloc extends Bloc<FirestoreGetUserDataEvent, FirestoreGetUserDataState> {
  
  // FirestoreGetUserDataBloc({@required this.repository}) : super(FirestoreGetUserDataInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class CardCoinmarketcapCoinLatestBloc extends Bloc<CardCoinmarketcapCoinLatestEvent, CardCoinmarketcapCoinLatestState> {

  CardCoinmarketcapCoinLatestBloc({@required this.cardCoinmarketcapCoinLatestRepository}) : super(CardCoinmarketcapCoinLatestInitialState());

  CardCoinmarketcapCoinLatestRepositoryImpl cardCoinmarketcapCoinLatestRepository;

  @override
  Stream<CardCoinmarketcapCoinLatestState> mapEventToState(CardCoinmarketcapCoinLatestEvent event) async* {
    if (event is FetchCardCoinmarketcapCoinLatestEvent) {
      yield CardCoinmarketcapCoinLatestLoadingState();

      try {
        var data = await cardCoinmarketcapCoinLatestRepository.getCoinMarketCapCoinLatest();
        yield CardCoinmarketcapCoinLatestLoadedState(coinListMap: data);
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        log(e.toString());
        yield CardCoinmarketcapCoinLatestErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }