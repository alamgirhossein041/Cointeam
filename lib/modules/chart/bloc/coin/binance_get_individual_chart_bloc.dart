import 'package:coinsnap/modules/chart/bloc/coin/binance_get_individual_chart_event.dart';
import 'package:coinsnap/modules/chart/bloc/coin/binance_get_individual_chart_state.dart';
import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_bloc.dart';
import 'package:coinsnap/modules/chart/repos/binance_chart.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;

class BinanceGetIndividualChartBloc extends Bloc<BinanceGetIndividualChartEvent, BinanceGetIndividualChartState> {
  
  BinanceGetIndividualChartBloc({this.binanceGetChartRepository}) : super(BinanceGetIndividualChartInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetChartRepositoryImpl binanceGetChartRepository;

  @override
  Stream<BinanceGetIndividualChartState> mapEventToState(BinanceGetIndividualChartEvent event) async* {
    if (event is FetchBinanceGetIndividualChartEvent) {
      var binanceCoin = event.binanceCoin;
      // var binancePrice = event.binancePrice;
      var timeSelection = event.timeSelection;

      
      yield BinanceGetIndividualChartLoadingState();
      try {

        /// resolvedChart is BinanceGetIndividualChartModel
        var resolvedChart = await binanceGetChartRepository.getBinanceChart(binanceCoin, timeSelection);

        Map<int, double> sumMap = {};
        /// priceTimeDataList just takes sum of all coins at timestamp (for now)
        List<SalesData> priceTimeDataList = [];
        int i = 0; /// for each coin we make a list of timestamps

          for (var h in resolvedChart.kLineList) {
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
                sumMap[h.openTimestamp] = double.parse(h.open);
              } else {
                if(h.open != null) {
                  sumMap[h.openTimestamp] += double.parse(h.open);
                }
              }
            }
          }

        for(var p in sumMap.keys) {
          i++;
          priceTimeDataList.add(SalesData(time: p.toString(), price: sumMap[p]));
        }
        
        yield BinanceGetIndividualChartLoadedState(binanceGetIndividualChartData: priceTimeDataList, timeSelection: timeSelection);
      } catch (e) {
        debugPrint(e.toString());
        debugPrint("Something went wrong in binance_get_chart_bloc.dart");
        yield BinanceGetIndividualChartErrorState(errorMessage : e.toString());
      }
    }
  }
}