import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/chart/global_coinmarketcap_stats_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:math' as math;

abstract class IGlobalCoinmarketcapStatsRepository  {
  Future getGlobalCoinmarketcapStats();
}

class GlobalCoinmarketcapStatsRepositoryImpl implements IGlobalCoinmarketcapStatsRepository {

  @override
  Future getGlobalCoinmarketcapStats() async {
    String requestUrl = 'https://pro-api.coinmarketcap.com/v1/global-metrics/quotes/latest';
    String api = "ff43a58e-a138-4738-9dac-ce1d1343a0d5";
    String api2 = "dcf9256e-44d1-4167-8f8d-a0c9e0bb89e5";
    String apiGo = "";
    math.Random random = math.Random();
    int randomNumber = random.nextInt(1000);

    // if(randomNumber >= 500) {
    //   apiGo = api;
    // } else {
      apiGo = api2;
    // }

    var response = await http.get(requestUrl, headers: {
      'X-CMC_PRO_API_KEY': apiGo
    });

    // var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      GlobalCoinmarketcapStatsModel globalCoinmarketcapStatsModel = GlobalCoinmarketcapStatsModel.fromJson(body);
      return globalCoinmarketcapStatsModel;
    } else {
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      throw Exception();
    }
  }
}