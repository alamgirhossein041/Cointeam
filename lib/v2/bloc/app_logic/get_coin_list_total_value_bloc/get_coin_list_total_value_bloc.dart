import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_price_info_bloc/get_price_info_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_price_info_bloc/get_price_info_state.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_prices_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_prices_repo.dart';

class GetCoinListTotalValueBloc extends Bloc<GetCoinListTotalValueEvent, GetCoinListTotalValueState> {

  CardCoinmarketcapCoinListRepositoryImpl coinmarketcapListQuoteRepository;
  
  GetCoinListTotalValueBloc({this.coinmarketcapListQuoteRepository}) : super(GetCoinListTotalValueInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  @override
  Stream<GetCoinListTotalValueState> mapEventToState(GetCoinListTotalValueEvent event) async* {
    if (event is FetchGetCoinListTotalValueEvent) {
      List coinList = event.coinList;
      Map coinBalancesMap = event.coinBalancesMap;
      // log(coinBalancesMap.toString());
      double totalValue = 0.0;
      yield GetCoinListTotalValueLoadingState();
      try {
        // List<BinanceGetPricesModel> binanceGetPricesModel = await binanceGetPricesRepository.getBinancePricesInfo();
        // Map binanceGetPricesMap = Map.fromIterable(binanceGetPricesModel, key: (e) => e.symbol, value: (e) => e.price);
        
        // var coinPrice = binanceGetPricesMap[event.coinTicker + 'USDT'];
        
        // log("Coin Price is: " + coinPrice.toString());
        /// do logic
        /// if else blah blah
        
        CardCoinmarketcapListModel coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);
        for(var coin in coinListData.data) {
          
          totalValue += coinBalancesMap[coin.symbol] * coin.quote.uSD.price;

          // log("TotalValue in round $i [" + coin.symbol + "] is = " + totalValue.toString());
          
        }
        coinListData.data..sort((a, b) => (b.quote.uSD.price * coinBalancesMap[b.symbol]).compareTo(a.quote.uSD.price * coinBalancesMap[a.symbol]));
        
        yield GetCoinListTotalValueLoadedState(totalValue: totalValue, coinListData: coinListData, coinBalancesMap: coinBalancesMap); /// TODO : insert parameters later
      } catch (e) {
        // log(e.toString());
        log("Something went wrong in get_price_info_bloc.dart");
        yield GetCoinListTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}