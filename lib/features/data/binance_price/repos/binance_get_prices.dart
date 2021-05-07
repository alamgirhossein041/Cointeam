import 'dart:convert';
import 'package:coinsnap/features/data/binance_price/models/binance_get_prices.dart';
import 'package:http/http.dart' as http;

abstract class IBinanceGetPricesRepository  {
  Future getBinancePricesInfo();
}

class BinanceGetPricesRepositoryImpl implements IBinanceGetPricesRepository {

  @override
  Future getBinancePricesInfo() async {
    String requestUrl = 'https://api.binance.com/api/v3/ticker/price';

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      List<BinanceGetPricesModel> binanceGetPricesModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetPricesModel>((json) => BinanceGetPricesModel.fromJson(json)).toList();
      var map1 = Map.fromIterable(binanceGetPricesModel, key: (e) => e.symbol, value: (e) => e.price);
      return map1;
    } else {
      throw Exception();
    }
  }
}