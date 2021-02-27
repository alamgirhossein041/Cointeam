import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/v1/bloc/logic/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/v1/bloc/logic/sell_portfolio_bloc/sell_portfolio_state.dart';
import 'package:coinsnap/v1/data/model/auth/get_all/binance_get_all_model.dart';
import 'package:coinsnap/v1/data/model/auth/get_all/ftx_get_balance_model.dart';
import 'package:coinsnap/v1/data/model/unauth/exchange/binance_exchange_info_model.dart';
import 'package:coinsnap/v1/data/model/unauth/exchange/ftx_exchange_info_model.dart';
import 'package:coinsnap/v1/data/repository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/v1/data/repository/auth/get_all/ftx_get_balance.dart';
import 'package:coinsnap/v1/data/repository/auth/sell_coin/binance_sell_coin.dart';
import 'package:coinsnap/v1/data/repository/auth/sell_coin/ftx_sell_coin.dart';
import 'package:coinsnap/v1/data/repository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:coinsnap/v1/data/repository/unauth/exchange/ftx_get_exchange_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer';

class SellPortfolioBloc extends Bloc<SellPortfolioEvent, SellPortfolioState> {
  
  SellPortfolioBloc({this.binanceSellCoinRepository, this.binanceGetAllRepository, this.binanceExchangeInfoRepository, this.ftxGetBalanceRepository, this.ftxExchangeInfoRepository, this.ftxSellCoinRepository}) : super(SellPortfolioInitialState());

  double totalValue = 0.0;
  double pctToSell = 1.0;
  String coinTicker = "BTC";
  Map<String, dynamic> toFirestore = {};

  final firestoreInstance = FirebaseFirestore.instance;
  // var firestoreUser = FirebaseFirestore.instance.collection('User');
  // var firebaseAuth = FirebaseAuth.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  FtxSellCoinRepositoryImpl ftxSellCoinRepository;
  FtxGetBalanceRepositoryImpl ftxGetBalanceRepository;
  FtxExchangeInfoRepositoryImpl ftxExchangeInfoRepository;
  BinanceSellCoinRepositoryImpl binanceSellCoinRepository;
  BinanceGetAllRepositoryImpl binanceGetAllRepository;
  BinanceExchangeInfoRepositoryImpl binanceExchangeInfoRepository;

  // BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  @override
  Stream<SellPortfolioState> mapEventToState(SellPortfolioEvent event) async* {
    if (event is FetchSellPortfolioEvent) {
      // pctToSell = event.value / 100;
      pctToSell = 1.0;
      coinTicker = event.coinTicker;

      yield SellPortfolioLoadingState();
      try {

        BinanceExchangeInfoModel binanceExchangeInfoModel = await binanceExchangeInfoRepository.getBinanceExchangeInfo();
        List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e.filters);
        for(BinanceGetAllModel coins in binanceGetAllModel) {
          if(coins.coin == coinTicker) {
            log("Skipping BTC... Because we don't sell $coinTicker to $coinTicker");
          } else {
            try {
              double divisor = double.parse(binanceSymbols[coins.coin + coinTicker][2].stepSize);
              var tmp = coins.free * pctToSell;
              var zeroTarget = tmp % divisor;
              tmp -= zeroTarget;
              if (tmp >= divisor) {
                log('Coin: ' + coins.coin);
                log('Coin Qty to sell: ' + coins.free.toString());
                log('Divisor(stepSize): ' + divisor.toString());
                log('Post-Modulo: ' + zeroTarget.toString()); 
                log('To Sell: ' + tmp.toString());
                log('\n');
                var result = await binanceSellCoinRepository.binanceSellCoin(coins.coin + coinTicker, tmp);
                log(result['code'].toString());
                if(result['code'] == null) {
                  totalValue += double.parse(result['cummulativeQuoteQty']);
                  log("What's wrong now?");
                  toFirestore[coins.coin] = double.parse(result['cummulativeQuoteQty']);
                  log("Running totalValue is $totalValue");
                }
              }
            } catch (e) {
              log(coins.coin + " does not have a $coinTicker pair on Binance");
            }
          }
          toFirestore['SoldUSDT'] = totalValue;
          toFirestore['Timestamp'] = DateTime.now().millisecondsSinceEpoch;
          log(totalValue.toString());
        }

        // log(toFirestore.toString());
        // firestoreInstance
        //   .collection("Users")
        //   .doc("Wtf")
        //   .set(toFirestore)
        //   .then((_){});


        log(toFirestore.toString());
        firestoreInstance
          .collection("Users")
          .doc("Wtf")
          .update({"PortfolioMap.Portfolio3": toFirestore})
          .then((_){});

        

        totalValue = 0.0;
        log("pushed to firestore");
        log("error1");

        FtxExchangeInfoModel ftxExchangeInfoModel = await ftxExchangeInfoRepository.getFtxExchangeInfo();
        log("error2");

        FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        log("error3");

        Map ftxSymbols = Map.fromIterable(ftxExchangeInfoModel.result, key: (e) => e.name, value: (e) => e.sizeIncrement); /// we need more than just a key and value so maybe change this from Map to something else
        log("error4");




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
        yield SellPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}