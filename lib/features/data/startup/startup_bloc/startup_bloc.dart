import 'dart:async';
import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_prices.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/portfolio/models/coinmarketcap_coin_data.dart';
import 'package:coinsnap/features/portfolio/repos/coinmarketcap_coin_data.dart';
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
    List<BinanceGetAllModel> binanceGetAllModel = [];
    List<String> coinList = [];
    Map coinBalancesMap = {};
    Map binancePrices;
    String currency = 'USD';
    double btcSpecial = 0.0;
    double ethSpecial = 0.0;
    double usdSpecial = 0.0;
    double btcQuantity = 0.0;
    double totalValue = 0.0;
        
    if (event is FetchStartupEvent) {
      yield StartupLoadingState();
      try{
        /// GetCoinList logic
        final LocalStorage storage = LocalStorage("settings");
        currency = await storage.getItem("currency");
        // String isBinanceTrading = await secureStorage.read(key: "binance");

        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);
        binancePrices = responses[1];
        // if (isBinanceTrading != null) {
          binanceGetAllModel = responses[0];
          // for(BinanceGetAllModel coin in binanceGetAllModel) {
          //     coinList.add(coin.coin);
          //   if(coinBalancesMap[coin.coin] != null) {
          //     coinBalancesMap[coin.coin] += coin.free + coin.locked;
          //   } else {
          //     coinBalancesMap[coin.coin] = coin.free + coin.locked;
          //   }
          // }
          var btcPrice = binancePrices['BTCUSDT'];
          log(binanceGetAllModel[1].coin.toString());
          for(var coins in binanceGetAllModel) {
            log(coins.toString());
            log(coins.coin.toString());
            log(coins.free.toString());
            log(coins.locked.toString());
            if(binancePrices[coins.coin + 'USDT'] != null) {
              coinList.add(coins.coin);
              coins.totalUsdValue = (coins.free + coins.locked) * binancePrices[coins.coin + 'USDT'];
              totalValue += coins.totalUsdValue;
            } else if(binancePrices[coins.coin + 'BTC'] != null) {
              coinList.add(coins.coin);
              coins.totalUsdValue = (coins.free + coins.locked) * (binancePrices[coins.coin + 'BTC'] * btcPrice);
              totalValue += coins.totalUsdValue;
            } else if(coins.coin == 'USDT') {
              coins.totalUsdValue = (coins.free + coins. locked);
              coinList.add(coins.coin);
              totalValue += coins.totalUsdValue;
            } else {
              coins.totalUsdValue = 0;
              log(coins.coin.toString() + " has no BTC or USDT pair");
            }
          }
          //   if(coins.coin == 'BTC') {
          //     coins.btcValue = 1.0;
          //     coins.usdValue = btcPrice;
          //     coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          //     btcQuantity += coins.locked;
          //     btcQuantity += coins.free;
          //     totalValue += btcQuantity;
          //   } else if (coins.coin == 'USDT') {
          //     coins.btcValue = 1.0 / btcPrice;
          //     coins.usdValue = 1.0;
          //     coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          //     usdSpecial += coins.locked;
          //     usdSpecial += coins.free;
          //   } else {
          //     try {
          //       coins.btcValue = binancePrices[coins.coin + 'BTC'];
          //       coins.usdValue = coins.btcValue * btcPrice;
          //       coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          //       totalValue += binancePrices[coins.coin + 'BTC'] * coins.locked;
          //       totalValue += binancePrices[coins.coin + 'BTC'] * coins.free;
          //     } catch (e) {
          //       try {
          //         if(coins.coin == 'AUD') {
          //           coins.btcValue = 1 / binancePrices['BTC' + coins.coin];
          //           coins.usdValue = binancePrices[coins.coin + 'USDT'];
          //           coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          //           totalValue += coins.locked / binancePrices['BTC' + coins.coin];
          //           totalValue += coins.free / binancePrices['BTC' + coins.coin];
          //         } else {
          //           coins.totalUsdValue = 0;
          //         }
          //       } catch (f) {
          //         debugPrint(coins.coin.toString() + " gave a nested catch error");
          //         debugPrint(f.toString());
          //       }
              
          //     }
          //   }
          // }
        // }
        binanceGetAllModel..sort((a, b) => b.totalUsdValue.compareTo(a.totalUsdValue));
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
                                coinList: coinList, btcSpecial: btcSpecial, ethSpecial: ethSpecial, binanceGetAllModel: binanceGetAllModel);

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