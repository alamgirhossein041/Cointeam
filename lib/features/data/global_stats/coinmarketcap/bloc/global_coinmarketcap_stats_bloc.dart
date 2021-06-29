import 'package:coinsnap/features/data/global_stats/coinmarketcap/bloc/global_coinmarketcap_stats_event.dart';
import 'package:coinsnap/features/data/global_stats/coinmarketcap/bloc/global_coinmarketcap_stats_state.dart';
import 'package:coinsnap/features/data/global_stats/coinmarketcap/repos/global_coinmarketcap_stats_repo.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

class GlobalCoinmarketcapStatsBloc extends Bloc<GlobalCoinmarketcapStatsEvent, GlobalCoinmarketcapStatsState> {

  GlobalCoinmarketcapStatsBloc({@required this.globalCoinmarketcapStatsRepository}) : super(GlobalCoinmarketcapStatsInitialState());

  GlobalCoinmarketcapStatsRepositoryImpl globalCoinmarketcapStatsRepository;

  @override
  Stream<GlobalCoinmarketcapStatsState> mapEventToState(GlobalCoinmarketcapStatsEvent event) async* {
    if (event is FetchGlobalCoinmarketcapStatsEvent) {
      yield GlobalCoinmarketcapStatsLoadingState();

      try {
        var data = await globalCoinmarketcapStatsRepository.getGlobalCoinmarketcapStats();
        yield GlobalCoinmarketcapStatsLoadedState(globalStats: data);
      } catch (e) {
        debugPrint(e.toString());
        yield GlobalCoinmarketcapStatsErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }