import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/data/repository/main_api/coingecko_api.dart';
import 'package:coinsnap/data/repository/main_api/cryptocompare_api.dart';

final logger = Logger();
void main(List<String> args) {
  final dio = Dio(); // Provide a dio instance
  dio.options.headers["Demo-Header"] =
      "demo header"; // config your dio headers globally
  //final client = CoinGeckoApiClient(dio);
  final client = CryptoCompareApiClient(dio);

  //final response = await client.presentation("Token hiden402a108784a3f67017ae9f5b64349ceba5");

  //log(client.toString());
  //client.getCoinGeckoCoinList().then((it) => logger.i(it));
  client
      .getCryptoCompareHistoHour(
          "Token 5bce3be73345c2f634eee12bfabc469e39f78ca3a99d4b0c83db43f7fd7faaf5")
      .then((it) {
    logger.d(it);
  }).catchError((Object obj) {
    // non-200 error goes here.
    switch (obj.runtimeType) {
      case DioError:
        // Here's the sample to get the failed response error code and message
        final res = (obj as DioError).response;
        logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        break;
      default:
    }
  });
}
