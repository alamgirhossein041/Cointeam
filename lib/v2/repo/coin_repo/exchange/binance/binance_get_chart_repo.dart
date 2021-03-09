import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_chart_model.dart';
import 'package:http/http.dart' as http;

// import 'dart:developer';

abstract class IBinanceGetChartRepository  {
  Future getBinanceChart(String coinTicker);
}

class BinanceGetChartRepositoryImpl implements IBinanceGetChartRepository {

  @override
  Future getBinanceChart(String coinTicker) async {
    // log(coinTicker);

    String signatureBuilder = "?symbol=" + coinTicker + "USDT" + "&interval=5m" + "&startTime=1615173849000" + "&limit=288";

    String requestUrl = 'https://www.binance.com/api/v3/klines' + signatureBuilder;

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      // log("???!#@#/");
      // log(json.decode(response.body).toString());
      // log(response.body.toString());
      // response.body.forEach((v) => log(v.toString()));
      // log(response.body[0].toString());
      // List<BinanceGetChartModel> binanceGetChartModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetChartModel>((json) => BinanceGetChartModel.fromJson(json)).toList();
      BinanceGetChartModel binanceGetChartModel = BinanceGetChartModel.fromJson(json.decode(response.body), coinTicker);
      log(coinTicker + "Lol");
      
      return binanceGetChartModel;
    } else {
      log(coinTicker + " threw");
      return BinanceGetChartModel(coinTicker: coinTicker, kLineList: []);
    }
  }
}





