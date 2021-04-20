import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/top100/top100_total_value_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/top100/top100_total_value_state.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:meta/meta.dart';

class Top100TotalValueBloc extends Bloc<Top100TotalValueEvent, Top100TotalValueState> {

  Top100TotalValueBloc({@required this.cardCoinmarketcapCoinLatestRepository}) : super(Top100TotalValueInitialState());

  CardCoinmarketcapCoinLatestRepositoryImpl cardCoinmarketcapCoinLatestRepository;

  @override
  Stream<Top100TotalValueState> mapEventToState(Top100TotalValueEvent event) async* {
    if (event is FetchTop100TotalValueEvent) {
      yield Top100TotalValueLoadingState();

      try {
        var data = await cardCoinmarketcapCoinLatestRepository.getCoinMarketCapCoinLatest();
        List coinList = [];
        data.data.forEach((v) =>
          coinList.add(v.symbol)
        );

        yield Top100TotalValueLoadedState(coinList: coinList);
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        debugPrint(e.toString());
        yield Top100TotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }