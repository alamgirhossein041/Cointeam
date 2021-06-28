import 'package:coinsnap/features/market/bloc/coingecko_list_trending_event.dart';
import 'package:coinsnap/features/market/bloc/coingecko_list_trending_state.dart';
import 'package:coinsnap/features/market/models/coingecko_list_trending_model.dart';
import 'package:coinsnap/features/market/repos/coingecko_list_trending_repo.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class CoingeckoListTrendingBloc extends Bloc<CoingeckoListTrendingEvent, CoingeckoListTrendingState> {

  CoingeckoListTrendingBloc({@required this.coingeckoListTrendingRepository}) : super(CoingeckoListTrendingInitialState());

  CoingeckoListTrendingRepositoryImpl coingeckoListTrendingRepository;

  @override
  Stream<CoingeckoListTrendingState> mapEventToState(CoingeckoListTrendingEvent event) async* {
    if (event is FetchCoingeckoListTrendingEvent) {
      yield CoingeckoListTrendingLoadingState();

      try {
        /// ### data is a list of CoingeckoList250Model ### ///
        
        List<CoingeckoListTrendingModel> data = await coingeckoListTrendingRepository.getCoingeckoListTrending();

        yield CoingeckoListTrendingLoadedState(coingeckoModelList: data);
      } catch (e) {
        debugPrint(e.toString());
        yield CoingeckoListTrendingErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }