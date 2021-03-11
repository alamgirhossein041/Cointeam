import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_state.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:meta/meta.dart';

// class FirestoreGetUserDataBloc extends Bloc<FirestoreGetUserDataEvent, FirestoreGetUserDataState> {
  
  // FirestoreGetUserDataBloc({@required this.repository}) : super(FirestoreGetUserDataInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class ListTotalValueBloc extends Bloc<ListTotalValueEvent, ListTotalValueState> {

  ListTotalValueBloc({@required this.listTotalValueRepository}) : super(ListTotalValueInitialState());

  CardCoinmarketcapCoinListRepositoryImpl listTotalValueRepository;

  @override
  Stream<ListTotalValueState> mapEventToState(ListTotalValueEvent event) async* {
    if (event is FetchListTotalValueEvent) {
      yield ListTotalValueLoadingState();

      try {
        var data = await listTotalValueRepository.getCoinMarketCapCoinList(event.coinList);
        // yield ListTotalValueLoadedState(coinListMap: data);
        yield ListTotalValueLoadedState(coinList: data);
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        log(e.toString());
        yield ListTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }