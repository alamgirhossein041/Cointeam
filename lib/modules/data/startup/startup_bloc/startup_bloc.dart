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
    List<String> toRemove = [];
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
    double bnbSpecial = 0.0;
    double xrpSpecial = 0.0;
    double dogeSpecial = 0.0;
    double adaSpecial = 0.0;
    double dotSpecial = 0.0;
    double uniSpecial = 0.0;
    double totalValue = 0.0;
    Map<String, Map<String, dynamic>> portfolioMap = {};
        
    if (event is FetchStartupEvent) {
      yield StartupLoadingState();
      try{
        /// GetCoinList logic
        final LocalStorage storage = LocalStorage("settings");
        currency = await storage.getItem("currency");
        // String isBinanceTrading = await secureStorage.read(key: "binance");

        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo(), ftxGetBalanceRepository.getFtxGetBalance()]);
        binancePrices = responses[1] ?? [];
        binancePortfolioModel = responses[0] ?? null;
        ftxPortfolioModel = responses[2] ?? null;
        
        /// ### Loading in BTC/USDT price for use later ### ///
        btcSpecial = binancePrices['BTCUSDT'];

        log(btcSpecial.toString());
        ethSpecial = binancePrices['ETHUSDT'];

        log(ethSpecial.toString());
        bnbSpecial = binancePrices['BNBUSDT'];

        log(bnbSpecial.toString());
        xrpSpecial = binancePrices['XRPUSDT'];

        log(xrpSpecial.toString());
        dogeSpecial = binancePrices['DOGEUSDT'];

        log(dogeSpecial.toString());
        adaSpecial = binancePrices['ADAUSDT'];

        log(adaSpecial.toString());
        dotSpecial = binancePrices['DOTUSDT'];

        log(dotSpecial.toString());
        uniSpecial = binancePrices['UNIUSDT'];
        log(uniSpecial.toString());
        // if (isBinanceTrading != null) {
        // for(BinanceGetAllModel coin in binancePortfolioModel) {
        binancePortfolioModel?.data?.forEach((k,v) => {
          /// ### Here we use Binance Prices to calculate total values ### ///
          if(binancePrices[k + 'USDT'] != null) {
            coinList.add(k),
            binanceTotalValueUsd += v.total * binancePrices[k + 'USDT'],
            binancePortfolioModel.data[k].totalUsdValue = v.total * binancePrices[k + 'USDT']
          } else if(binancePrices[k + 'BTC'] != null) {
            coinList.add(k),
            binanceTotalValueUsd += v.total * binancePrices[k + 'BTC'] * btcSpecial,
            binancePortfolioModel.data[k].totalUsdValue = v.total * binancePrices[k + 'BTC'] * btcSpecial,
          } else if(k == 'USDT') {
            coinList.add(k),
            binanceTotalValueUsd += v.total,
            binancePortfolioModel.data[k].totalUsdValue = v.total,
          } else {
            binancePortfolioModel.data[k].totalUsdValue = 0.0,
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
        ftxPortfolioModel?.data?.forEach((k,v) => {
          coinList.add(k),
          ftxTotalValueUsd += v.usdValue
        });

        totalValue += binanceTotalValueUsd;
        totalValue += ftxTotalValueUsd;

        yield StartupTotalValueState(totalValue: totalValue, btcSpecial: btcSpecial, ethSpecial: ethSpecial, bnbSpecial: bnbSpecial,
                                    xrpSpecial: xrpSpecial, dogeSpecial: dogeSpecial, adaSpecial: adaSpecial, dotSpecial: dotSpecial,
                                    uniSpecial: uniSpecial);

          // coinList.addAll(ftxPortfolioModel.data.fo);
          // if(binanceBalancesMap[coin.coin] != null) {
          //   binanceBalancesMap[coin.coin] += coin.total;
          // } else {
            // ftxBalancesMap[coin.coin] = coin.total;
            // ftxUsdValues[coin.coin] = coin.usdValue;
            // ftxTotalValueUsd
          // }
        // }
        // totalValue += ftxTotalValueUsd;
        // totalValue += binanceTotalValueUsd;

        /// Removes duplicates from coinList
        coinList = coinList.toSet().toList();

      } catch (e) {
        debugPrint("The error is in startup_bloc.dart, part 1");
        debugPrint(e.toString());
        log("The error is in startup_bloc.dart, part 1");
        log(e.toString());
        yield StartupErrorState(errorMessage : e.toString());
      }

      /// GetCoinListTotalValue logic -- Possibly split bloc here
      CardCoinmarketcapListModel coinListData;
      try {
        coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);

        /// ### extremely inefficient ### ///

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
          // log(totalValue.toString());
        totalValue += binanceTotalValueUsd;
        // log(totalValue.toString());
        totalValue += ftxTotalValueUsd;
        // log(totalValue.toString());
        // }
        // if(binanceBalancesMap['AUD'] != null) {
        //   if(currency == 'USD') {
        //     totalValue += binanceBalancesMap['AUD'] * (binancePrices['AUDUSDT'] ?? 0);
        //   } else if(currency == 'AUD') {
        //     totalValue += binanceBalancesMap['AUD'];
        //   }
        // }

        // coinListData.data..sort((a, b) => ((portfolioMap[b.symbol]['total'] * b.quote.uSD.price).compareTo(portfolioMap[a.symbol]['total'] * a.quote.uSD.price)));

        // coinListData.data..sort((a, b) => (b.quote.uSD.price * binanceBalancesMap[b.symbol]).compareTo(a.quote.uSD.price * binanceBalancesMap[a.symbol]));

        yield StartupLoadedState(totalValue: totalValue, coinListData: coinListData, binancePortfolioModel: binancePortfolioModel,
                                coinList: coinList, btcSpecial: btcSpecial, ethSpecial: ethSpecial, ftxPortfolioModel: ftxPortfolioModel,
                                binanceTotalValueUsd: binanceTotalValueUsd, ftxTotalValueUsd: ftxTotalValueUsd, bnbSpecial: bnbSpecial,
                                    xrpSpecial: xrpSpecial, dogeSpecial: dogeSpecial, adaSpecial: adaSpecial, dotSpecial: dotSpecial,
                                    uniSpecial: uniSpecial);

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