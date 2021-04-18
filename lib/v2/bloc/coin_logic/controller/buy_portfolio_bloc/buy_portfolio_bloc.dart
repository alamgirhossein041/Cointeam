import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_exchange_info_model.dart';
import 'package:coinsnap/v2/model/db_model/db_porsche/get_portfolio_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_buy_coin_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_exchange_info_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_sell_coin_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
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
        // log("Our coinTicker is : " + coinTicker);

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
          log("Neither USDT or BTC detected");
        }
        
          portfolioList.forEach((v) async {
            if(v == (coinTicker + "TOTAL")) {
              log("Skipping BTC... Because we don't sell $coinTicker to $coinTicker");
            } else {
              try {
                log("Hi?");
                var result;
                // if(v == 'USDT') {
                  // divisor = double.parse(binanceSymbols[coinTicker + coins.coin][2].stepSize);
                // } else {
                divisor = double.parse(binanceSymbols[v + coinTicker][2].stepSize);
                // }
                /// This is where we do the percentage calculation
                
                log(portfolioDataMap.toString());
                log(v);
                log(portfolioDataMap.data.toString());
                log(portfolioDataMap.data[v].toString());
                log(totalBuyQuote.toString());
                ///
                double buyQuantity = double.parse(portfolioDataMap.data[v]);
                // var tmp = (buyQuantity * pctToSell);
                var tmp = (totalBuyQuote * buyQuantity / portfolioDataMap.data[originalCoinTicker]);
                log("tmp before everything is: " + tmp.toString());
                var zeroTarget = double.parse((tmp % divisor).toStringAsFixed(6));
                log("zeroTarget is: " + zeroTarget.toString());
                tmp -= zeroTarget;
                if (tmp >= divisor) {
                  log('Coin: ' + v);
                  // log('Coin Qty to sell: ' + coins.free.toString());
                  log('Divisor(stepSize): ' + divisor.toString());
                  log('Post-Modulo: ' + zeroTarget.toString()); 
                  log('To Buy: ' + tmp.toString());
                  log("\n\nBuying using ticker: " + coinTicker);
                  log('\n\n');
                  if(v == 'USDT') {
                  //   log("########");
                    result = await binanceSellCoinRepository.binanceSellCoin(coinTicker + v, tmp);
                  } else {
                    result = await binanceBuyCoinRepository.binanceBuyCoin(v + coinTicker, tmp);
                  }
                  log(result['code'].toString());
                  if(result['code'] == null) {
                    // totalValue += double.parse(result['cummulativeQuoteQty']);
                    log("We did it?");
                    // toFirestore[coins.coin] = double.parse(result['cummulativeQuoteQty']);
                    // log("Running totalValue is $totalValue");
                    /// 25th
                    // coinsToSave[result['symbol']] = result['cummulativeQuoteQty'];
                  }
                }
          } catch (e) {
            log(e.toString());
          }
            }
          });
        // } catch (e) {
        //   log(e.toString());
        // }
      
      // toFirestore['SoldUSDT'] = totalValue;
      // toFirestore['Timestamp'] = DateTime.now().millisecondsSinceEpoch;
      // log(totalValue.toString());
      // coinsToSave['total'] = totalValue;
      // await localStorage.setItem("portfolio", coinsToSave);
    

          /// ### This is where we would add to database?? ### ///

          // log(toFirestore.toString());
          // firestoreInstance
          //   .collection("Users")
          //   .doc("Wtf")
          //   .update({"PortfolioMap.Portfolio3": toFirestore})
          //   .then((_){});

          /// ### This is where we would add to database?? ### ///

          // totalValue = 0.0;
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

        yield BuyPortfolioLoadedState();
      } catch (e) {
        log("wallah");
        log(e.toString());
        yield BuyPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}