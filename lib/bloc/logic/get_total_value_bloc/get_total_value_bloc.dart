import 'package:bloc/bloc.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/data/model/auth/get_all/binance_get_all_model.dart';
import 'package:coinsnap/data/model/auth/get_all/coinbase_get_account_model.dart';
import 'package:coinsnap/data/model/auth/get_all/ftx_get_balance_model.dart';
import 'package:coinsnap/data/model/unauth/prices/binance_get_prices.dart';
import 'package:coinsnap/data/respository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/data/respository/auth/get_all/coinbase_get_account.dart';
import 'package:coinsnap/data/respository/auth/get_all/ftx_get_balance.dart';
import 'package:coinsnap/data/respository/unauth/prices/binance_get_prices.dart';
import 'dart:developer';

import 'package:coinsnap/data/respository/unauth/prices/ftx_get_prices.dart';
// import 'package:meta/meta.dart';

class GetTotalValueBloc extends Bloc<GetTotalValueEvent, GetTotalValueState> {
  
  GetTotalValueBloc({this.binanceGetAllRepository, this.coinbaseGetAccountRepository, this.ftxGetBalanceRepository, this.binanceGetPricesRepository, this.ftxGetPricesRepository}) : super(GetTotalValueInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetAllRepositoryImpl binanceGetAllRepository;
  CoinbaseGetAccountRepositoryImpl coinbaseGetAccountRepository;
  FtxGetBalanceRepositoryImpl ftxGetBalanceRepository;

  BinanceGetPricesRepositoryImpl binanceGetPricesRepository;
  FtxGetPricesRepositoryImpl ftxGetPricesRepository;


  @override
  Stream<GetTotalValueState> mapEventToState(GetTotalValueEvent event) async* {
    log(ftxGetBalanceRepository.toString());
    if (event is FetchGetTotalValueEvent) {
      double btcSpecial = 0.0;
      double totalValue = 0.0;
      double usdSpecial = 0.0;
      yield GetTotalValueLoadingState();
      try {

        /// ###### Binance ######
        log(binanceGetAllRepository.toString());
        List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        /// TODO: add together total values
        List<BinanceGetPricesModel> binanceGetPricesModel = await binanceGetPricesRepository.getBinancePricesInfo();
        Map binanceGetPricesMap = Map.fromIterable(binanceGetPricesModel, key: (e) => e.symbol, value: (e) => e.price);
        var btcPrice = binanceGetPricesMap['BTCUSDT'];
        for(BinanceGetAllModel coins in binanceGetAllModel) {
          if(coins.coin == 'BTC') {
            btcSpecial = coins.free;
            totalValue += btcSpecial;
            log(totalValue.toString());
            log((btcSpecial * btcPrice).toString());
            // log("AHJOFIDJSF");
          } else if (coins.coin == 'USDT') {
            usdSpecial += coins.free;
          } else {

            // what do we have
            // coins.coin which could be ETH
            // we are trying to get BTC value
            // just do the calculation you dipshit
            // we also have binanceGetPricesModel
            // which returned literally the price of all coins as a pair
            // 

            try{
              totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.free;
            } catch (e) {
              log(coins.coin + " does not have a BTC pair");
            }
          }
        }

        /// ###### BINANCE ######
        /// 
        /// ###### FTX ######
        /// 
        
        ///   
        log("HELLO WORLD");
        FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        log("HELLO WORLD");
        List<BinanceGetPricesModel> ftxGetPricesModel = await ftxGetPricesRepository.getFtxPricesInfo();
        log("i am lost");
        Map ftxGetPricesMap = Map.fromIterable(binanceGetPricesModel, key: (e) => e.symbol, value: (e) => e.price);

        // log("sup");
        btcSpecial = btcPrice;
        log(totalValue.toString());
        log(btcSpecial.toString());
        yield GetTotalValueLoadedState(totalValue: totalValue, btcSpecial: btcSpecial);
        // log("nothing is happening here?");
      } catch (e) {
        log("wallah");
        yield GetTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}