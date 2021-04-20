import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_state.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';

class GetCoinListTotalValueBloc extends Bloc<GetCoinListTotalValueEvent, GetCoinListTotalValueState> {

  CardCoinmarketcapCoinListRepositoryImpl coinmarketcapListQuoteRepository;
  
  GetCoinListTotalValueBloc({this.coinmarketcapListQuoteRepository}) : super(GetCoinListTotalValueInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  @override
  Stream<GetCoinListTotalValueState> mapEventToState(GetCoinListTotalValueEvent event) async* {
    if (event is FetchGetCoinListTotalValueEvent) {
      List coinList = event.coinList;
      Map coinBalancesMap = event.coinBalancesMap;
      double btcSpecial = 0.0;
      double ethSpecial = 0.0;

      /// airport
      
      // debugPrint(coinBalancesMap.toString());
      double totalValue = 0.0;
      yield GetCoinListTotalValueLoadingState();
      try {
        CardCoinmarketcapListModel coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);
        for(var coin in coinListData.data) {
          if(coin.symbol == 'BTC') {
            btcSpecial = coin.quote.uSD.price;
          } else if(coin.symbol == 'ETH') {
            ethSpecial = coin.quote.uSD.price;
          }

          if(coinBalancesMap[coin.symbol] == null) {
            coinBalancesMap[coin.symbol] = 0.0;
          }
          totalValue += coinBalancesMap[coin.symbol] * coin.quote.uSD.price;
        }
        
        coinListData.data..sort((a, b) => (b.quote.uSD.price * coinBalancesMap[b.symbol]).compareTo(a.quote.uSD.price * coinBalancesMap[a.symbol]));
        yield GetCoinListTotalValueLoadedState(totalValue: totalValue, coinListData: coinListData, coinBalancesMap: coinBalancesMap, coinList: coinList, btcSpecial: btcSpecial, ethSpecial: ethSpecial); /// TODO : insert parameters later
      } catch (e) {
        debugPrint(e.toString());
        debugPrint("Something went wrong in get_coin_list_total_value_bloc.dart");
        yield GetCoinListTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}