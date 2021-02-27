import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_price_info_bloc/get_price_info_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_price_info_bloc/get_price_info_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_prices_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_prices_repo.dart';

class GetPriceInfoBloc extends Bloc<GetPriceInfoEvent, GetPriceInfoState> {
  
  GetPriceInfoBloc({this.binanceGetPricesRepository}) : super(GetPriceInfoInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  @override
  Stream<GetPriceInfoState> mapEventToState(GetPriceInfoEvent event) async* {
    if (event is FetchGetPriceInfoEvent) {
      yield GetPriceInfoLoadingState();
      try {
        List<BinanceGetPricesModel> binanceGetPricesModel = await binanceGetPricesRepository.getBinancePricesInfo();
        Map binanceGetPricesMap = Map.fromIterable(binanceGetPricesModel, key: (e) => e.symbol, value: (e) => e.price);
        
        var coinPrice = binanceGetPricesMap[event.coinTicker + 'USDT'];
        
        log("Coin Price is: " + coinPrice.toString());
        /// do logic
        /// if else blah blah
        
        yield GetPriceInfoLoadedState(coinPrice: coinPrice); /// TODO : insert parameters later
      } catch (e) {
        log("Something went wrong in get_price_info_bloc.dart");
        yield GetPriceInfoErrorState(errorMessage : e.toString());
      }
    }
  }
}