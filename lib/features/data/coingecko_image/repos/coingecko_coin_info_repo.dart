import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/features/market/models/coingecko_list_top_100_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

abstract class CoingeckoCoinInfoRepo {
  Future<List<CoingeckoListTop100Model>> getCoinInfo(List<String> coins, int page);
}

/// Calls the Coingecko market API of given list of [coins].
/// This gives us the url to its image.
/// Anything in this given list of [coins] must exist in coingecko api.
class CoingeckoCoinInfoRepoImpl implements CoingeckoCoinInfoRepo {
  @override
  Future<List<CoingeckoListTop100Model>> getCoinInfo(List<String> coins, int page) async {
    // print("-------------- getting coingecko coins");
    String coinList = "";
    for (int i = 0; i < coins.length; i++) {
      coinList += coins[i];
      // log(coins[i]);
      if (i + 1 < coins.length) {
        coinList += ',';
      }
    }
    // log(coinList);

    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=$coinList&order=market_cap_desc&per_page=250&page=$page&sparkline=false'));
    
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      // log(response.body.toString());
      // List<dynamic> coingeckoCoinModelList = json.decode(response.body) as List;
      List<CoingeckoListTop100Model> coingeckoCoinModelList = json
          .decode(response.body)
          .cast<Map<String, dynamic>>()
          .map<CoingeckoListTop100Model>(
              (json) => CoingeckoListTop100Model.fromJson(json))
          .toList();
      // debugPrint(response.body);
      // log(coingeckoCoinModelList.toString());

      return coingeckoCoinModelList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log('failed to get coins from conigecko \n ${response.statusCode.toString()}');
      throw Exception(
          'coingecko_coin_info_repo: Failed to get coins from Coingecko market api');
      // return null;
    }
  }
}
