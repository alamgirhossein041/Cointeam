import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;
import 'package:flutter/material.dart';

abstract class IBinanceGetAllRepository {
  Future<List<BinanceGetAllModel>> getBinanceGetAll();
}

class BinanceGetAllRepositoryImpl implements IBinanceGetAllRepository {
  @override
  Future<List<BinanceGetAllModel>> getBinanceGetAll() async {
    String _binanceUrl = 'api.binance.com';

    /// ##### Temporary API Key load-ins ###### 
    /// ##### TODO: Add Key storage implementation ###### 
    // String api = "cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU";
    // String sapi = "mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD";

    final secureStorage = FlutterSecureStorage();

    String api = await secureStorage.read(key: "binanceApi");
    String sapi = await secureStorage.read(key: "binanceSapi");

    if(api != null) {
      debugPrint(api);
      debugPrint(sapi);
    } else {
      debugPrint("No API Connected");
      return null;
    }


    /// ##### Start API Request ######
    /// Build our signature and HMAC hash for Binance
    // String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
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
      debugPrint("HELLO WE ARE FIGHTING DREAMERS111");
      // debugPrint(response.body.toString());
      /// Handle API response and parse
      List<BinanceGetAllModel> binanceGetAllModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetAllModel>((json) => BinanceGetAllModel.fromJson(json)).toList();
      // debugPrint("asdf");
      /// Remove coins from list that are empty
      var toRemove = [];
      binanceGetAllModel.forEach((v) {
        if(v.name == null) {
          toRemove.add(v);
        }
      });
      // debugPrint("`12123`");
      binanceGetAllModel.removeWhere((i) => toRemove.contains(i));
      // debugPrint("Something is wrong");
      // debugPrint(binanceGetAllModel.toString());
      return binanceGetAllModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      debugPrint("excepted");
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      debugPrint("HELLO WE ARE FIGHTING DREAMERS222");
      timestamp = ((DateTime.now().millisecondsSinceEpoch) - globals.binanceTimestampModifier).toString();
      
      String signatureBuilder2 = 'timestamp=$timestamp&recvWindow=8000';
      var signatureBuilderHmac2 = utf8.encode(signatureBuilder2);
      var digest2 = hmac256.convert(signatureBuilderHmac2);
      String requestUrl2 = 'https://' + _binanceUrl + '/sapi/v1/capital/config/getall?timestamp=$timestamp&recvWindow=8000&signature=$digest2';

      var response2 = await http.get(requestUrl2, headers: {'X-MBX-APIKEY': api});
      if(response2.statusCode == 200) {
        List<BinanceGetAllModel> binanceGetAllModel = json.decode(response2.body).cast<Map<String, dynamic>>().map<BinanceGetAllModel>((json) => BinanceGetAllModel.fromJson(json)).toList();
        // debugPrint("asdf");
        /// Remove coins from list that are empty
        var toRemove = [];
        binanceGetAllModel.forEach((v) {
          if(v.name == null) {
            toRemove.add(v);
          }
        });
        binanceGetAllModel.removeWhere((i) => toRemove.contains(i));
        return binanceGetAllModel;
      } else {
        debugPrint("excepted twice, throwing");
        debugPrint(response2.statusCode.toString());
        debugPrint(response2.body.toString());
        // debugPrint(e.toString());
      }
    }
  }
}