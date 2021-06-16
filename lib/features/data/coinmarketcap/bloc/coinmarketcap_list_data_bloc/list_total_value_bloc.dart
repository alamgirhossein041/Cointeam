import 'package:coinsnap/features/data/coinmarketcap/bloc/coinmarketcap_list_data_bloc/list_total_value_event.dart';
import 'package:coinsnap/features/data/coinmarketcap/bloc/coinmarketcap_list_data_bloc/list_total_value_state.dart';
import 'package:coinsnap/features/data/coinmarketcap/repos/coinmarketcap_coin_data.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class ListTotalValueBloc extends Bloc<ListTotalValueEvent, ListTotalValueState> {
  ListTotalValueBloc({@required this.listTotalValueRepository}) : super(ListTotalValueInitialState());
  CardCoinmarketcapCoinListRepositoryImpl listTotalValueRepository;

  @override
  Stream<ListTotalValueState> mapEventToState(ListTotalValueEvent event) async* {
    if (event is FetchListTotalValueEvent) {
      yield ListTotalValueLoadingState();
      try {
        if(event.coinList[0] == 'Top100') {
          /// TODO: Top 100 Top100 Task
        }
        var data = await listTotalValueRepository.getCoinMarketCapCoinList(event.coinList);
        yield ListTotalValueLoadedState(coinList: event.coinList, cardCoinmarketcapListModel: data);;
      } catch (e) {
        debugPrint(e.toString());
        yield ListTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }