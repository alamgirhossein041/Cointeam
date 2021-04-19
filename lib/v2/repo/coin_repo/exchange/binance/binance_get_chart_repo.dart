import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_chart_model.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

// import 'package:flutter/material.dart';

abstract class IBinanceGetChartRepository  {
  Future getBinanceChart(String coinTicker, var timeSelection);
}

class BinanceGetChartRepositoryImpl implements IBinanceGetChartRepository {

  @override
  Future getBinanceChart(String coinTicker, var timeSelection) async {
    // debugPrint(coinTicker);
    String interval;
    String limit;
    String timestamp;

    if(timeSelection == globals.Status.weekly) {
      debugPrint("Weekly");
      interval = '30m';
      limit = '336';
    } else if(timeSelection == globals.Status.monthly) {
      debugPrint("Monthly");
      interval = '2h';
      limit = '360';
    } else if(timeSelection == globals.Status.yearly) {
      debugPrint("Yearly");
      interval = '1d';
      limit = '365';
    } else {
      interval = '5m';
      limit = '288';
    }

    timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    timestamp = 1615291200000.toString();
    
    // debugPrint(timestamp);
    String signatureBuilder = "?symbol=" + coinTicker + "USDT" + "&interval=" + interval + "&limit=" + limit;
    // debugPrint(signatureBuilder);
    // String signatureBuilder = "?symbol=" + coinTicker + "USDT" + "&interval=" + interval + "&limit=" + limit;
    // debugPrint("Hello World");

    String requestUrl = 'https://www.binance.com/api/v3/klines' + signatureBuilder;
    var stopWatch = Stopwatch()..start();
    var response = await http.get(requestUrl);
    stopWatch.stop();
    // debugPrint("Binance: " + stopWatch.elapsedMilliseconds.toString());
    if(response.statusCode == 200) {
      // debugPrint(response.body.toString() + "\n\n");
      // debugPrint("???!#@#/");
      // debugPrint(json.decode(response.body).toString());
      // debugPrint(response.body.toString());
      // response.body.forEach((v) => debugPrint(v.toString()));
      // debugPrint(response.body[0].toString());
      // List<BinanceGetChartModel> binanceGetChartModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetChartModel>((json) => BinanceGetChartModel.fromJson(json)).toList();
      BinanceGetChartModel binanceGetChartModel = BinanceGetChartModel.fromJson(json.decode(response.body), coinTicker);
      // debugPrint(coinTicker + "Lol");
      
      return binanceGetChartModel;
    } else {
      // debugPrint(coinTicker + " threw");
      return BinanceGetChartModel(coinTicker: coinTicker, kLineList: []);
    }
  }
}





