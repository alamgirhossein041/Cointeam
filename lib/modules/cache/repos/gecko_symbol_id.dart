import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/modules/cache/models/gecko_symbol_id.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

abstract class IGeckoSymbolIdRepo {
  Future getGeckoSymbolId();
}

class GeckoSymbolIdRepoImpl implements IGeckoSymbolIdRepo {

  @override
  Future getGeckoSymbolId() async {
    /// The goal here is to cache a new version every month
    /// Check timestamp from now to LocalStorage timestamp
    /// If null as well I guess
    
    final storage = LocalStorage("cache");
    int timestamp1 = DateTime.now().millisecondsSinceEpoch;
    var timestamp2;
    await storage.ready.then((_) {
      timestamp2 = storage.getItem("monthly");
    });
  
    log(timestamp1.toString());
    log(timestamp2.toString());

    if(timestamp2 == null) {
      timestamp2 = 0;
    }

    if((timestamp1 - timestamp2) > 2629800000) {
      /// external repo call
      String requestUrl = 'https://api.coingecko.com/api/v3/coins/list';
      var response = await http.get(requestUrl);
      if(response.statusCode == 200) {
        GeckoSymbolIdMap geckoSymbolIdMap = GeckoSymbolIdMap.fromJson(json.decode(response.body));
        return geckoSymbolIdMap;
      } else {
        log(response.statusCode.toString());
        throw Exception();
      }
    }
  }
}