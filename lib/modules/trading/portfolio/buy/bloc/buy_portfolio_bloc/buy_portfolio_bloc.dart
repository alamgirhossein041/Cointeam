import 'dart:developer';

import 'package:coinsnap/modules/data/binance_price/models/binance_exchange_info.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_exchange_info.dart';
import 'package:coinsnap/modules/portfolio/repos/exchanges/binance_get_portfolio.dart';
import 'package:coinsnap/modules/portfolio/models/local/get_portfolio.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/bloc/buy_portfolio_bloc/buy_portfolio_event.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/bloc/buy_portfolio_bloc/buy_portfolio_state.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/repos/binance_buy_coin.dart';
import 'package:coinsnap/modules/trading/portfolio/sell/repos/binance_sell_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BuyPortfolioBloc extends Bloc<BuyPortfolioEvent, BuyPortfolioState> {
  
  BuyPortfolioBloc({this.binanceBuyCoinRepository, this.binanceSellCoinRepository, this.binanceExchangeInfoRepository}) : super(BuyPortfolioInitialState());

  // double totalValue = 0.0;
  double totalBuyQuote = 1.0;
  // double pctToSell = 1.0;
  String coinTicker = "USDT";
  // List<String> coinsToRemove = [];
  double divisor = 1.0;
  String originalCoinTicker = "";
  double totalValue = 0.0;

  List<String> portfolioList = [];
  GetPortfolioModel portfolioDataMap;

  // Map<String, dynamic> coinsToSave = {};

  // final LocalStorage localStorage = LocalStorage("coinstreetapp");

  // FtxSellCoinRepositoryImpl ftxSellCoinRepository;
  // FtxGetBalanceRepositoryImpl ftxGetBalanceRepository;
  // FtxExchangeInfoRepositoryImpl ftxExchangeInfoRepository;
  BinanceSellCoinRepositoryImpl binanceSellCoinRepository;
  BinanceBuyCoinRepositoryImpl binanceBuyCoinRepository;
  BinanceGetAllRepositoryImpl binanceGetAllRepository;
  BinanceExchangeInfoRepositoryImpl binanceExchangeInfoRepository;

  // BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  @override
  Stream<BuyPortfolioState> mapEventToState(BuyPortfolioEvent event) async* {
  
    if (event is FetchBuyPortfolioEvent) {
      // pctToSell = event.value / 100;
      totalBuyQuote = event.totalBuyQuote;
      coinTicker = event.coinTicker;
      // coinsToRemove = event.coinsToRemove;
      portfolioList = event.portfolioList;
      portfolioDataMap = event.portfolioDataMap;
      totalBuyQuote = event.totalBuyQuote;

      yield BuyPortfolioLoadingState();
      try {
        // debugPrint("Our coinTicker is : " + coinTicker);

        BinanceExchangeInfoModel binanceExchangeInfoModel = await binanceExchangeInfoRepository.getBinanceExchangeInfo();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e.filters);
        /// binanceGetAllModel.removeWhere((i) => coinsToRemove.contains(i.coin));
        
        /// if(portfolioList != null) {
        
        if(portfolioDataMap.data["USDTTOTAL"] != null) {
          originalCoinTicker = "USDTTOTAL";
        } else if(portfolioDataMap.data["BTCTOTAL"] != null) {
          originalCoinTicker = "BTCTOTAL";
        } else {
          debugPrint("Neither USDT or BTC detected");
        }
        portfolioList.forEach((v) async {
          if(v == (coinTicker + "TOTAL")) {
            debugPrint("Skipping $coinTicker... Because we don't sell $coinTicker to $coinTicker");
            log("Skipping $coinTicker... Because we don't sell $coinTicker to $coinTicker");
          } else {
            try {
              var result;
              // if(v == 'USDT') {
                // divisor = double.parse(binanceSymbols[coinTicker + coins.coin][2].stepSize);
              // } else {
              divisor = double.parse(binanceSymbols[v + coinTicker][2].stepSize);
              // }
              /// This is where we do the percentage calculation
              ///
              double buyQuantity = double.parse(portfolioDataMap.data[v]);
              // var tmp = (buyQuantity * pctToSell);
              totalValue = (totalBuyQuote * buyQuantity / portfolioDataMap.data[originalCoinTicker]);
              var zeroTarget = double.parse((totalValue % divisor).toStringAsFixed(6));
              totalValue -= zeroTarget;
              if (totalValue >= divisor && totalValue > 10) {
                if(v == 'USDT') {
                  if(v != coinTicker) {
                    log(coinTicker);
                    log(v);
                    log(totalValue.toString());
                    result = await binanceSellCoinRepository.binanceSellCoin(coinTicker + v, totalValue);
                    log(result.toString());
                  }
                } else {
                  log("else" + coinTicker);
                  log("else" + v);
                  log("else" + totalValue.toString());
                  result = await binanceBuyCoinRepository.binanceBuyCoin(v + coinTicker, totalValue);
                  log(result.toString());
                }
              }
            } catch (e) {
              log(e.toString());
              debugPrint(e.toString());
            }
          }
        });
    

          /// ### This is where we would add to database?? ### ///

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

        yield BuyPortfolioLoadedState(totalValue: totalValue);
      } catch (e) {
        log("Error in BuyPortfolioBloc");
        debugPrint("Error in BuyPortfolioBloc");
        debugPrint(e.toString());
        yield BuyPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}