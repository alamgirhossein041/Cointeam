import 'dart:convert';
import 'package:coinsnap/modules/categories/top100/models/coinmarketcap_top100.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

abstract class ICardCoinmarketcapCoinLatestRepository  {
  Future getCoinMarketCapCoinLatest();
}

class CardCoinmarketcapCoinLatestRepositoryImpl implements ICardCoinmarketcapCoinLatestRepository {

  @override
  Future getCoinMarketCapCoinLatest() async {
    String requestUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';
    String api = "ff43a58e-a138-4738-9dac-ce1d1343a0d5";

    

    var stopWatch = Stopwatch()..start();
    var response = await http.get(requestUrl, headers: {
      'X-CMC_PRO_API_KEY': api
    });
    stopWatch.stop();
    debugPrint("Coinmarketcap: " + stopWatch.elapsedMilliseconds.toString());

    

    // var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      CoinMarketCapCoinLatestModel coinMarketCapCoinLatestModel = CoinMarketCapCoinLatestModel.fromJson(body);
      return coinMarketCapCoinLatestModel;
    } else {
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      throw Exception();
    }
  }
}