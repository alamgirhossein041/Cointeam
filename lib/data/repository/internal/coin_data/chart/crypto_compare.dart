import 'dart:convert';
import 'package:coinsnap/data/model/internal/coin_data/chart/crypto_compare.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class ICryptoCompareRepository  {
  Future getHourlyCryptoCompare();
}

class CryptoCompareRepositoryImpl implements ICryptoCompareRepository {

  @override
  Future getHourlyCryptoCompare() async {
    
    String requestUrl = 'https://min-api.cryptocompare.com/data/v2/histohour?fsym=BTC&tsym=USD&limit=24';

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      CryptoCompareModel cryptoCompareModel = CryptoCompareModel.fromJson(body);
      CryptoCompareHourlyModel cryptoCompareModelChart = CryptoCompareHourlyModel.fromJsonToChart(body);
      log("CryptoCompareModel is: " + cryptoCompareModel.data.toString());
      // log("CryptoCompareModelChart is " + cryptoCompareModelChart.priceClose.priceClose.toString());
      // log("CryptoCompareModelChart timestamp is " + cryptoCompareModelChart.priceClose.timestamp.toString());
      return cryptoCompareModelChart;
      // PortfolioBuilderModel portfolioBuilderModel = PortfolioBuilderModel.fromJson(body);
      // return portfolioBuilderModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      throw Exception();
    }
  }
}