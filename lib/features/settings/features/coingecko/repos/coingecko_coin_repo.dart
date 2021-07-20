import 'dart:convert';

import 'package:coinsnap/features/settings/features/coingecko/models/coingecko_coin_model.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

abstract class CoingeckoCoinRepo {
  Future<bool> getCoins();
}

class CoingeckoCoinRepoImpl implements CoingeckoCoinRepo {
  @override
  Future<bool> getCoins() async {
    print("-------------- getting all coingecko coins");
    final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/list'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var coins = jsonDecode(response.body) as List;

      // Store in localstorage
      final LocalStorage localStorage = LocalStorage("coinstreetapp");
      await localStorage.ready;
      localStorage.setItem("coingeckoCoins", coins);
      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get coins from Coingecko');
    }
  }
}
