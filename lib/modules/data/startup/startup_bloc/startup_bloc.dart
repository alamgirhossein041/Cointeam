import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/modules/portfolio/models/exchanges/binance_get_portfolio.dart';
import 'package:coinsnap/modules/portfolio/models/exchanges/ftx_get_balance.dart';
import 'package:coinsnap/modules/portfolio/repos/exchanges/binance_get_portfolio.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_get_prices.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/portfolio/models/coinmarketcap_coin_data.dart';
import 'package:coinsnap/modules/portfolio/repos/coinmarketcap_coin_data.dart';
import 'package:coinsnap/modules/portfolio/repos/exchanges/ftx_get_balance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  StartupBloc({this.binanceGetAllRepository, this.coinmarketcapListQuoteRepository, this.binanceGetPricesRepository, this.ftxGetBalanceRepository}): super(StartupInitialState());
  final BinanceGetAllRepositoryImpl binanceGetAllRepository;
  final CardCoinmarketcapCoinListRepositoryImpl coinmarketcapListQuoteRepository;
  final BinanceGetPricesRepositoryImpl binanceGetPricesRepository;
  final FtxGetBalanceRepositoryImpl ftxGetBalanceRepository;

  @override
  Stream<StartupState> mapEventToState(StartupEvent event) async* {
    yield StartupInitialState();
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    List<String> coinList = [];
    List<String> localCoinList = [];
    Map binanceBalancesMap = {};
    Map localBalancesMap = {};
    Map ftxBalancesMap = {};
    Map binancePrices;
    Map ftxUsdValues = {};
    BinancePortfolioModel binancePortfolioModel;
    FtxGetBalanceModel ftxPortfolioModel;
    String currency = 'USD';
    double ftxTotalValueUsd = 0.0;
    double binanceTotalValueUsd = 0.0;
    double btcSpecial = 0.0;
    double ethSpecial = 0.0;
    Map<String, Map<String, dynamic>> portfolioMap = {};
        
    if (event is FetchStartupEvent) {
      yield StartupLoadingState();
      try{
        /// GetCoinList logic
        final LocalStorage localStorage = LocalStorage("coinstreetapp");
        final LocalStorage storage = LocalStorage("settings");
        currency = await storage.getItem("currency");
        // String isBinanceTrading = await secureStorage.read(key: "binance");
        var localStorageResponse = await localStorage.getItem("prime");
        if(localStorageResponse != null) {
          localBalancesMap = Map.from(json.decode(await localStorage.getItem("prime")));
        }

        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo(), ftxGetBalanceRepository.getFtxGetBalance()]);
        binancePrices = responses[1] ?? [];
        binancePortfolioModel = responses[0] ?? [];
        ftxPortfolioModel = responses[2] ?? null;
        localBalancesMap.forEach((k,v) {
          coinList.add(k);
          portfolioMap[k] = {};
          portfolioMap[k]['local'] = v;
          portfolioMap[k]['total'] = v;
        });
        /// ### Loading in BTC/USDT price for use later ### ///
        btcSpecial = binancePrices['BTCUSDT'];
        ethSpecial = binancePrices['ETHUSDT'];
        // if (isBinanceTrading != null) {
        // for(BinanceGetAllModel coin in binancePortfolioModel) {
        binancePortfolioModel.data.forEach((k,v) => {
          coinList.add(k),
          if(portfolioMap[k] == null) {
            portfolioMap[k] = {},
            portfolioMap[k]['total'] = v.total,
          } else {
            portfolioMap[k]['total'] += v.total,
          },
          portfolioMap[k]['binance'] = v.total,
          /// ### Here we use Binance Prices to calculate total values ### ///
          if(binancePrices[k + 'USDT'] != null) {
            binanceTotalValueUsd += v.total * binancePrices[k + 'USDT']
          } else if(binancePrices[k + 'BTC'] != null) {
            binanceTotalValueUsd += v.total * binancePrices[k + 'BTC'] * btcSpecial
          } else {
            log(k + " has no btc or usdt pair")
          }
        });
          // if(binanceBalancesMap[coin.coin] != null) {
          //   binanceBalancesMap[coin.coin] += coin.free + coin.locked;
          // } else {
            // binanceBalancesMap[coin.coin] = coin.free + coin.locked;
          // }
        // }
        // for(var coin in ftxPortfolioModel) {
        ftxPortfolioModel.data.forEach((k,v) => {
          coinList.add(k),
          if(portfolioMap[k] == null) {
            portfolioMap[k] = {},
            portfolioMap[k]['total'] = v.available,
          } else {
            portfolioMap[k]['total'] += v.available
          },
          portfolioMap[k]['ftx'] = v.available,
          ftxTotalValueUsd += v.usdValue
        });
          // coinList.addAll(ftxPortfolioModel.data.fo);
          // if(binanceBalancesMap[coin.coin] != null) {
          //   binanceBalancesMap[coin.coin] += coin.total;
          // } else {
            // ftxBalancesMap[coin.coin] = coin.total;
            // ftxUsdValues[coin.coin] = coin.usdValue;
            // ftxTotalValueUsd
          // }
        // }

        /// Removes duplicates from coinList
        coinList = coinList.toSet().toList();

      } catch (e) {
        debugPrint("The error is in startup_bloc.dart, part 1");
        debugPrint(e.toString());
        log("The error is in startup_bloc.dart, part 1");
        log(e.toString());
        yield StartupErrorState(errorMessage : e.toString());
      }

      /// GetCoinListTotalValue logic
      double totalValue = 0.0;
      CardCoinmarketcapListModel coinListData;
      try {
        if(coinList.length > 0) {
          coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);
        } else {
          coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);
          /// ### Need to add top 100 CardCoinmarketcapCoinLatestRepositoryImpl()
        }

        /// ### extremely inefficient ### ///
        for(var coin in coinListData.data) {
          if(localBalancesMap[coin.symbol] != null) {
            totalValue += coin.quote.uSD.price * localBalancesMap[coin.symbol];
          }
        }

        // for(var coin in coinListData.data) {
        //   if(coin.symbol == 'BTC') {
        //     btcSpecial = coin.quote.uSD.price;
        //   } else if(coin.symbol == 'ETH') {
        //     ethSpecial = coin.quote.uSD.price;
        //   }

        //   if(binanceBalancesMap[coin.symbol] == null) {
        //     binanceBalancesMap[coin.symbol] = 0.0;
        //   }
          // totalValue += binanceBalancesMap[coin.symbol] * coin.quote.uSD.price;
        totalValue += binanceTotalValueUsd;
        totalValue += ftxTotalValueUsd;
        // }
        if(binanceBalancesMap['AUD'] != null) {
          if(currency == 'USD') {
            totalValue += binanceBalancesMap['AUD'] * (binancePrices['AUDUSDT'] ?? 0);
          } else if(currency == 'AUD') {
            totalValue += binanceBalancesMap['AUD'];
          }
        }



        
        // coinListData.data..sort((a, b) => (binancePortfolioModel.data[b].totalValueUsd).compareTo(a.quote.uSD.price * binanceBalancesMap[a.symbol]));

        // coinListData.data..sort((a, b) => (b.quote.uSD.price * binanceBalancesMap[b.symbol]).compareTo(a.quote.uSD.price * binanceBalancesMap[a.symbol]));

        yield StartupLoadedState(totalValue: totalValue, coinListData: coinListData, binancePortfolioModel: binancePortfolioModel, portfolioMap: portfolioMap,
                                coinList: coinList, btcSpecial: btcSpecial, ethSpecial: ethSpecial, ftxPortfolioModel: ftxPortfolioModel,
                                binanceTotalValueUsd: binanceTotalValueUsd, ftxTotalValueUsd: ftxTotalValueUsd);

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