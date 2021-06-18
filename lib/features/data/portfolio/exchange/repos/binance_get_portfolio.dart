import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/features/data/portfolio/exchange/models/binance_get_portfolio.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/features/utils/global_library.dart' as globals;
import 'package:flutter/material.dart';

abstract class IBinanceGetAllRepository {
  Future<BinancePortfolioModel> getBinanceGetAll();
}

class BinanceGetAllRepositoryImpl implements IBinanceGetAllRepository {
  @override
  Future<BinancePortfolioModel> getBinanceGetAll() async {
    String _binanceUrl = 'api.binance.com';
    final secureStorage = FlutterSecureStorage();

    String api = await secureStorage.read(key: "binanceApi");
    String sapi = await secureStorage.read(key: "binanceSapi");

    if(api != null) {
      debugPrint("API OK");
    } else {
      debugPrint("No Binance API Connected");
      return null;
    }


    /// ##### Start API Request ######
    /// Build our signature and HMAC hash for Binance
    String timestamp = (DateTime.now().millisecondsSinceEpoch).toString();
    debugPrint(timestamp);
    String signatureBuilder = 'timestamp=$timestamp&recvWindow=8000';
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);
    String requestUrl = 'https://' + _binanceUrl + '/sapi/v1/capital/config/getall?timestamp=$timestamp&recvWindow=8000&signature=$digest';

    /// Make API Call
    var response = await http.get(requestUrl, headers: {'X-MBX-APIKEY': api});

    /// ###### End API Request ######
    
    if(response.statusCode == 200) {
      /// Handle API response and parse
      // BinanceGetAllModel binanceGetAllModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetAllModel>((json) => BinanceGetAllModel.fromJson(json)).toList();
      BinancePortfolioModel binancePortfolioModel = BinancePortfolioModel.fromJson(json.decode(response.body));
      /// Remove coins from list that are empty
      var toRemove = [];
      binancePortfolioModel.data.forEach((k,v) => {
        if(v.total == 0) {
          toRemove.add(k)
        }
      });
      toRemove.forEach((k) => {
        binancePortfolioModel.data.remove(k)
      });
      // binancePortfolioModel.removeWhere((i) => toRemove.contains(i));
      return binancePortfolioModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      for(int i = 0; i < 2 && globals.binanceTimestampModifier == 0; i++) {
        await Future.delayed(Duration(seconds: 1));
      }
      debugPrint("excepted");
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      log("excepted");
      log(response.statusCode.toString());
      log(response.body.toString());
      log("HELLO WE ARE FIGHTING DREAMERS222");
      timestamp = ((DateTime.now().millisecondsSinceEpoch) - globals.binanceTimestampModifier).toString();
      
      String signatureBuilder2 = 'timestamp=$timestamp&recvWindow=8000';
      var signatureBuilderHmac2 = utf8.encode(signatureBuilder2);
      var digest2 = hmac256.convert(signatureBuilderHmac2);
      String requestUrl2 = 'https://' + _binanceUrl + '/sapi/v1/capital/config/getall?timestamp=$timestamp&recvWindow=8000&signature=$digest2';

      var response2 = await http.get(requestUrl2, headers: {'X-MBX-APIKEY': api});
      if(response2.statusCode == 200) {
        BinancePortfolioModel binancePortfolioModel = json.decode(response2.body);
        /// Remove coins from list that are empty
        var toRemove = [];
        binancePortfolioModel.data.forEach((k,v) => {
          if(v.name == null) {
            toRemove.add(k)
          }
        });
        toRemove.forEach((k) => {
          binancePortfolioModel.data.remove(k)
        });
      } else {
        debugPrint("excepted twice, throwing");
        debugPrint(response2.statusCode.toString());
        debugPrint(response2.body.toString());
        log("excepted twice, throwing");
        log(response2.statusCode.toString());
        log(response2.body.toString());
        return null;
      }
    }
  }
}