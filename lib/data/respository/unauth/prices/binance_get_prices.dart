import 'dart:convert';
import 'package:coinsnap/data/model/unauth/prices/binance_get_prices.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/data/model/unauth/exchange/binance_exchange_info_model.dart';

import 'dart:developer';

abstract class IBinanceGetPricesRepository  {
  Future getBinancePricesInfo();
}

class BinanceGetPricesRepositoryImpl implements IBinanceGetPricesRepository {

  @override
  Future getBinancePricesInfo() async {
    String requestUrl = 'https://api.binance.com/api/v3/ticker/price';
    // log("ahnyong");

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      // log(response.body.toString());
      List<BinanceGetPricesModel> binanceGetPricesModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetPricesModel>((json) => BinanceGetPricesModel.fromJson(json)).toList();
      // Map<String, dynamic> body = Map.from(json.decode(response.body));
      // log("prolly error here");
      // BinanceGetPricesModel binanceGetPricesModel = BinanceGetPricesModel.fromJson(body);
      return binanceGetPricesModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      throw Exception();
    }
  }
}