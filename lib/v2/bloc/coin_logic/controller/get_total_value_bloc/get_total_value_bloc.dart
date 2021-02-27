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

        /// ### Binance ### ///
          List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);
          binanceGetPricesMap = Map.fromIterable(responses[1], key: (e) => e.symbol, value: (e) => e.price);
          binanceGetAllModel = responses[0];
          for(int i=0;i<binanceGetAllModel.length;i++) {

            /// log(binanceGetAllModel[i].name.toString()); 
            /// log(binanceGetAllModel[i].free.toString());
            /// log(binanceGetAllModel[i].locked.toString());
            
          }
        } catch (e) {
          handleError(e);
          log(e.toString());
        }
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        /// TODO: add together total values

      var btcPrice = binanceGetPricesMap['BTCUSDT'];
      for(BinanceGetAllModel coins in binanceGetAllModel) {
        if(coins.coin == 'BTC') {
          btcSpecial += coins.locked;
          btcSpecial += coins.free;
          totalValue += btcSpecial;
        } else if (coins.coin == 'USDT') {
          usdSpecial += coins.locked;
          usdSpecial += coins.free;
        } else {
          try{

            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.locked;
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.free;
          } catch (e) {
            log(e.toString());
          }
        }
      }
        btcSpecial = btcPrice;
        log(totalValue.toString());
        log(btcSpecial.toString());
      } catch (e) {
        log("wallah");
        yield GetTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}