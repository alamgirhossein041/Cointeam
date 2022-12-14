import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/features/utils/global_library.dart' as globals;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

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
    timeTaken = (timeTaken~/2);

    if(response.statusCode == 200) {
      var string = json.decode(response.body);

      globals.binanceTimestampModifier = dateTime - string['serverTime'].toInt() - timeTaken;
      log("Global = " + globals.binanceTimestampModifier.toString());
      

      return;
    } else {
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      throw Exception();
    }
  }
}