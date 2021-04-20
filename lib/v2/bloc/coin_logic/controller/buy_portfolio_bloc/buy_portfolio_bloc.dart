import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_exchange_info_model.dart';
import 'package:coinsnap/v2/model/db_model/db_porsche/get_portfolio_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_buy_coin_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_exchange_info_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_sell_coin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class BuyPortfolioBloc extends Bloc<BuyPortfolioEvent, BuyPortfolioState> {
  
  BuyPortfolioBloc({this.binanceBuyCoinRepository, this.binanceSellCoinRepository, this.binanceExchangeInfoRepository}) : super(BuyPortfolioInitialState());

  // double totalValue = 0.0;
  double totalBuyQuote = 1.0;
  // double pctToSell = 1.0;
  String coinTicker = "USDT";
  // List<String> coinsToRemove = [];
  double divisor = 1.0;
  String originalCoinTicker = "";

  List<String> portfolioList = [];
  GetPortfolioModel portfolioDataMap;

  // Map<String, dynamic> coinsToSave = {};

  // final LocalStorage localStorage = LocalStorage("coinstreetapp");

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
        // List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e.filters);
        /// binanceGetAllModel.removeWhere((i) => coinsToRemove.contains(i.coin));
        /// TODO: Probably need to use coinToRemove
        
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
              debugPrint("Skipping BTC... Because we don't sell $coinTicker to $coinTicker");
            } else {
              try {
                debugPrint("Hi?");
                var result;
                // if(v == 'USDT') {
                  // divisor = double.parse(binanceSymbols[coinTicker + coins.coin][2].stepSize);
                // } else {
                divisor = double.parse(binanceSymbols[v + coinTicker][2].stepSize);
                // }
                /// This is where we do the percentage calculation
                
                debugPrint(portfolioDataMap.toString());
                debugPrint(v);
                debugPrint(portfolioDataMap.data.toString());
                debugPrint(portfolioDataMap.data[v].toString());
                debugPrint(totalBuyQuote.toString());
                ///
                double buyQuantity = double.parse(portfolioDataMap.data[v]);
                // var tmp = (buyQuantity * pctToSell);
                var tmp = (totalBuyQuote * buyQuantity / portfolioDataMap.data[originalCoinTicker]);
                debugPrint("tmp before everything is: " + tmp.toString());
                var zeroTarget = double.parse((tmp % divisor).toStringAsFixed(6));
                debugPrint("zeroTarget is: " + zeroTarget.toString());
                tmp -= zeroTarget;
                if (tmp >= divisor) {
                  debugPrint('Coin: ' + v);
                  // debugPrint('Coin Qty to sell: ' + coins.free.toString());
                  debugPrint('Divisor(stepSize): ' + divisor.toString());
                  debugPrint('Post-Modulo: ' + zeroTarget.toString()); 
                  debugPrint('To Buy: ' + tmp.toString());
                  debugPrint("\n\nBuying using ticker: " + coinTicker);
                  debugPrint('\n\n');
                  if(v == 'USDT') {
                  //   debugPrint("########");
                    result = await binanceSellCoinRepository.binanceSellCoin(coinTicker + v, tmp);
                  } else {
                    result = await binanceBuyCoinRepository.binanceBuyCoin(v + coinTicker, tmp);
                  }
                  debugPrint(result['code'].toString());
                  if(result['code'] == null) {
                    // totalValue += double.parse(result['cummulativeQuoteQty']);
                    debugPrint("We did it?");
                    // toFirestore[coins.coin] = double.parse(result['cummulativeQuoteQty']);
                    // debugPrint("Running totalValue is $totalValue");
                    /// 25th
                    // coinsToSave[result['symbol']] = result['cummulativeQuoteQty'];
                  }
                }
          } catch (e) {
            debugPrint(e.toString());
          }
            }
          });
        // } catch (e) {
        //   debugPrint(e.toString());
        // }
      
      // toFirestore['SoldUSDT'] = totalValue;
      // toFirestore['Timestamp'] = DateTime.now().millisecondsSinceEpoch;
      // debugPrint(totalValue.toString());
      // coinsToSave['total'] = totalValue;
      // await localStorage.setItem("portfolio", coinsToSave);
    

          /// ### This is where we would add to database?? ### ///

          // debugPrint(toFirestore.toString());
          // firestoreInstance
          //   .collection("Users")
          //   .doc("Wtf")
          //   .update({"PortfolioMap.Portfolio3": toFirestore})
          //   .then((_){});

          /// ### This is where we would add to database?? ### ///

          // totalValue = 0.0;
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

        yield BuyPortfolioLoadedState();
      } catch (e) {
        debugPrint("wallah");
        debugPrint(e.toString());
        yield BuyPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}