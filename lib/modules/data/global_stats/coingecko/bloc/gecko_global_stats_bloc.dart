import 'dart:developer';

import 'package:coinsnap/modules/data/global_stats/coingecko/bloc/gecko_global_stats_event.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/bloc/gecko_global_stats_state.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/models/gecko_global_stats.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/repos/gecko_global_stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';

class GeckoGlobalStatsBloc extends Bloc<GeckoGlobalStatsEvent, GeckoGlobalStatsState> {
  GeckoGlobalStatsBloc({@required this.geckoGlobalStatsRepo}) : super(GeckoGlobalStatsInitialState());
  GeckoGlobalStatsRepoImpl geckoGlobalStatsRepo;

  @override
  Stream<GeckoGlobalStatsState> mapEventToState(GeckoGlobalStatsEvent event) async* {
    if (event is GeckoGlobalStatsFetchEvent) {
      yield GeckoGlobalStatsLoadingState();
      try {
        GeckoGlobalStats geckoGlobalStats = await geckoGlobalStatsRepo.getGeckoGlobalStats();
        final storageCurrency = LocalStorage("settings");
        String currency = 'usd';
        await storageCurrency.ready.then((_) {
          currency = storageCurrency.getItem("currency").toLowerCase();
        });
        log(currency);
        yield GeckoGlobalStatsLoadedState(geckoGlobalStats: geckoGlobalStats, currency: currency);
      } catch (e) {
        log(e.toString());
        yield GeckoGlobalStatsErrorState(errorMessage : e.toString());
      }
    }
  }
}