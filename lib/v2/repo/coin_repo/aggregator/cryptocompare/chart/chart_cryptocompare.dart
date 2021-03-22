import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/aggregator/cryptocompare/chart/chart_cryptocompare.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class ICryptoCompareRepository  {
  Future getHourlyCryptoCompare();
}

class CryptoCompareRepositoryImpl implements ICryptoCompareRepository {

  @override
  Future getHourlyCryptoCompare() async {
    
    String requestUrl = 'https://min-api.cryptocompare.com/data/v2/histohour?fsym=BTC&tsym=USD&limit=24';

    var stopWatch = Stopwatch()..start();
    var response = await http.get(requestUrl);
    stopWatch.stop();
    log("CryptoCompare: " + stopWatch.elapsedMilliseconds.toString());
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      // CryptoCompareModel cryptoCompareModel = CryptoCompareModel.fromJson(body);
      CryptoCompareHourlyModel cryptoCompareModelChart = CryptoCompareHourlyModel.fromJsonToChart(body);
      return cryptoCompareModelChart;
    } else {
      throw Exception();
    }
  }
}