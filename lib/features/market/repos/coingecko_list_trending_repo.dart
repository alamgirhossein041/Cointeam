import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/features/market/models/coingecko_list_trending_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

abstract class ICoingeckoListTrendingRepository  {
  Future getCoingeckoListTrending();
}

class CoingeckoListTrendingRepositoryImpl implements ICoingeckoListTrendingRepository {

  @override
  Future getCoingeckoListTrending() async {
    
    String requestUrl = 'https://api.coingecko.com/api/v3/search/trending';

    var stopWatch = Stopwatch()..start();
    var response = await http.get(requestUrl);
    stopWatch.stop();
    debugPrint("Coingecko : " + stopWatch.elapsedMilliseconds.toString());

    if(response.statusCode == 200) {
      // Map<String, dynamic> body = Map.from(json.decode(response.body));
      // List<CoingeckoList250Model> coingeckoList250ModelList = CoingeckoList250Model.fromJson(body);
      // debugPrint("Hello World");
      // List<CoingeckoListTrendingModel> coingeckoListTrendingModelList = json.decode(response.body).cast<Map<String, dynamic>>().map<CoingeckoListTrendingModel>((json) => CoingeckoListTrendingModel.fromJson(json)).toList();
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      log(body.toString());
      // BinanceExchangeInfoModel binanceExchangeInfoModel = BinanceExchangeInfoModel.fromJson(body['coins']);
      List<CoingeckoListTrendingModel> coingeckoListTrendingModelList = body['coins'].cast<Map<String, dynamic>>().map<CoingeckoListTrendingModel>((json) => CoingeckoListTrendingModel.fromJson(json)).toList();
      // Map<String, dynamic> coingeckoMap = {},


      // debugPrint("Goodbye World");
      return coingeckoListTrendingModelList;
    } else {
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      throw Exception();
    }
  }
}