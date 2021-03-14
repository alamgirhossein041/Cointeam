import 'package:bloc/bloc.dart';

import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_prices_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// @JsonSerializable(nullable: true)
/// 
/// https://stackoverflow.com/questions/53962129/how-to-check-for-null-when-mapping-nested-json

class GetTotalValueBloc extends Bloc<GetTotalValueEvent, GetTotalValueState> {
  
  GetTotalValueBloc({this.binanceGetAllRepository, this.binanceGetPricesRepository}) : super(GetTotalValueInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetAllRepositoryImpl binanceGetAllRepository;

  BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  List<BinanceGetAllModel> binanceGetAllModelList;

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
        try {


        /// ### Binance ### ///
          List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);
          // log("Hello World");
          binanceGetPricesMap = Map.fromIterable(responses[1], key: (e) => e.symbol, value: (e) => e.price);
          yield GetTotalValueResponseState(binanceGetAllModelList: responses[0], binanceGetPricesMap: binanceGetPricesMap);
          binanceGetAllModel = responses[0];
          // for(int i=0;i<binanceGetAllModel.length;i++) {

            /// log(binanceGetAllModel[i].name.toString());
            /// log(binanceGetAllModel[i].free.toString());
            /// log(binanceGetAllModel[i].locked.toString());]
            
          // }
        } catch (e) {
          handleError(e);
          log("The error in get_total_value_bloc 1 " + e.toString());
        }
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
        /// TODO: add together total values

      var btcPrice = binanceGetPricesMap['BTCUSDT'];
      for(BinanceGetAllModel coins in binanceGetAllModel) {
        if(coins.coin == 'BTC') {
          coins.btcValue = 1.0;
          coins.usdValue = btcPrice;
          coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          btcSpecial += coins.locked;
          btcSpecial += coins.free;
          totalValue += btcSpecial;
        } else if (coins.coin == 'USDT') {
          coins.btcValue = 1.0 / btcPrice;
          coins.usdValue = 1.0;
          coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          usdSpecial += coins.locked;
          usdSpecial += coins.free;
          // totalValue += (usdSpecial / btcPrice);
        } else {
          try {
            coins.btcValue = binanceGetPricesMap[coins.coin + 'BTC'];
            coins.usdValue = coins.btcValue * btcPrice;
            coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.locked;
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.free;
            // log("Price of " + coins.coin + " is \$" + (coins.btcValue * btcPrice).toString());
          } catch (e) {
            try {
              if(coins.coin == 'AUD') {
                coins.btcValue = 1 / binanceGetPricesMap['BTC' + coins.coin];
                coins.usdValue = binanceGetPricesMap[coins.coin + 'USDT'];
                coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
                totalValue += coins.locked / binanceGetPricesMap['BTC' + coins.coin];
                totalValue += coins.free / binanceGetPricesMap['BTC' + coins.coin];
              } else {
                // log(coins.coin.toString() + " does not have a BTC pair");
                coins.totalUsdValue = 0;
              }
            } catch (f) {
              log(coins.coin.toString() + " gave a nested catch error");
              log(f.toString());
            }
           
          }
        }
      }
        btcSpecial = btcPrice;
        log(totalValue.toString());
        log(btcSpecial.toString());
        totalValue += usdSpecial / await btcPrice;
        // binanceGetAllModel.sort();

        binanceGetAllModel..sort((a, b) => b.totalUsdValue.compareTo(a.totalUsdValue));
        yield GetTotalValueLoadedState(coinListReceived: binanceGetAllModel, btcSpecial: btcSpecial, totalValue: totalValue, binanceGetPricesMap: binanceGetPricesMap);
      } catch (e) {
        log("wallah");
        yield GetTotalValueErrorState(errorMessage : e.toString());
      }
    }
  }
}



// class PortfolioCoinListModel {
//   List<BinanceCoinModel>
//   /// -- WE don't even need this
//   List<NormalCoinModel>
//   List<FtxCoinModel>
// }

/// 1. Get list of binance coins
/// 2. Get list of normal coins (local storage)
/// 3. Get Coinmarketcap price data for all those coins
/// 4. fromJson -> PortfolioCoinListModel
/// 5. Yield Model