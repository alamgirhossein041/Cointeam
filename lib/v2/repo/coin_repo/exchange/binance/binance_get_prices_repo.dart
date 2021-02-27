import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_prices_model.dart';
import 'package:http/http.dart' as http;

// import 'dart:developer';

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
      return binanceGetPricesModel;
    } else {
      throw Exception();
    }
  }
}