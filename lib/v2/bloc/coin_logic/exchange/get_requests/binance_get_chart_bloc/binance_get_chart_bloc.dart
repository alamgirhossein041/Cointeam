import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_chart_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_chart_repo.dart';
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

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
      // log(timeSelection.toString());
      // var mapOfPrices = event.binanceGetPricesMap;
      // Map mapOfPrices = {};
      /// TODO: DELETE mapOfPrices

      
      yield BinanceGetChartLoadingState();
      try {
        // BinanceGetChartModel binanceGetChartModel = await binanceGetChartRepository.getBinanceChart('BTC');
        // log(binanceGetChartModel.toString());
// List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), binanceGetPricesRepository.getBinancePricesInfo()]);

        /// responses is a list of BinanceGetChartModel 1-1 for the listOfUserCoins
        // List responses = await asyncForEach(listOfUserCoins);
        // var futures = <Future>[];
        // for (var b in listOfUserCoins) {
        //   futures.add(binanceGetChartRepository.getBinanceChart(b.coin));
        //   // mapOfPrices[b.coin] = binanceGetChartRepository.getBinanceChart(b.coin),
        // }
        // log("HELLO");
        
        Map<String, double> userCoinMap = {};

        var futures = <Future>[];
          // log("Sup");
          // log(listOfUserCoins.toString());
        for (var f in listOfUserCoins) {
          // log("Sup");
          futures.add(binanceGetChartRepository.getBinanceChart(f, timeSelection));
          /// ### I guess this is where we worry about timerange ### ///
          
          // log("Hello " + f.coin);
          // userCoinMap[f.coin] = binanceGetPricesMap[f.coin];
          /// WE may be able to replace this shitty map implementation by simply passing in the quantity into the binanceGetChartRepository.getBinanceChart method
        }
        
        var resolvedFutures = await Future.wait(futures);
        

        /// Get list of sum of coins price
        // List<double> priceSumList = [];
        // List<int> timestampList = [];
        Map<int, double> sumMap = {};
        /// priceTimeDataList just takes sum of all coins at timestamp (for now)
        List<SalesData> priceTimeDataList = [];
        int i = 0; /// for each coin we make a list of timestamps
        // int j = 0;
        /// for ach timestamp we need to add up all the coins?
        // while (i < 288) {
        //   var timestamp;
        //   var sum;
        //   timestamp = resolvedFutures[0].kLineList.openTimestamp;
        //   log("Timestamp is" + timestamp.toString());

        //   priceSumList.add(

        //   );
        // }

        for (var g in resolvedFutures) {
          // log("What's up " + g.kLineList.toString());
          var tmp = g.coinTicker;
          // log("Quantity of " + g.coinTicker + " is : " + userCoinMap[tmp].toString());
          for (var h in g.kLineList) {
            // log("Dissected " + h.openTimestamp.toString());
            // log("Second " + h.open);

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
                  log(h.toString());
                  log(g.coinTicker);
                  sumMap[h.openTimestamp] += double.parse(h.open) * binanceGetPricesMap[tmp];
                }
              }
            }
            // sumMap[h.openTimestamp] = sumMap[h.openTimestamp] + double.parse(h.open);
            // log("Or");
            // log("Current sum @ " + h.openTimestamp.toString() + " is " + sumMap[h.openTimestamp].toString());
          }
          // priceTimeDataList.add(SalesData(time: g.kLineList[i])
        }

        for(var p in sumMap.keys) {
          // log("I think time is " + p.toString());
          // log("I think price is " + sumMap[p].toString());
          // log("values: + " + i.toString());
          i++;
          // log(p.toString() + " is the time key\n" + sumMap[p].toString() + " is the time value");
          priceTimeDataList.add(SalesData(time: p.toString(), price: sumMap[p]));
        }
        
        


        // var wtf = await Future.wait(listOfUserCoins.map((d) => binanceGetChartRepository.getBinanceChart((d.coin))));
        // // log("HELLO123");
        // // log(wtf[0].coinTicker);
        // Map newmap = Map.fromIterable(wtf,
        //   key: (item) => item.coinTicker,
        //   value: (item) => item);
          // log("HELLO");
        // log(mapOfPrices['ETH'].toString());
        // log(mapOfPrices['IOTA'].toString());
        // log(newmap['BTC'].toString());
        // log(newmap['ETH'].toString());

        // listOfUserCoins.forEach((v) {
        //   mapOfPrices[v.coin] = binanceGetChartRepository.getBinanceChart();
        //   log("This is going to be slow");
        //   log(mapOfPrices[v.coin].toString());
        // });


        // List timestamps = [];
        // List priceCloseSum = [];

        // binanceGetChartModel.kLineList.forEach((v) {
        //   timestamps.add(v.openTimestamp);
        //   // priceCloseSum.add(
        //     // responses.forEach((y) {
        //     //   log("Rawer: " + y.toString());
        //     // });
        // });

        /// At each timestamp, add (coins * coins balance)

        // binanceGetChartModel.kLineList.forEach((v) => 

        // await Future.foreach()

        // log(v.openTimestamp.toString()));
        // log(binanceGetChartModel.toString());
        /// do logic
        /// if else blah blah
        
        yield BinanceGetChartLoadedState(binanceGetChartDataList: priceTimeDataList, timeSelection: timeSelection); /// TODO : insert parameters later
        // log("???/");
      } catch (e) {
        log(e.toString());
        log("Something went wrong in binance_get_chart_bloc.dart");
        yield BinanceGetChartErrorState(errorMessage : e.toString());
      }
    }
  }
  // Future asyncForEach(var listOfUserCoins) async {
  //   List binanceGetChartModelList = [];
  //   Future.forEach(listOfUserCoins, (num) async {
  //     binanceGetChartModelList.add(binanceGetChartRepository.getBinanceChart());
  //   });
  //   return binanceGetChartModelList;
  // }
  
}

class SalesData {
  SalesData({this.time, this.price});
  /// each time interval does separate API calls 30min ticks?
  String time;
  double price;

}


// 1. 

// We check each timestamp
// -- Check coins, check coins % of total, check coin data

// binanceGetChartModel.kLineList.forEach((v) => 

// )




// 2.

// We check each coin
// -- Check each timestamp
// -- Build another array/object with timestamp jonaispkf josdijifp anoi pojn 


//   We have time and price
//   We have user coins

//   Superposition price of user coins totalled by time

//   9am today

// What information do I need?

// Timestamp

// Price @ timestamp

// Coins weight in my portfolio
// -- CoinvalueinUSD / TotalvalueinUSD (both @ that timestamp)

// 0.6 btc
// 0.2 eth
// 1 xrp

// [timestamp data && price]

// 0.6 btc * timestampprice
// 0.2 eth * timestampprice
// 1 xrp * timestampprice

// add them together = totalvalue

// 288 timestamps

// ---- for each timestamp I need to calculate my totalvalue && coinvalue





// List of Coins

// GetPrice[]



// Our Goal: Show a chart with the users total balance over time


// 2. At every timestamp, recalculate the coins % of the portfolio

// Make an individual kline price/time API call to Binance for every coin

// Logic -> 












// linechart



/// High-Low chart only for individual coin chart

/// Give options for a lot

/// Stacked Area Chart

/// Volume on individual coins only

