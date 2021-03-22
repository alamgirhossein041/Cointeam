import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_all_bloc/binance_get_all_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_all_bloc/binance_get_all_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';

class BinanceGetAllBloc extends Bloc<BinanceGetAllEvent, BinanceGetAllState> {
  
  BinanceGetAllBloc({this.binanceGetAllRepository}) : super(BinanceGetAllInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetAllRepositoryImpl binanceGetAllRepository;

  @override
  Stream<BinanceGetAllState> mapEventToState(BinanceGetAllEvent event) async* {
    if (event is FetchBinanceGetAllEvent) {
      yield BinanceGetAllLoadingState();
      try {
        List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        /// do logic
        /// if else blah blah
        
        yield BinanceGetAllLoadedState(binanceGetAll: binanceGetAllModel); /// TODO : insert parameters later
      } catch (e) {
        log("Something went wrong in binance_get_all_bloc.dart");
        yield BinanceGetAllErrorState(errorMessage : e.toString());
      }
    }
  }
}