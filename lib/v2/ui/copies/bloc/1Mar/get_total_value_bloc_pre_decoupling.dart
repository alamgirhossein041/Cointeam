import 'package:bloc/bloc.dart';

import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_prices_repo.dart';

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

      /// ### Please evaluate why we need the above values and document ### ///

      yield GetTotalValueLoadingState();
      try {
        try{
          // log("Debugging111");

        /// ### Binance ### ///
          List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);
          // yield GetTotalValueCoinListReceivedState(coinListReceived: responses[0]);
          binanceGetPricesMap = Map.fromIterable(responses[1], key: (e) => e.symbol, value: (e) => e.price);
          binanceGetAllModel = responses[0];
          // for(int i=0;i<binanceGetAllModel.length;i++) {

            /// log(binanceGetAllModel[i].name.toString()); 
            /// log(binanceGetAllModel[i].free.toString());
            /// log(binanceGetAllModel[i].locked.toString());
            // log("Debugging222");
            
          // }
        } catch (e) {
          handleError(e);
          log("The error in get_total_value_bloc 1 " + e.toString());
        }
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        /// TODO: add together total values
// log("Debugging333");
      var btcPrice = binanceGetPricesMap['BTCUSDT'];
      for(BinanceGetAllModel coins in binanceGetAllModel) {
        if(coins.coin == 'BTC') {
          btcSpecial += coins.locked;
          btcSpecial += coins.free;
          totalValue += btcSpecial;
        } else if (coins.coin == 'USDT') {
          usdSpecial += coins.locked;
          usdSpecial += coins.free;
          // totalValue += (usdSpecial / btcPrice);
        } else {
          try {
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.locked;
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.free;
          } catch (e) {
            try {
              if(coins.coin == 'AUD') {
                totalValue += coins.locked / binanceGetPricesMap['BTC' + coins.coin];
                totalValue += coins.free / binanceGetPricesMap['BTC' + coins.coin];
              } else {
                log(coins.coin.toString() + " does not have a BTC pair");
              }
            } catch (f) {
              log(coins.coin.toString() + " gave a nested catch error");
              log(f.toString());
            }
           
          }
        }
      }
      // log("Debugging555");
        btcSpecial = btcPrice;
        log(totalValue.toString());
        log(btcSpecial.toString());
        totalValue += usdSpecial / await btcPrice;
        // yield GetTotalValueLoadedState(coinListReceived: binanceGetAllModel, btcSpecial: btcSpecial, totalValue: totalValue);
      } catch (e) {
        log("wallah");
        yield GetTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}