import 'package:coinsnap/modules/categories/top100/coinmarketcap_top100_data_bloc/top100_total_value_event.dart';
import 'package:coinsnap/modules/categories/top100/coinmarketcap_top100_data_bloc/top100_total_value_state.dart';
import 'package:coinsnap/modules/categories/top100/repos/coinmarketcap_top100.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
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