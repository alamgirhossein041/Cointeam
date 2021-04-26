import 'dart:convert';
import 'package:coinsnap/modules/portfolio/models/coinmarketcap_coin_data.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

abstract class ICardCoinmarketcapCoinListRepository  {
  Future getCoinMarketCapCoinList(List coinList);
}

class CardCoinmarketcapCoinListRepositoryImpl implements ICardCoinmarketcapCoinListRepository {

  @override
  Future getCoinMarketCapCoinList(List coinList) async {
    String currency = "USD";
    LocalStorage storage = LocalStorage("settings");
    await storage.ready.then((_) {currency = storage.getItem("currency");});
    String requestUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?skip_invalid=true&convert=' +
                        currency + '&symbol=';
    String api = "ff43a58e-a138-4738-9dac-ce1d1343a0d5";
    String signatureBuilder = '';

    for (int i=0; i < coinList.length; i++) {
      if(coinList[i] != 'SBTC') {
        signatureBuilder += coinList[i];
        if(i+1 < coinList.length) {
          signatureBuilder += ',';
        }
      }
    }
    
    requestUrl += signatureBuilder;
    debugPrint(requestUrl);

    var response = await http.get(requestUrl, headers: {
      'X-CMC_PRO_API_KEY': api
    });

    // var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      // debugPrint("YAY");
      // debugPrint(response.body.toString());
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      // debugPrint("BOO");
      CardCoinmarketcapListModel cardCoinmarketcapListModel = CardCoinmarketcapListModel.fromJson(body);
      return cardCoinmarketcapListModel;
    } else {
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      throw Exception();
    }
  }
}