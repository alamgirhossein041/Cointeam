import 'dart:convert';
import 'package:coinsnap/modules/data/binance_price/models/binance_exchange_info.dart';
import 'package:http/http.dart' as http;

abstract class IBinanceExchangeInfoRepository  {
  Future getBinanceExchangeInfo();
}

class BinanceExchangeInfoRepositoryImpl implements IBinanceExchangeInfoRepository {

  @override
  Future getBinanceExchangeInfo() async {
    String requestUrl = 'https://www.binance.com/api/v1/exchangeInfo';

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      BinanceExchangeInfoModel binanceExchangeInfoModel = BinanceExchangeInfoModel.fromJson(body);
      return binanceExchangeInfoModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      throw Exception();
    }
  }
}