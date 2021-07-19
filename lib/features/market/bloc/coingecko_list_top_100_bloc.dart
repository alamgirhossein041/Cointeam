import 'package:coinsnap/features/market/bloc/coingecko_list_top_100_event.dart';
import 'package:coinsnap/features/market/bloc/coingecko_list_top_100_state.dart';
import 'package:coinsnap/features/market/models/coingecko_list_top_100_model.dart';
import 'package:coinsnap/features/market/repos/coingecko_list_top_100_repo.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class CoingeckoListTop100Bloc extends Bloc<CoingeckoListTop100Event, CoingeckoListTop100State> {

  CoingeckoListTop100Bloc({@required this.coingeckoListTop100Repository}) : super(CoingeckoListTop100InitialState());

  CoingeckoListTop100RepositoryImpl coingeckoListTop100Repository;

  @override
  Stream<CoingeckoListTop100State> mapEventToState(CoingeckoListTop100Event event) async* {
    if (event is FetchCoingeckoListTop100Event) {
      yield CoingeckoListTop100LoadingState();

      try {
        /// ### data is a list of CoingeckoList250Model ### ///
        
        List<CoingeckoListTop100Model> data = await coingeckoListTop100Repository.getCoinMarketCapCoinLatest('1');

        yield CoingeckoListTop100LoadedState(coingeckoModelList: data);
      } catch (e) {
        debugPrint(e.toString());
        yield CoingeckoListTop100ErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }