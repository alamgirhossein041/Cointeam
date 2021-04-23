import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/modules/chart/models/binance_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/modules/utils/global_library.dart' as globals;

abstract class IBinanceGetChartRepository  {
  Future getBinanceChart(String coinTicker, var timeSelection);
}

class BinanceGetChartRepositoryImpl implements IBinanceGetChartRepository {

  @override
  Future getBinanceChart(String coinTicker, var timeSelection) async {
    String interval;
    String limit;

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

    String signatureBuilder = "?symbol=" + coinTicker + "USDT" + "&interval=" + interval + "&limit=" + limit;
    String requestUrl = 'https://www.binance.com/api/v3/klines' + signatureBuilder;
    var stopWatch = Stopwatch()..start();
    var response = await http.get(requestUrl);
    stopWatch.stop();
    if(response.statusCode == 200) {
      BinanceGetChartModel binanceGetChartModel = BinanceGetChartModel.fromJson(json.decode(response.body), coinTicker);
      return binanceGetChartModel;
    } else {
      return BinanceGetChartModel(coinTicker: coinTicker, kLineList: []);
    }
  }
}





