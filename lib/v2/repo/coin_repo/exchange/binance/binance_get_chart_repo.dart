import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_chart_model.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

// import 'dart:developer';

abstract class IBinanceGetChartRepository  {
  Future getBinanceChart(String coinTicker, var timeSelection);
}

class BinanceGetChartRepositoryImpl implements IBinanceGetChartRepository {

  @override
  Future getBinanceChart(String coinTicker, var timeSelection) async {
    // log(coinTicker);
    String interval;
    String limit;
    String timestamp;

    if(timeSelection == globals.Status.weekly) {
      log("Weekly");
      interval = '30m';
      limit = '336';
    } else if(timeSelection == globals.Status.monthly) {
      log("Monthly");
      interval = '2h';
      limit = '360';
    } else if(timeSelection == globals.Status.yearly) {
      log("Yearly");
      interval = '1d';
      limit = '365';
    } else {
      interval = '5m';
      limit = '288';
    }

    timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    timestamp = 1615291200000.toString();
    
    // log(timestamp);
    String signatureBuilder = "?symbol=" + coinTicker + "USDT" + "&interval=" + interval + "&startTime=" + timestamp + "&limit=" + limit;
    log(signatureBuilder);
    // String signatureBuilder = "?symbol=" + coinTicker + "USDT" + "&interval=" + interval + "&limit=" + limit;
    log("Hello World");

    String requestUrl = 'https://www.binance.com/api/v3/klines' + signatureBuilder;

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      // log(response.body.toString() + "\n\n");
      // log("???!#@#/");
      // log(json.decode(response.body).toString());
      // log(response.body.toString());
      // response.body.forEach((v) => log(v.toString()));
      // log(response.body[0].toString());
      // List<BinanceGetChartModel> binanceGetChartModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetChartModel>((json) => BinanceGetChartModel.fromJson(json)).toList();
      BinanceGetChartModel binanceGetChartModel = BinanceGetChartModel.fromJson(json.decode(response.body), coinTicker);
      // log(coinTicker + "Lol");
      
      return binanceGetChartModel;
    } else {
      // log(coinTicker + " threw");
      return BinanceGetChartModel(coinTicker: coinTicker, kLineList: []);
    }
  }
}





