import 'dart:convert';
import 'package:coinsnap/data/model/unauth/exchange/coinbase_exchange_info_model.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class ICoinbaseExchangeInfoRepository  {
  Future getCoinbaseExchangeInfo();
}

class CoinbaseExchangeInfoRepositoryImpl implements ICoinbaseExchangeInfoRepository {

  @override
  Future getCoinbaseExchangeInfo() async {
    String requestUrl = 'https://api.pro.coinbase.com/products';

    var response = await http.get(requestUrl);

    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      CoinbaseExchangeInfoModel coinbaseExchangeInfoModel = CoinbaseExchangeInfoModel.fromJson(body);
      return coinbaseExchangeInfoModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      throw Exception();
    }
  }
}
