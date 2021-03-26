import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

import 'dart:developer';

abstract class IBinanceTimeSyncRepository  {
  Future getBinanceTimeSyncLatest();
}

class BinanceTimeSyncRepositoryImpl implements IBinanceTimeSyncRepository {

  @override
  Future getBinanceTimeSyncLatest() async {
    String requestUrl = 'https://api.binance.com/api/v3/time';
    
    
    var stopWatch = Stopwatch()..start();
    var response = await http.get(requestUrl);
    stopWatch.stop();
    var dateTime = DateTime.now().millisecondsSinceEpoch;
    var timeTaken = stopWatch.elapsedMilliseconds;
    // log("Time taken = " + timeTaken.toString());
    timeTaken = (timeTaken~/2);

    if(response.statusCode == 200) {
      var string = json.decode(response.body);

      globals.binanceTimestampModifier = dateTime - string['serverTime'].toInt() - timeTaken;
      log("Global = " + globals.binanceTimestampModifier.toString());
      

      return;
    } else {
      log(response.toString());
      log(response.statusCode.toString());
      throw Exception();
    }
  }
}