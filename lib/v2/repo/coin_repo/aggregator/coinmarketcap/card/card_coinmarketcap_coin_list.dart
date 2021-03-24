import 'dart:convert';
// import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class ICardCoinmarketcapCoinListRepository  {
  Future getCoinMarketCapCoinList(List coinList);
}

class CardCoinmarketcapCoinListRepositoryImpl implements ICardCoinmarketcapCoinListRepository {

  @override
  Future getCoinMarketCapCoinList(List coinList) async {
    String requestUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?skip_invalid=true&symbol=';
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
    log(requestUrl);

    var response = await http.get(requestUrl, headers: {
      'X-CMC_PRO_API_KEY': api
    });

    // var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      // log("YAY");
      // log(response.body.toString());
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      // log("BOO");
      CardCoinmarketcapListModel cardCoinmarketcapListModel = CardCoinmarketcapListModel.fromJson(body);
      return cardCoinmarketcapListModel;
    } else {
      log(response.body.toString());
      log(response.statusCode.toString());
      throw Exception();
    }
  }
}