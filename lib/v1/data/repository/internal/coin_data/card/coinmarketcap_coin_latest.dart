import 'dart:convert';
import 'package:coinsnap/v1/data/model/internal/coin_data/card/derivative/card_crypto_data.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class ICoinMarketCapCoinLatestRepository  {
  Future getCoinMarketCapCoinLatest();
}

class CoinMarketCapCoinLatestRepositoryImpl implements ICoinMarketCapCoinLatestRepository {

  @override
  Future getCoinMarketCapCoinLatest() async {

    log("Drilling 11231231");
    String requestUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';
    String api = "ff43a58e-a138-4738-9dac-ce1d1343a0d5";

    var response = await http.get(requestUrl, headers: {
      'X-CMC_PRO_API_KEY': api
    });

    log("Drilling 111");

    // var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      log("drilling 222");
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      CoinMarketCapCoinLatestModel coinMarketCapCoinLatestModel = CoinMarketCapCoinLatestModel.fromJson(body);
      // CoinMarketCapCoinLatestModel cryptoCompareModelChart = CryptoCompareHourlyModel.fromJsonToChart(body);
      // log("CoinMarketCapCoinLatestModel is: " + coinMarketCapCoinLatestModel.data.toString());
      // log("CoinMarketCapCoinLatestModelChart is " + coinMarketCapCoinLatestModel.priceClose.priceClose.toString());
      return coinMarketCapCoinLatestModel;
      // PortfolioBuilderModel portfolioBuilderModel = PortfolioBuilderModel.fromJson(body);
      // return portfolioBuilderModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      log(response.toString());
      log(response.statusCode.toString());
      throw Exception();
    }
  }
}