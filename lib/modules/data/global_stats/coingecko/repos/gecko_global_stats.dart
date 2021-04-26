import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/modules/data/global_stats/coingecko/models/gecko_global_stats.dart';
import 'package:http/http.dart' as http;

abstract class IGeckoGlobalStatsRepo {
  Future getGeckoGlobalStats();
}

class GeckoGlobalStatsRepoImpl implements IGeckoGlobalStatsRepo {
  @override
  Future getGeckoGlobalStats() async {
    String requestUrl = 'https://api.coingecko.com/api/v3/global';
    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      GeckoGlobalStats geckoGlobalStats = GeckoGlobalStats.fromJson(json.decode(response.body));
      return geckoGlobalStats;
    } else {
      log(response.statusCode.toString());
      throw Exception();
    }
  }
}