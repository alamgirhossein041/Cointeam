import 'package:coinsnap/features/data/binance_price/binance_price.dart';
import 'package:coinsnap/features/services/firebase_analytics.dart';
import 'package:coinsnap/features/trading/trading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:developer';

class SellPortfolioBloc extends Bloc<SellPortfolioEvent, SellPortfolioState> {

  SellPortfolioBloc({this.binanceBuyCoinRepository, this.binanceSellCoinRepository,
  this.binanceGetAllRepository, this.binanceExchangeInfoRepository}) : super(SellPortfolioInitialState());

  double totalValue = 0.0;
  double quantity = 0.0;
  double pctToSell = 1.0;
  String coinTicker = "BTC";
  List<String> coinsToRemove = [];
  double divisor = 1.0;
  bool tradeSuccessful = false;
  bool preview = true;
  int basePrecision = 8;
  Map<String, dynamic> coinDataStructure = {};

  Map<String, dynamic> coinsToSave = {};

  final LocalStorage localStorage = LocalStorage("coinstreetapp");
  BinanceSellCoinRepositoryImpl binanceSellCoinRepository;
  BinanceBuyCoinRepositoryImpl binanceBuyCoinRepository;
  BinanceGetAllRepositoryImpl binanceGetAllRepository;
  BinanceExchangeInfoRepositoryImpl binanceExchangeInfoRepository;

  @override
  Stream<SellPortfolioState> mapEventToState(SellPortfolioEvent event) async* {
    if (event is FetchSellPortfolioEvent) {
      totalValue = 0.0;
      pctToSell = 1.0;
      coinTicker = "BTC";
      coinsToRemove = [];
      divisor = 1.0;
      tradeSuccessful = false;
      coinsToSave = {};
      pctToSell = event.value;
      coinTicker = event.coinTicker;
      coinsToRemove = event.coinsToRemove;
      // preview = event.preview;
      // log(preview.toString());
      // log("HELLO");
      yield SellPortfolioLoadingState();
      
      try {
        BinanceExchangeInfoModel binanceExchangeInfoModel = await binanceExchangeInfoRepository.getBinanceExchangeInfo();
        List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e);
        binanceGetAllModel.removeWhere((i) => coinsToRemove.contains(i.coin));
        await Future.forEach(binanceGetAllModel, (v) async {
          log("Hi");
          debugPrint("8th April - Test 3");
          if(v.coin == coinTicker) {
            debugPrint("Skipping BTC... Because we don't sell $coinTicker to $coinTicker");
          } else {
            try {
              var result;
              if(v.coin == 'USDT') {
                divisor = double.parse(binanceSymbols[coinTicker + v.coin].filters[2].stepSize);
              } else {
                divisor = double.parse(binanceSymbols[v.coin + coinTicker].filters[2].stepSize);
                basePrecision = binanceSymbols[v.coin + coinTicker].baseAssetPrecision;
              }
              var tmp = v.free * pctToSell;
              var zeroTarget = tmp % divisor;
              tmp -= zeroTarget;
              if (tmp >= divisor) {
                log('Coin: ' + v.coin);
                log('Coin Qty to sell: ' + v.free.toString());
                log('Divisor(stepSize): ' + divisor.toString());
                log('Post-Modulo: ' + zeroTarget.toString()); 
                log('To Sell: ' + tmp.toString());
                log("\n\nSelling to ticker: " + coinTicker);
                log('\n\n');
                double quantityTmp;
                double valueTmp;
                if(v.coin == 'USDT') {
                  debugPrint("########");
                  result = await binanceBuyCoinRepository.binanceBuyCoin(coinTicker + v.coin, tmp);
                  log("Pretending to sell");
                  quantityTmp = double.parse(result['cummulativeQuoteQty']);
                  valueTmp = double.parse(result['executedQty']);
                } else {
                  log("Uh hello");
                  result = await binanceSellCoinRepository.binanceSellCoin(v.coin + coinTicker, tmp, basePrecision);
                  log("Pretending to sell 2");
                  quantityTmp = double.parse(result['executedQty']);
                  valueTmp = double.parse(result['cummulativeQuoteQty']);
                  log("????????");
                  log("quantity of " + v.coin + " is " + quantityTmp.toString());
                  log("value of " + v.coin + " is " + valueTmp.toString());
                }
                debugPrint(result['code'].toString());
                if(result['code'] == null) {
                  totalValue += double.parse(result['cummulativeQuoteQty']);
                  debugPrint("What's wrong now?");
                  debugPrint("Running totalValue is $totalValue");
                  /// 25th
                  Map<String, dynamic> coinData = {};
                  coinData["quantity"] = quantityTmp;
                  coinData["value"] = valueTmp;
                  coinsToSave[v.coin] = coinData;
                  log(v.coin);
                  log(coinsToSave[v.coin].toString());
                  log(coinsToSave.toString());
                  if(tradeSuccessful == false) {
                    tradeSuccessful = true;
                  }
                }
              }
            } catch (e) {
              log(e.toString());
              debugPrint(e.toString());
              debugPrint(v.coin + " does not have a $coinTicker pair on Binance");
            }
          }
        });
        log(totalValue.toString());
        debugPrint(totalValue.toString());
        log(coinsToSave.toString());
        coinDataStructure["coins"] = coinsToSave;
        log(coinDataStructure["coins"].toString());
        coinDataStructure["currency"] = coinTicker;
        coinDataStructure["total"] = totalValue;
        coinDataStructure["timestamp"] = DateTime.now().millisecondsSinceEpoch;

        var tmp = await localStorage.getItem("portfolio");
        if(tmp == null) {
          List helloWorld = [];
          helloWorld.add(coinDataStructure);
          await localStorage.setItem("portfolio", helloWorld);
        } else {
          tmp.add(coinDataStructure);
          await localStorage.setItem("portfolio", tmp);
        }
        if(tradeSuccessful == true) {
          analytics.logEvent(
            name: "sell_portfolio",
            parameters: {"totalValue": totalValue}
          );
        }
        log(coinDataStructure.toString());
        
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
log("14th July");

        yield SellPortfolioLoadedState(totalValue: totalValue, coinDataStructure: coinDataStructure);
      } catch (e) {
        debugPrint("wallah");
        debugPrint(e.toString());
        yield SellPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}