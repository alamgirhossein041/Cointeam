import 'package:bloc/bloc.dart';
import 'package:coinsnap/modules/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_get_portfolio.dart';
import 'package:coinsnap/modules/data/binance_price/repos/binance_get_prices.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_event.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_state.dart';
import 'package:flutter/material.dart';
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
    if (event is FetchGetTotalValueEvent) {
      double btcSpecial = 0.0;
      double totalValue = 0.0;
      double usdSpecial = 0.0;
      double btcQuantity = 0.0;

      yield GetTotalValueLoadingState();
      try {
        try {
        /// ### Binance ### ///
          List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);
          binanceGetPricesMap = Map.fromIterable(responses[1], key: (e) => e.symbol, value: (e) => e.price);
          yield GetTotalValueResponseState(binanceGetAllModelList: responses[0], binanceGetPricesMap: binanceGetPricesMap);
          binanceGetAllModel = responses[0];
        } catch (e) {
          handleError(e);
          debugPrint("The error in get_total_value_bloc 1 " + e.toString());
        }
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
      var btcPrice = binanceGetPricesMap['BTCUSDT'];
      for(BinanceGetAllModel coins in binanceGetAllModel) {
        if(coins.coin == 'BTC') {
          coins.btcValue = 1.0;
          coins.usdValue = btcPrice;
          coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          btcQuantity += coins.locked;
          btcQuantity += coins.free;
          totalValue += btcQuantity;
        } else if (coins.coin == 'USDT') {
          coins.btcValue = 1.0 / btcPrice;
          coins.usdValue = 1.0;
          coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
          usdSpecial += coins.locked;
          usdSpecial += coins.free;
        } else {
          try {
            coins.btcValue = binanceGetPricesMap[coins.coin + 'BTC'];
            coins.usdValue = coins.btcValue * btcPrice;
            coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.locked;
            totalValue += binanceGetPricesMap[coins.coin + 'BTC'] * coins.free;
          } catch (e) {
            try {
              if(coins.coin == 'AUD') {
                coins.btcValue = 1 / binanceGetPricesMap['BTC' + coins.coin];
                coins.usdValue = binanceGetPricesMap[coins.coin + 'USDT'];
                coins.totalUsdValue = coins.usdValue * (coins.free + coins.locked);
                totalValue += coins.locked / binanceGetPricesMap['BTC' + coins.coin];
                totalValue += coins.free / binanceGetPricesMap['BTC' + coins.coin];
              } else {
                coins.totalUsdValue = 0;
              }
            } catch (f) {
              debugPrint(coins.coin.toString() + " gave a nested catch error");
              debugPrint(f.toString());
            }
           
          }
        }
      }
        btcSpecial = btcPrice;
        debugPrint(totalValue.toString());
        debugPrint(btcSpecial.toString());
        totalValue += usdSpecial / await btcPrice;
        binanceGetAllModel..sort((a, b) => b.totalUsdValue.compareTo(a.totalUsdValue));
        yield GetTotalValueLoadedState(coinListReceived: binanceGetAllModel, btcSpecial: btcSpecial, btcQuantity: btcQuantity, usdSpecial: usdSpecial, totalValue: totalValue, binanceGetPricesMap: binanceGetPricesMap);
      } catch (e) {
        debugPrint("wallah");
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