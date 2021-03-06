import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/chart/global_coinmarketcap_stats_model.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class IGlobalCoinmarketcapStatsRepository  {
  Future getGlobalCoinmarketcapStats();
}

class GlobalCoinmarketcapStatsRepositoryImpl implements IGlobalCoinmarketcapStatsRepository {

  @override
  Future getGlobalCoinmarketcapStats() async {
    String requestUrl = 'https://pro-api.coinmarketcap.com/v1/global-metrics/quotes/latest';
    String api = "ff43a58e-a138-4738-9dac-ce1d1343a0d5";

    var response = await http.get(requestUrl, headers: {
      'X-CMC_PRO_API_KEY': api
    });

    // var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      GlobalCoinmarketcapStatsModel globalCoinmarketcapStatsModel = GlobalCoinmarketcapStatsModel.fromJson(body);
      return globalCoinmarketcapStatsModel;
    } else {
      log(response.toString());
      log(response.statusCode.toString());
      throw Exception();
    }
  }
}