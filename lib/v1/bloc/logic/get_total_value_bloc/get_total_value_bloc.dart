import 'package:bloc/bloc.dart';
import 'dart:developer';

import 'package:coinsnap/v1/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v1/bloc/logic/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v1/data/model/auth/get_all/binance_get_all_model%20copy.dart';
import 'package:coinsnap/v1/data/repository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/v1/data/repository/unauth/prices/binance_get_prices.dart';

// import 'package:meta/meta.dart';


/// @JsonSerializable(nullable: true)
/// 
/// https://stackoverflow.com/questions/53962129/how-to-check-for-null-when-mapping-nested-json

class GetTotalValueBloc extends Bloc<GetTotalValueEvent, GetTotalValueState> {
  
  GetTotalValueBloc({this.binanceGetAllRepository, this.binanceGetPricesRepository}) : super(GetTotalValueInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetAllRepositoryImpl binanceGetAllRepository;

  BinanceGetPricesRepositoryImpl binanceGetPricesRepository;


  @override
  Stream<GetTotalValueState> mapEventToState(GetTotalValueEvent event) async* {
    Map binanceGetPricesMap;
    List<BinanceGetAllModel> binanceGetAllModel;
    // log(ftxGetBalanceRepository.toString());
    if (event is FetchGetTotalValueEvent) {
      double btcSpecial = 0.0;
      double totalValue = 0.0;
      double usdSpecial = 0.0;
      /// ### Please evaluate why we need these and document ### ///

      yield GetTotalValueLoadingState();
      try {
        try{

        /// ### Binance ### ///
        /// 
          // log("Hello World0");
          List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);

          // log("fromIterable = " + responses[1].toString());
          // log("the next one = " + responses[0].toString());
          binanceGetPricesMap = Map.fromIterable(responses[1], key: (e) => e.symbol, value: (e) => e.price);

          // log("Hello World222");
          binanceGetAllModel = responses[0];
          // log("Hello World1");
          for(int i=0;i<binanceGetAllModel.length;i++) {
            // log(binanceGetAllModel[i].name.toString()); 
            // log(binanceGetAllModel[i].free.toString());
            // log(binanceGetAllModel[i].locked.toString());
          }
          // log("Hello World2");
          // log(responses.toString());
          // log("@@@@@@@@@@" + binanceGetAllModel.toString());
        } catch (e) {
          handleError(e);
          log(e.toString());
        }
        // List<BinanceGetAllModel> binanceGetAllModel = await binanceGetAllRepository.getBinanceGetAll();
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        /// TODO: add together total values
        // List<BinanceGetPricesModel> binanceGetPricesModel = await binanceGetPricesRepository.getBinancePricesInfo();

      var btcPrice = binanceGetPricesMap['BTCUSDT'];
      for(BinanceGetAllModel coins in binanceGetAllModel) {
        if(coins.coin == 'BTC') {
          // log("Line 58 BTC " + coins.coin.toString());
          btcSpecial += coins.locked;
          btcSpecial += coins.free;
          // btcSpecial += coins.withdrawing; // We must not do withdrawing because sometimes the withdraw can be complete yet still count as 'withdrawing' within Binance
          totalValue += btcSpecial;
          // log(totalValue.toString());
          // log((btcSpecial * btcPrice).toString());
          // log("AHJOFIDJSF");
        } else if (coins.coin == 'USDT') {
          // log("Line 67 get_total_value_bloc, Coin currently iterating is: " + coins.coin);
          usdSpecial += coins.locked;
          usdSpecial += coins.free;
          // usdSpecial += coins.withdrawing;
        } else {


          // log("Line 74 get_total_value_bloc, Coin currently iterating is: ");

          // what do we have
          // coins.coin which could be ETH
          // we are trying to get BTC value
          // just do the calculation you dipshit
          // we also have binanceGetPricesModel
          // which returned literally the price of all coins as a pair
          // 

          try{

            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.locked;
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.free;
            // totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.withdrawing;
          } catch (e) {
            // log(coins.coin + " does not have a BTC pair");
          }
        }
      }

        /// ###### BINANCE ######
        /// 
        /// ###### FTX ######
        /// 
        
        ///   
        // log("HELLO WORLD: " + totalValue.toString());
        // FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        // log("HELLO WORLD");
        // FtxGetPricesModel ftxGetPricesModel = await ftxGetPricesRepository.getFtxPricesInfo();
        // log("i am lost");
        // Map ftxGetPricesMap = Map.fromIterable(ftxGetPricesModel.result, key: (e) => e.name, value: (e) => e.price);
        // for(dynamic coins in ftxGetBalanceModel.result) {
        //   if(coins.coin == 'BTC') {
        //     btcSpecial += coins.total;
        //     totalValue += coins.total;
        //   } else if (coins.coin == 'USD' || coins.coin == 'USDT') {
        //     usdSpecial += coins.total;
        //   } else {
        //     try {
        //       totalValue += ftxGetPricesMap[coins.coin + '/BTC'] * coins.total;
        //     } catch (e) {
        //       log(coins.coin + " does not have a BTC pair");
        //     }
        //   }
        // }

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