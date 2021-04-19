import 'dart:developer';

import 'package:coinsnap/v2/bloc/startup_logic/startup_event.dart';
import 'package:coinsnap/v2/bloc/startup_logic/startup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  StartupBloc() : super(StartupInitialState());

  @override
  Stream<StartupState> mapEventToState(StartupEvent event) async* {
    if (event is FetchStartupEvent) {
      try{
        /// Cmc global stats (because it's fast)
        /// 
        /// Coingecko250list x10 (because it's free)
        /// 
        /// is secureStorage("binance") != null?
        /// // if yes, binanceGetAllRepo
        /// 
        /// coinList add binance, ftx, coinbase, etc.
        /// 
        /// P.S. in MasterCoinModel we will have isBinance isFtx isCoinbase
        /// 
        /// 
        /// Don't forget:
        /// // Global stats
        /// // Local portfolios (multiple)
        /// // Total value
        /// 
        /// 
        /// Yield - 
        /// // List<String> coinList
        /// // List<MasterCoinModel> masterCoinList

      } catch (e) {
        log("The error is in startup_bloc.dart");
        log(e.toString());
        yield StartupErrorState(errorMessage : e.toString());
      }
    }
  }
}