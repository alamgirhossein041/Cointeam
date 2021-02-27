import 'dart:convert';
import 'package:coinsnap/v1/data/model/unauth/prices/binance_get_prices.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class IBinanceGetPricesRepository  {
  Future getBinancePricesInfo();
}

class BinanceGetPricesRepositoryImpl implements IBinanceGetPricesRepository {

  @override
  Future getBinancePricesInfo() async {
    String requestUrl = 'https://api.binance.com/api/v3/ticker/price';

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      // log(response.body.toString());
      List<BinanceGetPricesModel> binanceGetPricesModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetPricesModel>((json) => BinanceGetPricesModel.fromJson(json)).toList();
      // List<BinanceGetPricesModel> binanceGetPricesModel = json.decode(response.body)((json) => BinanceGetPricesModel.fromJson(json)).toList();
      // Map<String, dynamic> body = Map.from(json.decode(response.body));
      // log("prolly error here");
      // BinanceGetPricesModel binanceGetPricesModel = BinanceGetPricesModel.fromJson(body);
      // return "binanceGetPricesModel"; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
      return binanceGetPricesModel;
    } else {
      throw Exception();
    }
  }
}