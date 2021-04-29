import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/modules/portfolio/models/exchanges/binance_get_portfolio.dart';
import 'package:coinsnap/modules/portfolio/repos/exchanges/binance_get_portfolio.dart';
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
  BinancePortfolioModel binancePortfolioModelList;

  @override
  Stream<GetTotalValueState> mapEventToState(GetTotalValueEvent event) async* {
    Map binanceGetPricesMap;
    BinancePortfolioModel binanceGetAllModel;
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
          // binanceGetPricesMap = Map.fromIterable(responses[1], key: (e) => e.symbol, value: (e) => e.price);
          binanceGetPricesMap = responses[1];
          yield GetTotalValueResponseState(binanceGetAllModelList: responses[0], binanceGetPricesMap: binanceGetPricesMap);
          binanceGetAllModel = responses[0];
        } catch (e) {
          debugPrint("The error in get_total_value_bloc 1 " + e.toString());
          log(e.toString());
          handleError(e);
        }
        /// CoinbaseGetAccountModel coinbaseGetAccountModel = await coinbaseGetAccountRepository.getCoinbaseGetAccount();
        /// FtxGetBalanceModel ftxGetBalanceModel = await ftxGetBalanceRepository.getFtxGetBalance();
      var btcPrice = binanceGetPricesMap['BTCUSDT'];
      binanceGetAllModel.data.forEach((k,coins) {
        if(k == 'BTC') {
          coins.btcValue = 1.0;
          coins.usdValue = btcPrice;
          coins.totalUsdValue = coins.usdValue * (coins.total);
          btcQuantity += coins.total;
          totalValue += btcQuantity;
        } else if (k == 'USDT') {
          coins.btcValue = 1.0 / btcPrice;
          coins.usdValue = 1.0;
          coins.totalUsdValue = coins.usdValue * (coins.total);
          usdSpecial += coins.total;
        } else {
          try {
            coins.btcValue = binanceGetPricesMap[k + 'BTC'];
            coins.usdValue = coins.btcValue * btcPrice;
            coins.totalUsdValue = coins.usdValue * (coins.total);
            totalValue += binanceGetPricesMap[k + 'BTC'] * coins.total;
          } catch (e) {
            try {
              if(k == 'AUD') {
                coins.btcValue = 1 / binanceGetPricesMap['BTC' + k];
                coins.usdValue = binanceGetPricesMap[k + 'USDT'];
                coins.totalUsdValue = coins.usdValue * (coins.total);
                totalValue += coins.total / binanceGetPricesMap['BTC' + k];
              } else {
                coins.totalUsdValue = 0.0;
              }
            } catch (f) {
              debugPrint(k.toString() + " gave a nested catch error");
              debugPrint(f.toString());
            }
           
          }
        }
      });
        btcSpecial = btcPrice;
        debugPrint(totalValue.toString());
        debugPrint(btcSpecial.toString());
        totalValue += usdSpecial / await btcPrice;
        List<String> binanceList = binanceGetAllModel.data.keys.toList()..sort((a, b) => binanceGetAllModel.data[b].totalUsdValue.compareTo(binanceGetAllModel.data[a].totalUsdValue));
        // binanceGetAllModel..sort((a, b) => b.totalUsdValue.compareTo(a.totalUsdValue));
        yield GetTotalValueLoadedState(binanceModel: binanceGetAllModel, binanceList: binanceList, btcSpecial: btcSpecial, btcQuantity: btcQuantity, usdSpecial: usdSpecial, totalValue: totalValue, binanceGetPricesMap: binanceGetPricesMap);
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