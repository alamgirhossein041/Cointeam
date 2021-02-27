
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v1/bloc/logic/buy_portfolio_bloc_TEST_DELETE/buy_portfolio_event.dart';
import 'package:coinsnap/v1/bloc/logic/buy_portfolio_bloc_TEST_DELETE/buy_portfolio_state.dart';
import 'package:coinsnap/v1/data/model/unauth/exchange/binance_exchange_info_model.dart';
import 'package:coinsnap/v1/data/repository/auth/buy_coin/binance_buy_coin.dart';
import 'package:coinsnap/v1/data/repository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyPortfolioBloc extends Bloc<BuyPortfolioEvent, BuyPortfolioState> {

  BinanceBuyCoinRepositoryImpl binanceBuyCoinRepository;
  BinanceExchangeInfoRepositoryImpl binanceExchangeInfoRepository;
  
  BuyPortfolioBloc({this.binanceExchangeInfoRepository, this.binanceBuyCoinRepository}) : super(BuyPortfolioInitialState());
  
  double quoteOrderQty = 180.0;
  String coinTicker = "USDT";
  var TEMP_COIN_LIST = ["XLM", "DOGE", "BTC"];

  @override
  Stream<BuyPortfolioState> mapEventToState(BuyPortfolioEvent event) async* {
    if (event is FetchBuyPortfolioEvent) {

      yield BuyPortfolioLoadingState();

      try {
        BinanceExchangeInfoModel binanceExchangeInfoModel = await binanceExchangeInfoRepository.getBinanceExchangeInfo();
        // List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e.filters);

        /// #### For test purposes we are only doing US$60 XLM, US$60 DOGE, US$60 BTC ### ///
        for (String coins in TEMP_COIN_LIST) {

          if (coins == coinTicker) {
            log("Skipping BTC... Because we don't buy $coinTicker to $coinTicker");
          } else {
          double divisor = double.parse(binanceSymbols['XLM' + coinTicker][0].tickSize);
          var zeroTarget = 60.0 % divisor;
          var tmp = 60.0 - zeroTarget;
          if (tmp >= divisor) {
            var result = await binanceBuyCoinRepository.binanceBuyCoin(coins + coinTicker, tmp);
            if(result['code'] == null) {
              /// potentially save result into a Model which saves the result
              /// ..... this Model could be the snapshot?
              /// Okay: Save the result into a Model, where a List parameter holds the results or something, and each iteration of the Model has the Pct% share of portfolio
              log(result.toString());
            }
          
        
        
          }
        }
        }
      }catch (e) {
        log("ERROROROROR");
      }
    }
    
  }
}