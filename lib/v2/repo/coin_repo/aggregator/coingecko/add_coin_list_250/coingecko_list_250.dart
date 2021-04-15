import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class ICoingeckoList250Repository  {
  Future getCoinMarketCapCoinLatest(String _pagination);
}

class CoingeckoList250RepositoryImpl implements ICoingeckoList250Repository {

  @override
  Future getCoinMarketCapCoinLatest(String _pagination) async {
    String requestUrl = 'https://api.coingecko.com/api/v3/coins/markets';
    /// ### Dev-Note: Can pass in String parameter and load it into linkBuilder as currency ### ///
    String currency = 'usd'; /// currencyconversion
    String numberOfCoins = '250';
    String pagination = _pagination;
    /// ### Dev-Note: Sparkline below ### ///
    // String sparkline = 'true';
    String percentage = '1h, 24h, 7d';

    String linkBuilder = '?vs_currency=' + currency + '&per_page=' + numberOfCoins + '&page=' + pagination + '&price_change_percentage=' + percentage;

    var stopWatch = Stopwatch()..start();
    var response = await http.get(requestUrl + linkBuilder);
    stopWatch.stop();
    log("Coingecko : " + stopWatch.elapsedMilliseconds.toString());

    if(response.statusCode == 200) {
      // Map<String, dynamic> body = Map.from(json.decode(response.body));
      // List<CoingeckoList250Model> coingeckoList250ModelList = CoingeckoList250Model.fromJson(body);
      // log("Hello World");
      List<CoingeckoList250Model> coingeckoList250ModelList = json.decode(response.body).cast<Map<String, dynamic>>().map<CoingeckoList250Model>((json) => CoingeckoList250Model.fromJson(json)).toList();
      // Map<String, dynamic> coingeckoMap = {},


      // log("Goodbye World");
      return coingeckoList250ModelList;
    } else {
      log(response.toString());
      log(response.statusCode.toString());
      throw Exception();
    }
  }
}