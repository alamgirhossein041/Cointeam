// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_exchange_info_model.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_buy_coin_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_exchange_info_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_sell_coin_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer';

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

  Map<String, dynamic> coinsToSave = {};

  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  // Map<String, dynamic> toFirestore = {};

  // final firestoreInstance = FirebaseFirestore.instance;
  // final firebaseUser = FirebaseAuth.instance.currentUser;

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
      // pctToSell = event.value / 100;
      pctToSell = event.value;
      coinTicker = event.coinTicker;
      coinsToRemove = event.coinsToRemove;

      yield SellPortfolioLoadingState();

      log("8th April - Test 1");

      try {
        log("Our coinTicker is : " + coinTicker);

        BinanceExchangeInfoModel binanceExchangeInfoModel = await binanceExchangeInfoRepository.getBinanceExchangeInfo();
        List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e.filters);
        binanceGetAllModel.removeWhere((i) => coinsToRemove.contains(i.coin));
        log("8th April - Test 2");
        // for(BinanceGetAllModel v in binanceGetAllModel) {
          await Future.forEach(binanceGetAllModel, (v) async {
          log("8th April - Test 3");
          if(v.coin == coinTicker) {
            log("Skipping BTC... Because we don't sell $coinTicker to $coinTicker");
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
                log('Coin: ' + v.coin);
                log('Coin Qty to sell: ' + v.free.toString());
                log('Divisor(stepSize): ' + divisor.toString());
                log('Post-Modulo: ' + zeroTarget.toString()); 
                log('To Sell: ' + tmp.toString());
                log("\n\nSelling to ticker: " + coinTicker);
                log('\n\n');
                if(v.coin == 'USDT') {
                  log("########");
                  result = await binanceBuyCoinRepository.binanceBuyCoin(coinTicker + v.coin, tmp);
                } else {
                  result = await binanceSellCoinRepository.binanceSellCoin(v.coin + coinTicker, tmp);
                }
                log(result['code'].toString());
                if(result['code'] == null) {
                  totalValue += double.parse(result['cummulativeQuoteQty']);
                  log("What's wrong now?");
                  // toFirestore[coins.coin] = double.parse(result['cummulativeQuoteQty']);
                  log("Running totalValue is $totalValue");
                  /// 25th
                  coinsToSave[v.coin] = result['cummulativeQuoteQty'];
                }
              }
              // i++;
            } catch (e) {
              log(e.toString());
              log(v.coin + " does not have a $coinTicker pair on Binance");
              // i++;
            }
          }
          // toFirestore['SoldUSDT'] = totalValue;
          // toFirestore['Timestamp'] = DateTime.now().millisecondsSinceEpoch;

        /// use i++ counter!
        /// 

        });
        log(totalValue.toString());
        coinsToSave[coinTicker + "TOTAL"] = totalValue;
        await localStorage.setItem("portfolio", coinsToSave);

        /// ### This is where we would add to database?? ### ///

        // log(toFirestore.toString());
        // firestoreInstance
        //   .collection("Users")
        //   .doc("Wtf")
        //   .update({"PortfolioMap.Portfolio3": toFirestore})
        //   .then((_){});

        /// ### This is where we would add to database?? ### ///

        // log("pushed to firestore");
        // log("error1");

        // FtxExchangeInfoModel ftxExchangeInfoModel = await ftxExchangeInfoRepository.getFtxExchangeInfo();
        // log("error2");

        // FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        // log("error3");

        // Map ftxSymbols = Map.fromIterable(ftxExchangeInfoModel.result, key: (e) => e.name, value: (e) => e.sizeIncrement); /// we need more than just a key and value so maybe change this from Map to something else
        // log("error4");




/// ### Uncomment below for FTX integration (check bugs) ###
        // for (var coins in ftxGetBalanceModel.result) {
        //   log("error5");

        //   if (coins.coin == 'BTC/USDT') {
        //     log("ftx coins.coin = 'BTC/USDT'");
        //   } else if (coins.coin == 'BTC/USD') {
        //     log("ftx coins.coin = 'BTC/USD'");
        //   } else {
        //     try {
        //       double divisor = ftxSymbols[coins.coin];
        //       var tmp = coins.free;
        //       var zeroTarget = tmp % divisor;
        //       tmp -= zeroTarget;
        //       if (tmp >= divisor) {
        //         log('Coin: ' + coins.coin);
        //         log('Coin Qty to sell: ' + coins.free.toString());
        //         log('Divisor(stepSize): ' + divisor.toString());
        //         log('Post-Modulo: ' + zeroTarget.toString()); 
        //         log('To Sell: ' + tmp.toString());
        //         log('\n');
        //       }

        //       /// sell logic here
              
        //       var result = await ftxSellCoinRepository.ftxSellCoin(coins.coin + '/BTC', tmp);
        //       //  {
        //       //   log('Coin: ' + coins.coin);
        //       //   var result = await ftxSell`CoinRepository.ftxSellCoin(coins.coin);
        //       // }
        //       log(result.toString());
        //     } catch (e) {
        //       log(coins.coin + " does not have a BTC pair on FTX");
        //     }
        //   }
        // }


        // log("sup");
        // // btcSpecial = binanceGetPricesMap['BTCUSDT'];
        // // yield GetTotalValueLoadedState(totalValue: totalValue, btcSpecial: btcSpecial);
        // log("nothing is happening here?");

/// ### Uncomment above for ftx integration ### ///

        yield SellPortfolioLoadedState(totalValue: totalValue);
      } catch (e) {
        log("wallah");
        log(e.toString());
        yield SellPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}