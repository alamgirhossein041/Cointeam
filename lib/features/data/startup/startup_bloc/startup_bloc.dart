import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_prices.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/data/coinmarketcap/models/coinmarketcap_coin_data.dart';
import 'package:coinsnap/features/data/coinmarketcap/repos/coinmarketcap_coin_data.dart';
import 'package:coinsnap/features/utils/local_json_parse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  StartupBloc({this.binanceGetAllRepository, this.coinmarketcapListQuoteRepository, this.binanceGetPricesRepository}): super(StartupInitialState());
  final BinanceGetAllRepositoryImpl binanceGetAllRepository;
  final CardCoinmarketcapCoinListRepositoryImpl coinmarketcapListQuoteRepository;
  final BinanceGetPricesRepositoryImpl binanceGetPricesRepository;


  /// switch data from coinmarketcap to coingecko
  /// save coingecko data into a model including HTML images


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
    double usdTotal = 0.0;
    double btcTotal = 0.0;
    double totalValue = 0.0;

    if (event is FetchStartupEvent) {
      yield StartupLoadingState();
      try{
        /// GetCoinList logic
        final LocalStorage storage = LocalStorage("settings");
        currency = await storage.getItem("currency");
        // String isBinanceTrading = await secureStorage.read(key: "binance");

        // List of coins in the portfolio from Binance
        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);
        binancePrices = responses[1];
      
        // if responses[0] is null then assign empty list
        binanceGetAllModel = responses[0];

        // goes through list of coins in the portfolio and gets matching coin image link
        // only do this if there are coins
        if (binanceGetAllModel != null) {
          _loadCoinIcons(binanceGetAllModel);
        }


        // how to check if api is connected?
        
        // if (isBinanceTrading != null) {
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
              coins.usdValue = binancePrices[coins.coin + 'USDT'];
              coins.btcValue = binancePrices[coins.coin + 'USDT'] / btcPrice;
              coins.totalUsdValue = (coins.free + coins.locked) * binancePrices[coins.coin + 'USDT'];
              totalValue += coins.totalUsdValue;
              if(coins.coin == 'BTC') {
                btcTotal = coins.totalUsdValue;
                coins.btcValue = 1;
                coins.usdValue = btcPrice;
              }
            } else if(binancePrices[coins.coin + 'BTC'] != null) {
              coinList.add(coins.coin);
              coins.btcValue = binancePrices[coins.coin + 'BTC'];
              coins.usdValue = binancePrices[coins.coin + 'BTC'] * btcPrice;
              coins.totalUsdValue = (coins.free + coins.locked) * (binancePrices[coins.coin + 'BTC'] * btcPrice);
              totalValue += coins.totalUsdValue;
            } else if(coins.coin == 'USDT') {
              coins.totalUsdValue = (coins.free + coins. locked);
              coinList.add(coins.coin);
              coins.usdValue = 1;
              totalValue += coins.totalUsdValue;
              usdTotal = coins.totalUsdValue;
            } else {
              coins.totalUsdValue = 0;
              coins.usdValue = 0;
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
      /// TODO: andrew remove unused code
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
                                coinList: coinList, btcSpecial: btcSpecial, ethSpecial: ethSpecial, binanceGetAllModel: binanceGetAllModel,
                                usdTotal: usdTotal, btcTotal: btcTotal);

      } catch (e) {
        debugPrint("The error is in startup_bloc.dart part 2");
        debugPrint(e.toString());
        log("The error is in startup_bloc.dart part 2");
        log(e.toString());
        yield StartupErrorState(errorMessage : e.toString());
      }
    }
  }

  // get the list of coins in portfolio 

  // go through list of coins and check to see if it has an image attached to it,
  // if not get it

  /// Goes through the given list of [coins] and assigns its icon image link to it
  void _loadCoinIcons(List coins) async {
    // get the local storage list of coingecko coins in the portfolio here
    LocalStorage localStorage = LocalStorage("coinstreetapp");
    Map<String, dynamic> coingeckoCoins = {};
    Map coinIcons = {};
    List<String> nullCoins = [];
    bool toParse = false;
    
    await localStorage.ready;
    // await localStorage.ready.then((_) {
      // what if these things don't exist, they return null
      // get stored list of parsed coingecko coins
      coingeckoCoins = localStorage.getItem('parsedCoingeckoCoins') ?? {};
      // get stored list of coin : icon url map
      coinIcons = localStorage.getItem('coinIcons') ?? {};
      print("coingecko coins length = "+coingeckoCoins.length.toString());
      // log(coingeckoCoins.toString());

      // if coinicons is empty map
      // iterate through portfolio coins and create this map and save to storage


      String coinSymbol = "";
      // else 
      // for each coin in the passed coin list, check if key exists in coinIcons map
      coins.forEach((v) async {
        
        // v.coin - compare that to keys of coinIcons
        // get the congecko id for it
        // get coin symbol
        coinSymbol = v.coin.toLowerCase();
        // print("-----------a----------"+coingeckoCoins.toString());
        print("coingecko coins[$coinSymbol] = "+coingeckoCoins[coinSymbol].toString());
        
        // if this result is null, look through our janky missing coins list :D
        Map<String, dynamic> coin = coingeckoCoins[coinSymbol];
        if (coin == null) {
          nullCoins.add(coinSymbol);
          toParse = true;
        }
          // String data = await DefaultAssetBundle.of(context).loadString("assets/data.json");
          // final jsonResult = json.decode(data);


        // search parsed coingecko list of all coins for this symbol and get its id
        // String coingeckoId = coingeckoCoins[v.coin]['id'];

        // call the coingecko api id
        
        
        // get the image url and save to this map

        // if a coin return as null
        // check hardcoded list of maps
        // this could contain fiat currency, delisted currencies? incorrect mappings etc.
      });
      if(toParse) {
        Map<String, dynamic> missingCoinMap = await parseJsonFromAssets("assets/missing_coin_map.json");
        nullCoins.forEach((v) => {
          if(missingCoinMap[v] != null) {
            /// We are trying to create a map of coingecko id and its url

            /// We need to make an API call using coingecko ID

            /// (we are trying to get coingecko IDs)
          }
        });
      }
    // });
  // {
  //   btc: url
  //   eth: url
  // }
  }
}