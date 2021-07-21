import 'package:coinsnap/features/data/binance_api_check.dart';
import 'package:coinsnap/features/data/coingecko_image/repos/coingecko_coin_repo.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';

import 'package:localstorage/localstorage.dart';

class CheckBinanceApi extends StatefulWidget {
  @override
  _CheckBinanceApiState createState() => _CheckBinanceApiState();
}

class _CheckBinanceApiState extends State<CheckBinanceApi> {
  String api = '';
  String sapi = '';
  bool sanityCheck = true;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (sanityCheck == true) {
      if (arguments == null) {
        debugPrint("CheckBinanceApi arguments is null");
        log("CheckBinanceApi arguments is null");
      } else {
        api = arguments['api'];
        sapi = arguments['sapi'];
      }
      checkApi(api, sapi);
      sanityCheck = false;
    }
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2B064B), Color(0xFF381AA2)]),
        ),
        child: Column(children: <Widget>[
          SizedBox(height: 250),
          Text("Checking API...", style: TextStyle(fontSize: 24)),
          SizedBox(height: 50),
          loadingTemplateWidget()
        ]),
      ),
    );
  }

  void checkApi(String api, String sapi) async {
    bool response = await BinanceApiCheckRepositoryImpl()
        .getBinanceApiCheckLatest(api, sapi);
    if (response) {
      final secureStorage = FlutterSecureStorage();
      await secureStorage.write(key: 'binanceApi', value: api);
      await secureStorage.write(key: 'binanceSapi', value: sapi);
      await secureStorage.write(key: 'trading', value: 'true');
      await secureStorage.write(key: 'binance', value: 'true');
      // fire call to coingecko here
      CoingeckoCoinRepoImpl coingeckoRepo = CoingeckoCoinRepoImpl();
      // get the response and parse it
      await coingeckoRepo.getCoins().then((_) => _parseCoingeckoCoins());

      Navigator.pushNamed(context, '/modalsuccess');
    } else {
      Navigator.pushNamed(context, '/modalfailure');
    }
  }

  /// Parse the full list of coins from Coingecko into our own map
  /// with coin symbol as key, and other values as properties.
  /// Then it saves it into localstorage.
  void _parseCoingeckoCoins() async {
    // assume we have the api response saved to localstorage
    // get it from localstorage
    LocalStorage localStorage = LocalStorage('coinstreetapp');
    await localStorage.ready.then(
      (_) {
        List<dynamic> coingeckoCoins = localStorage.getItem('coingeckoCoins');

        // parse each element into our own map of coingecko coins
        Map<String, Map> parsedCoingeckoCoins = Map.fromIterable(coingeckoCoins,
        key: (item) => item['symbol'].toString(),
        value: (item) => item);

        // save into localstorage
        localStorage.setItem('parsedCoingeckoCoins', parsedCoingeckoCoins);
      },
    );
  }
}
