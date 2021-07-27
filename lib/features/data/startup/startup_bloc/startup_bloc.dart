import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

import 'package:coinsnap/features/data/binance_price/binance_price.dart';
import 'package:coinsnap/features/data/binance_price/models/binance_exchange_info.dart';
import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_prices.dart';
import 'package:coinsnap/features/data/coingecko_image/repos/coingecko_coin_info_repo.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_isolate.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/data/coinmarketcap/models/coinmarketcap_coin_data.dart';
import 'package:coinsnap/features/data/coinmarketcap/repos/coinmarketcap_coin_data.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:coinsnap/features/utils/dummy_data.dart';
import 'package:coinsnap/features/utils/local_json_parse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  StartupBloc({this.binanceGetAllRepository, this.coinmarketcapListQuoteRepository, this.binanceGetPricesRepository, this.binanceExchangeInfoRepository}): super(StartupInitialState());
  final BinanceGetAllRepositoryImpl binanceGetAllRepository;
  final CardCoinmarketcapCoinListRepositoryImpl coinmarketcapListQuoteRepository;
  final BinanceGetPricesRepositoryImpl binanceGetPricesRepository;
  final BinanceExchangeInfoRepositoryImpl binanceExchangeInfoRepository;


  /// switch data from coinmarketcap to coingecko
  /// save coingecko data into a model including HTML images


  @override
  Stream<StartupState> mapEventToState(StartupEvent event) async* {
    yield StartupInitialState();
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    List<BinanceGetAllModel> binanceGetAllModel = [];
    BinanceExchangeInfoModel binanceExchangeInfoModelNew;
    List<CoingeckoListTop100Model> coingeckoModelList = [];
    Map<String, dynamic> coingeckoModelMap = {};
    List<String> coinList = [];
    List<String> securitiesFilter = [];
    Map binancePrices;
    String currency = 'USD';
    double btcSpecial = 0.0;
    double ethSpecial = 0.0;
    double usdTotal = 0.0;
    double btcTotal = 0.0;
    double totalValue = 0.0;
    // var receivePort = ReceivePort();

    if (event is FetchStartupEvent) {
      yield StartupLoadingState();
      try{
        /// GetCoinList logic
        final LocalStorage storage = LocalStorage("settings");
        await storage.ready;
        currency = await storage.getItem("currency");
        // String isBinanceTrading = await secureStorage.read(key: "binance");

        // List of coins in the portfolio from Binance
        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo(), binanceExchangeInfoRepository.getBinanceExchangeInfo()]);
        binancePrices = responses[1];
      
        // if responses[0] is null then assign empty list
        binanceGetAllModel = responses[0];
        binanceExchangeInfoModelNew = responses[2];
        bool shouldIterateBinanceExchange = false;

        
        /// retrieve from localStorage
        var savedBinanceExchangeInfoModel = await storage.getItem("binanceExchangeInfoModel"); /// this should be a map?
        if(savedBinanceExchangeInfoModel != null) {
        // Map<String, dynamic> body = Map.from(json.decode(response.body));
          BinanceExchangeInfoModel binanceExchangeInfoModelOld = BinanceExchangeInfoModel.fromJson(savedBinanceExchangeInfoModel); /// can merge this into one line with storage.getItem
          /// compare the two models
          /// 
          if(binanceExchangeInfoModelOld.symbols != binanceExchangeInfoModelNew.symbols) {
            log("binanceExchangeInfo has changed");
            shouldIterateBinanceExchange = true;
          } else {
            log("binanceExchangeInfo has not changed");
          }
        }
        
        if(shouldIterateBinanceExchange) {
          binanceExchangeInfoModelNew.symbols.forEach((v) {
            bool toAdd = true;
            v.permissions.forEach((w) {
              if(w == "SPOT") {
                toAdd = false;
              }
            });
            if(toAdd == true) {
              /// Adds coin to securitiesFilter List
              securitiesFilter.add(v.baseAsset);
            }
          });
          securitiesFilter.toSet().toList(); /// Removes duplicates, of which there will be many
          await storage.setItem("securitiesFilter", securitiesFilter);
        } else {
          securitiesFilter = await storage.getItem("securitiesFilter") ?? [];
        }

        await storage.setItem("binanceExchangeInfoModel", binanceExchangeInfoModelNew.toJson());
        
        // List<String> comparisons = [];
        // comparisons.add(comparisonOne);
        // comparisons.add(comparisonTwo);

        // // var receivePort = ReceivePort();
        // var stopWatch = Stopwatch()..start();
        // if(comparisonOne != comparisonTwo) {
        //   print("true");

        // }
        // Isolate.spawn(startupIsolate, receivePort.sendPort);
        // Stream receivePortStream = receivePort.asBroadcastStream();
        // SendPort sendPort = await receivePortStream.first;
        // receivePortStream.listen((message) {
        //   if(message is bool) {
        //     print("message from isolate is: " + message.toString());
        //   }
        // });
        // sendPort.send(comparisons);
        
        // stopWatch.stop();
        // log("Time taken: " + stopWatch.elapsedMicroseconds.toString());


        
        // /// save into localStorage
        // await storage.setItem("binanceExchangeInfoModel", binanceExchangeInfoModel);



        // goes through list of coins in the portfolio and gets matching coin image link
        // only do this if there are coins

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
          for(var coins in binanceGetAllModel) {
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
              // log(coins.coin.toString() + " has no BTC or USDT pair");
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
        /// for now we will hard code AUD as a currency check
        /// but in the future we can load in currency values using BinancePrices into each coinModel
        if (currency == 'AUD') {
          totalValue = totalValue / binancePrices['AUDUSDT'];
        }
        binanceGetAllModel..sort((a, b) => b.totalUsdValue.compareTo(a.totalUsdValue));
        // coinList.add('BTC');
        // coinList.add('ETH');
        // coinList = coinList.toSet().toList();
      } catch (e) {
        debugPrint("The error is in startup_bloc.dart, part 1");
        debugPrint(e.toString());
        log("The error is in startup_bloc.dart, part 1");
        log(e.toString());
        yield StartupErrorState(errorMessage : e.toString());
      }

      try {
        if (binanceGetAllModel != null) {
          Map<String, dynamic> arguments = await _loadCoinIcons(binanceGetAllModel);
          coingeckoModelList = arguments['list'];
          coingeckoModelMap = arguments['map'];
        }

      /// GetCoinListTotalValue logic
      /// TODO: andrew remove unused code
      // try {
      //   CardCoinmarketcapListModel coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);

      //   for(var coin in coinListData.data) {
      //     if(coin.symbol == 'BTC') {
      //       btcSpecial = coin.quote.uSD.price;
      //     } else if(coin.symbol == 'ETH') {
      //       ethSpecial = coin.quote.uSD.price;
      //     }
      //     if(coinBalancesMap[coin.symbol] == null) {
      //       coinBalancesMap[coin.symbol] = 0.0;
      //     }
      //     totalValue += coinBalancesMap[coin.symbol] * coin.quote.uSD.price;
      //   }

      //   /// fiat currency check
      //   if(coinBalancesMap['AUD'] != null) {
      //     if(currency == 'USD') {
      //       totalValue += coinBalancesMap['AUD'] * binancePrices['AUDUSDT'];
      //     } else if(currency == 'AUD') {
      //       totalValue += coinBalancesMap['AUD'];
      //     }
      //   }

        // coinListData.data..sort((a, b) => (b.quote.uSD.price * coinBalancesMap[b.symbol]).compareTo(a.quote.uSD.price * coinBalancesMap[a.symbol]));
        // btcSpecial = 
        yield StartupLoadedState(totalValue: totalValue, coingeckoModelMap: coingeckoModelMap, currency: currency, securitiesFilter: securitiesFilter,
                                coinList: coinList, btcSpecial: btcSpecial, ethSpecial: ethSpecial, binanceGetAllModel: binanceGetAllModel,
                                usdTotal: usdTotal, btcTotal: btcTotal, coingeckoModelList: coingeckoModelList);
    
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
  Future<Map<String, dynamic>> _loadCoinIcons(List<BinanceGetAllModel> coins) async {
    // get the local storage list of coingecko coins in the portfolio here
    LocalStorage localStorage = LocalStorage("coinstreetapp");
    Map<String, dynamic> coingeckoCoins = {};
    List<Map<String, dynamic>> coingeckoCoinsListOfMaps = [];
    Map coinIcons = {};
    List<String> nullCoins = [];
    List<String> coinsForRepo = [];
    List<CoingeckoListTop100Model> coingeckoModelList = [];
    Map<String, dynamic> arguments = {};
    bool toParse = false;
    
    var ready = await localStorage.ready;
    // await localStorage.ready.then((_) {
      // what if these things don't exist, they return null
      // get stored list of parsed coingecko coins
    coingeckoCoins = localStorage.getItem('parsedCoingeckoCoins') ?? {};
    // coingeckoCoins = {};
    // get stored list of coin : icon url map
    coinIcons = localStorage.getItem('coinIcons') ?? {};
    // print("coingecko coins length = "+coingeckoCoins.length.toString());

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
      if(coingeckoCoins[v.coin] != null) { /// Here we need to check for == null and then do the hard coded list missingcoins.json stuff
        coinsForRepo.add(coingeckoCoins[v.coin]['id'].toLowerCase());
      } else {
        nullCoins.add(v.coin);
        toParse = true;
      }
      // print("coingecko coins[$coinSymbol] = "+coingeckoCoins[coinSymbol].toString());
      
      // Map<String, dynamic> coingeckoCoin = coingeckoCoins[coinSymbol];
      
      // if the coin is null, it wasn't found on the coingecko parsed list for some reason.
      // add to the list of coins to be filled in.

      /// we have coins (binancegetallmodel)
      /// we want to check if our ...
      /// have we made our coingecko api call yet

      // if (coingeckoCoins[coinSymbol] != null) {
      //   coingeckoCoinsListOfMaps.add(coingeckoCoins[coinSymbol]);
      //   coinsForRepo.add(coingeckoCoins[coinSymbol]['id']);
      // } else {
      //   nullCoins.add(coinSymbol);
      //   toParse = true;
      //   // use this symbol to get the id to call the api with it
      //   /// TODO: Move out of Startup_Bloc
      //   /// 
      //   /// 
      //   /// 2. for the coins that ARE null, we need to fill it in from the missing_coins_list
      //   /// 1. call our repo to get coin info FOR all the coingeckoCoins that are not null
      //   /// 
      //   /// 
      //   /// 
      // }

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

    // if there were any null coins, go through our list of missing coins map and fill it in.
    if(toParse) {
      Map<String, dynamic> missingCoinMap = await parseJsonFromAssets("assets/missing_coin_map.json");
      nullCoins.forEach((v) => {
        if(missingCoinMap[v] != null) {
          coingeckoCoinsListOfMaps.add(missingCoinMap[v]),
          coinsForRepo.add(missingCoinMap[v]['id'])
          /// We are trying to create a map of coingecko id and its url
          

          /// We need to make an API call using coingecko ID

          /// (we are trying to get coingecko IDs)
        }
      });
    }

    coingeckoCoinsListOfMaps.toSet().toList();
    // coinsForRepo
    coinsForRepo.toSet().toList();
    CoingeckoCoinInfoRepoImpl coinRepo = CoingeckoCoinInfoRepoImpl();

    /// Pagination
    List<int> pages = [];
    int listIterate = 1;
    if (coingeckoCoinsListOfMaps.length > 250) {
      listIterate = (coins.length / 250).ceil();
    }

    for(int i = 1; i <= listIterate; i++) {
      pages.add(i);
    }

    await Future.forEach(pages, (v) async {
      coingeckoModelList.addAll(await coinRepo.getCoinInfo(coinsForRepo, v));
      /// returns a model of blah
      /// save model as a value in the 'id' key in our existing map
    });

    Map<String, dynamic> coingeckoModelMap = {};
    coingeckoModelList.forEach((v) { 
      coingeckoModelMap[v.symbol] = v;
    });

    arguments['map'] = coingeckoModelMap ?? {};
    arguments['list'] = coingeckoModelList ?? [];

    return arguments;

  }
}