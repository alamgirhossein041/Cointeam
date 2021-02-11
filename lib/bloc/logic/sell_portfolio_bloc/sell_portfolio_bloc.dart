import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_state.dart';
import 'package:coinsnap/data/model/auth/get_all/binance_get_all_model.dart';
import 'package:coinsnap/data/model/auth/get_all/ftx_get_balance_model.dart';
import 'package:coinsnap/data/model/unauth/exchange/binance_exchange_info_model.dart';
import 'package:coinsnap/data/model/unauth/exchange/ftx_exchange_info_model.dart';
import 'package:coinsnap/data/repository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/data/repository/auth/get_all/ftx_get_balance.dart';
import 'package:coinsnap/data/repository/auth/sell_coin/binance_sell_coin.dart';
import 'package:coinsnap/data/repository/auth/sell_coin/ftx_sell_coin.dart';
import 'package:coinsnap/data/repository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:coinsnap/data/repository/unauth/exchange/ftx_get_exchange_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer';

class SellPortfolioBloc extends Bloc<SellPortfolioEvent, SellPortfolioState> {
  
  SellPortfolioBloc({this.binanceSellCoinRepository, this.binanceGetAllRepository, this.binanceExchangeInfoRepository, this.ftxGetBalanceRepository, this.ftxExchangeInfoRepository, this.ftxSellCoinRepository}) : super(SellPortfolioInitialState());

  double totalValue = 0.0;
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  FtxSellCoinRepositoryImpl ftxSellCoinRepository;
  FtxGetBalanceRepositoryImpl ftxGetBalanceRepository;
  FtxExchangeInfoRepositoryImpl ftxExchangeInfoRepository;
  BinanceSellCoinRepositoryImpl binanceSellCoinRepository;
  BinanceGetAllRepositoryImpl binanceGetAllRepository;
  BinanceExchangeInfoRepositoryImpl binanceExchangeInfoRepository;
  /// CoinbaseSellCoinRepositoryImpl coinbaseSellCoinRepository;
  /// FtxSellCoinRepositoryImpl ftxSellCoinRepository;

  // BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  @override
  Stream<SellPortfolioState> mapEventToState(SellPortfolioEvent event) async* {
    if (event is FetchSellPortfolioEvent) {
      yield SellPortfolioLoadingState();
      try {


        /// move this to the start of the app somehow at some point (exchangeinfo because it doesn't change)
        BinanceExchangeInfoModel binanceExchangeInfoModel = await binanceExchangeInfoRepository.getBinanceExchangeInfo();
        List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        Map binanceSymbols = Map.fromIterable(binanceExchangeInfoModel.symbols, key: (e) => e.symbol, value: (e) => e.filters);
        // List something; // holy shit we need to do so much
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        /// TODO: add together total values
        /// 
        // List<BinanceGetPricesModel> binanceGetPricesModel = await binanceGetPricesRepository.getBinancePricesInfo();
        // Map binanceGetPricesMap = Map.fromIterable(binanceGetPricesModel, key: (e) => e.symbol, value: (e) => e.price);
        for(BinanceGetAllModel coins in binanceGetAllModel) {
          /// sell each coin to btc
          /// btc can't be sold obviously
          /// need to do the whole divisor check stuff
          /// We actually need to do OCO orders otherwise existing limit order will block our order
          /// We will just delete all orders
          /// We can save list of all existing orders first
          if(coins.coin == 'BTC') {
            /// Skip I guess, maybe increment some info later
            /// We could return a final state with total current BTC to save time... maybe
            log("Skipping BTC... Because we don't sell BTC to BTC!");
          } else {

            // what do we have
            // coins.coin which could be ETH
            // we are trying to get BTC value
            // just do the calculation you dipshit
            // we also have binanceGetPricesModel
            // which returned literally the price of all coins as a pair
            // 

            try{
              /// Check divisor and as long as final amount is greater than both:
              /// minimum size
              /// and minimum BTC lot size
              /// make the API call
              /// if not idk print the condition
              double divisor = double.parse(binanceSymbols[coins.coin + 'BTC'][2].stepSize);
              // log(divisor.toString());
              var tmp = coins.free;
              var zeroTarget = tmp % divisor;
              tmp -= zeroTarget;
              if (tmp >= divisor) {
                log('Coin: ' + coins.coin);
                log('Coin Qty to sell: ' + coins.free.toString());
                log('Divisor(stepSize): ' + divisor.toString());
                log('Post-Modulo: ' + zeroTarget.toString()); 
                log('To Sell: ' + tmp.toString());
                log('\n');
                var result = await binanceSellCoinRepository.binanceSellCoin(coins.coin + 'BTC', tmp);
                if(result['code'] == null) {
                  /// potentially save result into a Model which saves the result
                  /// ..... this Model could be the snapshot?
                  /// Okay: Save the result into a Model, where a List parameter holds the results or something, and each iteration of the Model has the Pct% share of portfolio
                  totalValue += result['cummulativeQuoteQty'];
                }
              }

            } catch (e) {
              log(coins.coin + " does not have a BTC pair on Binance");
            }
          }
          log(totalValue.toString());
        }
        log("error1");

        FtxExchangeInfoModel ftxExchangeInfoModel = await ftxExchangeInfoRepository.getFtxExchangeInfo();
        log("error2");

        FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        log("error3");

        Map ftxSymbols = Map.fromIterable(ftxExchangeInfoModel.result, key: (e) => e.name, value: (e) => e.sizeIncrement); /// we need more than just a key and value so maybe change this from Map to something else
        log("error4");

        for (var coins in ftxGetBalanceModel.result) {
          log("error5");

          if (coins.coin == 'BTC//USDT') {
            log("ftx coins.coin = 'BTC/USDT'");
          } else if (coins.coin == 'BTC/USD') {
            log("ftx coins.coin = 'BTC/USD'");
          } else {
            try {
              double divisor = ftxSymbols[coins.coin];
              var tmp = coins.free;
              var zeroTarget = tmp % divisor;
              tmp -= zeroTarget;
              if (tmp >= divisor) {
                log('Coin: ' + coins.coin);
                log('Coin Qty to sell: ' + coins.free.toString());
                log('Divisor(stepSize): ' + divisor.toString());
                log('Post-Modulo: ' + zeroTarget.toString()); 
                log('To Sell: ' + tmp.toString());
                log('\n');
              }

              /// sell logic here
              
              var result = await ftxSellCoinRepository.ftxSellCoin(coins.coin + '/BTC', tmp);
              //  {
              //   log('Coin: ' + coins.coin);
              //   var result = await ftxSell`CoinRepository.ftxSellCoin(coins.coin);
              // }
              log(result.toString());
            } catch (e) {
              log(coins.coin + " does not have a BTC pair on FTX");
            }
          }
        }


        // log("sup");
        // // btcSpecial = binanceGetPricesMap['BTCUSDT'];
        // // yield GetTotalValueLoadedState(totalValue: totalValue, btcSpecial: btcSpecial);
        // log("nothing is happening here?");
        yield SellPortfolioLoadedState(totalValue: totalValue);
      } catch (e) {
        log("wallah");
        yield SellPortfolioErrorState(errorMessage : e.toString());
      }
    }
  }
}