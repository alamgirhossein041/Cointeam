import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
// import 'dart:math' as math;

import 'package:localstorage/localstorage.dart';

abstract class IGlobalCoinmarketcapStatsRepository  {
  Future getGlobalCoinmarketcapStats();
}

class GlobalCoinmarketcapStatsRepositoryImpl implements IGlobalCoinmarketcapStatsRepository {

  @override
  Future getGlobalCoinmarketcapStats() async {
    final storage = LocalStorage("settings");
    String currency = "USD";
    await storage.ready.then((_) {currency = storage.getItem("currency");});
    String requestUrl = 'https://pro-api.coinmarketcap.com/v1/global-metrics/quotes/latest?convert=' + currency;
    // String api = "ff43a58e-a138-4738-9dac-ce1d1343a0d5";
    String api2 = "dcf9256e-44d1-4167-8f8d-a0c9e0bb89e5";
    String apiGo = "";
    // math.Random random = math.Random();
    // int randomNumber = random.nextInt(1000);

    // if(randomNumber >= 500) {
    //   apiGo = api;
    // } else {
      apiGo = api2;
    // }

    var response = await http.get(requestUrl, headers: {
      'X-CMC_PRO_API_KEY': apiGo
    });

    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      GlobalCoinmarketcapStatsModel globalCoinmarketcapStatsModel = GlobalCoinmarketcapStatsModel.fromJson(body);
      return globalCoinmarketcapStatsModel;
    } else {
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      log(response.toString());
      log(response.statusCode.toString());
      throw Exception();
    }
  }
}