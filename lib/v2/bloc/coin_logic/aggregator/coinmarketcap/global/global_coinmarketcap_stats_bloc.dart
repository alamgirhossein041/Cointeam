import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_state.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/global/global_coinmarketcap_stats_repo.dart';
import 'package:meta/meta.dart';

// class FirestoreGetUserDataBloc extends Bloc<FirestoreGetUserDataEvent, FirestoreGetUserDataState> {
  
  // FirestoreGetUserDataBloc({@required this.repository}) : super(FirestoreGetUserDataInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


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
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        log(e.toString());
        yield GlobalCoinmarketcapStatsErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }