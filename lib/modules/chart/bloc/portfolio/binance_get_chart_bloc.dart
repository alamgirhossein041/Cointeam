import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_event.dart';
import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_state.dart';
import 'package:coinsnap/modules/chart/repos/binance_chart.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;

class BinanceGetChartBloc extends Bloc<BinanceGetChartEvent, BinanceGetChartState> {
  
  BinanceGetChartBloc({this.binanceGetChartRepository}) : super(BinanceGetChartInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetChartRepositoryImpl binanceGetChartRepository;

  @override
  Stream<BinanceGetChartState> mapEventToState(BinanceGetChartEvent event) async* {
    if (event is FetchBinanceGetChartEvent) {
      var listOfUserCoins = event.binanceGetAllModelList;
      var binanceGetPricesMap = event.binanceGetPricesMap;
      var timeSelection = event.timeSelection;

      
      yield BinanceGetChartLoadingState();
      try {
        
        Map<String, double> userCoinMap = {};

        var futures = <Future>[];
        for (var f in listOfUserCoins) {
          futures.add(binanceGetChartRepository.getBinanceChart(f, timeSelection));
        }
        
        var resolvedFutures = await Future.wait(futures);
        

        /// Get list of sum of coins price
        Map<int, double> sumMap = {};
        /// priceTimeDataList just takes sum of all coins at timestamp (for now)
        List<SalesData> priceTimeDataList = [];
        for (var g in resolvedFutures) {
          var tmp = g.coinTicker;
          for (var h in g.kLineList) {
            /// ### IF TIME SELECTIONS ### ///
            int timeNow = DateTime.now().millisecondsSinceEpoch;
            int timeOffset = 86100000;
            if(timeSelection == globals.Status.weekly) {
              timeOffset = 603000000;
            } else if (timeSelection == globals.Status.monthly) {
              timeOffset = 2584800000;
            } else if (timeSelection == globals.Status.yearly) {
              timeOffset = 31449600000;
            }
            if(timeNow - timeOffset < h.openTimestamp) {
              if(sumMap[h.openTimestamp] == null) {
                sumMap[h.openTimestamp] = double.parse(h.open) * binanceGetPricesMap[tmp];
              } else {
                if(h.open != null) {
                  sumMap[h.openTimestamp] += double.parse(h.open) * binanceGetPricesMap[tmp];
                }
              }
            }
          }
        }
        int i = 0;
        for(var p in sumMap.keys) {
          i++;
          priceTimeDataList.add(SalesData(time: p.toString(), price: sumMap[p]));
        }
        yield BinanceGetChartLoadedState(binanceGetChartDataList: priceTimeDataList, timeSelection: timeSelection); /// TODO : insert parameters later
      } catch (e) {
        debugPrint(e.toString());
        debugPrint("Something went wrong in binance_get_chart_bloc.dart");
        yield BinanceGetChartErrorState(errorMessage : e.toString());
      }
    }
  }
}

class SalesData {
  SalesData({this.time, this.price});
  /// each time interval does separate API calls 30min ticks?
  String time;
  double price;

}

/// TODO:

/// High-Low chart only for individual coin chart

/// Give options for a lot

/// Stacked Area Chart

/// Volume on individual coins only

