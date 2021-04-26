import 'dart:developer';

import 'package:coinsnap/modules/data/binance_price/models/binance_exchange_info.dart';
import 'package:coinsnap/modules/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_exchange_info.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_get_portfolio.dart';
import 'package:coinsnap/modules/services/firebase_analytics.dart';
import 'package:coinsnap/modules/trading/portfolio/sell/bloc/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/modules/trading/portfolio/sell/bloc/sell_portfolio_bloc/sell_portfolio_state.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/repos/binance_buy_coin.dart';
import 'package:coinsnap/modules/trading/portfolio/sell/repos/binance_sell_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SellPortfolioBloc extends Bloc<SellPortfolioEvent, SellPortfolioState> {
  
  // SellPortfolioBloc({this.binanceSellCoinRepository, this.binanceGetAllRepository, this.binanceExchangeInfoRepository, this.ftxGetBalanceRepository, this.ftxExchangeInfoRepository, this.ftxSellCoinRepository}) : super(SellPortfolioInitialState());
  SellPortfolioBloc({this.binanceBuyCoinRepository, this.binanceSellCoinRepository,
  this.binanceGetAllRepository, this.binanceExchangeInfoRepository}) : super(SellPortfolioInitialState());

  double totalValue = 0.0;
  double pctToSell = 1.0;
  String coinTicker = "BTC";
  List<String> coinsToRemove = [];
  double divisor = 1.0;
  // int i = 0;
  bool tradeSuccessful = false;

  Map<String, dynamic> coinsToSave = {};

  final LocalStorage localStorage = LocalStorage("coinstreetapp");
  // FtxSellCoinRepositoryImpl ftxSellCoinRepository;
  // FtxGetBalanceRepositoryImpl ftxGetBalanceRepository;
  // FtxExchangeInfoRepositoryImpl ftxExchangeInfoRepository;
  BinanceSellCoinRepositoryImpl binanceSellCoinRepository;
  BinanceBuyCoinRepositoryImpl binanceBuyCoinRepository;
  BinanceGetAllRepositoryImpl binanceGetAllRepository;
  BinanceExchangeInfoRepositoryImpl binanceExchangeInfoRepository;
  // BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  @override
  Stream<SellPortfolioState> mapEventToState(SellPortfolioEvent event) async* {
    if (event is FetchSellPortfolioEvent) {
      totalValue = 0.0;
      pctToSell = 1.0;
      coinTicker = "BTC";
      coinsToRemove = [];
      divisor = 1.0;
      // int i = 0;
      tradeSuccessful = false;

      coinsToSave = {};
      pctToSell = event.value;
      coinTicker = event.coinTicker;
      coinsToRemove = event.coinsToRemove;
      yield SellPortfolioLoadingState();
      
      try {
        BinanceExchangeInfoModel binanceExchangeInfoModel = await binanceExchangeInfoRepository.getBinanceExchangeInfo();
        List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e.filters);
        binanceGetAllModel.removeWhere((i) => coinsToRemove.contains(i.coin));
        debugPrint("8th April - Test 2");
          await Future.forEach(binanceGetAllModel, (v) async {
          debugPrint("8th April - Test 3");
          if(v.coin == coinTicker) {
            debugPrint("Skipping BTC... Because we don't sell $coinTicker to $coinTicker");
            // i++;
          } else {
            try {
              var result;
              if(v.coin == 'USDT') {
                divisor = double.parse(binanceSymbols[coinTicker + v.coin][2].stepSize);
              } else {
                divisor = double.parse(binanceSymbols[v.coin + coinTicker][2].stepSize);
              }
              var tmp = v.free * pctToSell;
              var zeroTarget = tmp % divisor;
              tmp -= zeroTarget;
              if (tmp >= divisor) {
                debugPrint('Coin: ' + v.coin);
                debugPrint('Coin Qty to sell: ' + v.free.toString());
                debugPrint('Divisor(stepSize): ' + divisor.toString());
                debugPrint('Post-Modulo: ' + zeroTarget.toString()); 
                debugPrint('To Sell: ' + tmp.toString());
                debugPrint("\n\nSelling to ticker: " + coinTicker);
                debugPrint('\n\n');
                if(v.coin == 'USDT') {
                  debugPrint("########");
                  result = await binanceBuyCoinRepository.binanceBuyCoin(coinTicker + v.coin, tmp);
                } else {
                  result = await binanceSellCoinRepository.binanceSellCoin(v.coin + coinTicker, tmp);
                }
                debugPrint(result['code'].toString());
                if(result['code'] == null) {
                  totalValue += double.parse(result['cummulativeQuoteQty']);
                  debugPrint("What's wrong now?");
                  // toFirestore[coins.coin] = double.parse(result['cummulativeQuoteQty']);
                  debugPrint("Running totalValue is $totalValue");
                  /// 25th
                  coinsToSave[v.coin] = double.parse(result['cummulativeQuoteQty']);
                  if(tradeSuccessful == false) {
                    tradeSuccessful = true;
                  }
                }
              }
              // i++;
            } catch (e) {
              debugPrint(e.toString());
              debugPrint(v.coin + " does not have a $coinTicker pair on Binance");
              // i++;
            }
          }
        });
        log(totalValue.toString());
        debugPrint(totalValue.toString());
        coinsToSave[coinTicker + "TOTAL"] = totalValue;
        await localStorage.setItem("portfolio", coinsToSave);
        if(tradeSuccessful == true) {
          analytics.logEvent(
            name: "sell_portfolio",
            parameters: {"totalValue": totalValue}
          );
        }

        /// ### This is where we would add to database?? ### ///

        // debugPrint("pushed to firestore");
        // debugPrint("error1");

        // FtxExchangeInfoModel ftxExchangeInfoModel = await ftxExchangeInfoRepository.getFtxExchangeInfo();
        // debugPrint("error2");

        // FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        // debugPrint("error3");

        // Map ftxSymbols = Map.fromIterable(ftxExchangeInfoModel.result, key: (e) => e.name, value: (e) => e.sizeIncrement); /// we need more than just a key and value so maybe change this from Map to something else
        // debugPrint("error4");




/// ### Uncomment below for FTX integration (check bugs) ###
        // for (var coins in ftxGetBalanceModel.result) {
        //   debugPrint("error5");

        //   if (coins.coin == 'BTC/USDT') {
        //     debugPrint("ftx coins.coin = 'BTC/USDT'");
        //   } else if (coins.coin == 'BTC/USD') {
        //     debugPrint("ftx coins.coin = 'BTC/USD'");
        //   } else {
        //     try {
        //       double divisor = ftxSymbols[coins.coin];
        //       var tmp = coins.free;
        //       var zeroTarget = tmp % divisor;
        //       tmp -= zeroTarget;
        //       if (tmp >= divisor) {
        //         debugPrint('Coin: ' + coins.coin);
        //         debugPrint('Coin Qty to sell: ' + coins.free.toString());
        //         debugPrint('Divisor(stepSize): ' + divisor.toString());
        //         debugPrint('Post-Modulo: ' + zeroTarget.toString()); 
        //         debugPrint('To Sell: ' + tmp.toString());
        //         debugPrint('\n');
        //       }

        //       /// sell logic here
              
        //       var result = await ftxSellCoinRepository.ftxSellCoin(coins.coin + '/BTC', tmp);
        //       //  {
        //       //   debugPrint('Coin: ' + coins.coin);
        //       //   var result = await ftxSell`CoinRepository.ftxSellCoin(coins.coin);
        //       // }
        //       debugPrint(result.toString());
        //     } catch (e) {
        //       debugPrint(coins.coin + " does not have a BTC pair on FTX");
        //     }
        //   }
        // }


        // debugPrint("sup");
        // // btcSpecial = binanceGetPricesMap['BTCUSDT'];
        // // yield GetTotalValueLoadedState(totalValue: totalValue, btcSpecial: btcSpecial);
        // debugPrint("nothing is happening here?");

/// ### Uncomment above for ftx integration ### ///

        yield SellPortfolioLoadedState(totalValue: totalValue);
      } catch (e) {
        debugPrint("wallah");
        debugPrint(e.toString());
        yield SellPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}