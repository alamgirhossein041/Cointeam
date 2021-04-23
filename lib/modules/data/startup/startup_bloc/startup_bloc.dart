import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/modules/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_get_portfolio.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_get_prices.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/portfolio/models/coinmarketcap_coin_data.dart';
import 'package:coinsnap/modules/portfolio/repos/coinmarketcap_coin_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  StartupBloc({this.binanceGetAllRepository, this.coinmarketcapListQuoteRepository, this.binanceGetPricesRepository}): super(StartupInitialState());
  final BinanceGetAllRepositoryImpl binanceGetAllRepository;
  final CardCoinmarketcapCoinListRepositoryImpl coinmarketcapListQuoteRepository;
  final BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  @override
  Stream<StartupState> mapEventToState(StartupEvent event) async* {
    yield StartupInitialState();
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    List<String> coinList = [];
    Map coinBalancesMap;
    Map binancePrices;
    String currency = 'USD';
        
    if (event is FetchStartupEvent) {
      yield StartupLoadingState();
      try{
        /// GetCoinList logic
        final LocalStorage localStorage = LocalStorage("coinstreetapp");
        final LocalStorage storage = LocalStorage("settings");
        currency = await storage.getItem("currency");
        String isBinanceTrading = await secureStorage.read(key: "binance");
        var localStorageResponse = await localStorage.getItem("prime");
        if(localStorageResponse != null) {
          coinBalancesMap = Map.from(json.decode(await localStorage.getItem("prime")));
        } else {
          coinBalancesMap = {};
        }

        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);
        binancePrices = responses[1];
        coinBalancesMap.forEach((k,v) {
          coinList.add(k);
        });
        if (isBinanceTrading != null) {
          for(BinanceGetAllModel coin in responses[0]) {
              coinList.add(coin.coin);
            if(coinBalancesMap[coin.coin] != null) {
              coinBalancesMap[coin.coin] += coin.free + coin.locked;
            } else {
              coinBalancesMap[coin.coin] = coin.free + coin.locked;
            }
          }
        }
        coinList.add('BTC');
        coinList.add('ETH');
        coinList = coinList.toSet().toList();

      } catch (e) {
        debugPrint("The error is in startup_bloc.dart, part 1");
        debugPrint(e.toString());
        log("The error is in startup_bloc.dart, part 1");
        log(e.toString());
        yield StartupErrorState(errorMessage : e.toString());
      }

      /// GetCoinListTotalValue logic
      double btcSpecial = 0.0;
      double ethSpecial = 0.0;
      double totalValue = 0.0;
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
        if(coinBalancesMap['AUD'] != null) {
          if(currency == 'USD') {
            totalValue += coinBalancesMap['AUD'] * binancePrices['AUDUSDT'];
          } else if(currency == 'AUD') {
            totalValue += coinBalancesMap['AUD'];
          }
        }
        
        coinListData.data..sort((a, b) => (b.quote.uSD.price * coinBalancesMap[b.symbol]).compareTo(a.quote.uSD.price * coinBalancesMap[a.symbol]));

        yield StartupLoadedState(totalValue: totalValue, coinListData: coinListData, coinBalancesMap: coinBalancesMap,
                                coinList: coinList, btcSpecial: btcSpecial, ethSpecial: ethSpecial);

      } catch (e) {
        debugPrint("The error is in startup_bloc.dart part 2");
        debugPrint(e.toString());
        log("The error is in startup_bloc.dart part 2");
        log(e.toString());
        yield StartupErrorState(errorMessage : e.toString());
      }
    }
  }
}