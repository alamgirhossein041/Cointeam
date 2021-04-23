import 'package:coinsnap/modules/app_load/bloc/coingecko_list_250_bloc/coingecko_list_250_event.dart';
import 'package:coinsnap/modules/app_load/bloc/coingecko_list_250_bloc/coingecko_list_250_state.dart';
import 'package:coinsnap/modules/app_load/repos/coingecko_list_250.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class CoingeckoList250Bloc extends Bloc<CoingeckoList250Event, CoingeckoList250State> {

  CoingeckoList250Bloc({@required this.coingeckoList250Repository}) : super(CoingeckoList250InitialState());

  CoingeckoList250RepositoryImpl coingeckoList250Repository;

  @override
  Stream<CoingeckoList250State> mapEventToState(CoingeckoList250Event event) async* {
    if (event is FetchCoingeckoList250Event) {
      yield CoingeckoList250LoadingState();

      try {
        /// ### data is a list of CoingeckoList250Model ### ///
        
        List<dynamic> data = await Future.wait([coingeckoList250Repository.getCoinMarketCapCoinLatest('1'), coingeckoList250Repository.getCoinMarketCapCoinLatest('2'),
            coingeckoList250Repository.getCoinMarketCapCoinLatest('3'), coingeckoList250Repository.getCoinMarketCapCoinLatest('4'), coingeckoList250Repository.getCoinMarketCapCoinLatest('5')]);

        // List<CoingeckoList250Model> data = 

        Map<String, dynamic> coingeckoMap = {};

        var newList = data[0] + data[1] + data[2] + data[3] + data[4];

        newList.forEach((coingeckoModel) => coingeckoMap[coingeckoModel.symbol] = coingeckoModel);

        List<dynamic> data2 = await Future.wait([coingeckoList250Repository.getCoinMarketCapCoinLatest('6'), coingeckoList250Repository.getCoinMarketCapCoinLatest('7'), coingeckoList250Repository.getCoinMarketCapCoinLatest('8'),
            coingeckoList250Repository.getCoinMarketCapCoinLatest('9'), coingeckoList250Repository.getCoinMarketCapCoinLatest('10')]);

        var newList2 = data2[0] + data2[1] + data2[2] + data2[3] + data2[4];

        newList2.forEach((coingeckoModel) => coingeckoMap[coingeckoModel.symbol] = coingeckoModel);

        yield CoingeckoList250LoadedState(coingeckoModelList: newList, coingeckoMap: coingeckoMap);
      } catch (e) {
        debugPrint(e.toString());
        yield CoingeckoList250ErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }