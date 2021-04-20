import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

import 'package:flutter/material.dart';

abstract class IBinanceSellCoinRepository {
  Future binanceSellCoin(String sellTicker, double quantity);
}

class BinanceSellCoinRepositoryImpl implements IBinanceSellCoinRepository {
  @override
    binanceSellCoin(String sellTicker, double quantity) async {
    String _binanceUrl = 'api.binance.com';

    /// ##### Temporary API Key load-ins ###### 
    /// ##### TODO: Add Key storage implementation ###### 
    // String api = "cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU";
    // String sapi = "mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD";

    final secureStorage = FlutterSecureStorage();

    String api = await secureStorage.read(key: 'binanceApi');
    String sapi = await secureStorage.read(key: 'binanceSapi');

    /// ##### Start API Request ######
    /// Build our signature and HMAC hash for Binance
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String signatureBuilder = 'timestamp=$timestamp&recvWindow=8000&symbol=' + sellTicker + '&side=SELL&type=MARKET&quantity=' + quantity.toStringAsFixed(8);
    debugPrint(signatureBuilder);
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);
    String requestUrl = 'https://' + _binanceUrl + '/api/v3/order?' + signatureBuilder + '&signature=$digest';

    /// Make API Call
    var response = await http.post(requestUrl, headers: {'X-MBX-APIKEY': api});

    /// ###### End API Request ######
    
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      debugPrint("Response of Binance sell is: " + body.toString());
      return body;
    } else {
      debugPrint("Excepted");
      debugPrint("Response Code = " + response.statusCode.toString());
      debugPrint("Response data = " + response.body.toString());
      timestamp = ((DateTime.now().millisecondsSinceEpoch) - globals.binanceTimestampModifier).toString();
      String signatureBuilder2 = 'timestamp=$timestamp&recvWindow=8000&symbol=' + sellTicker + '&side=SELL&type=MARKET&quantity=' + quantity.toStringAsFixed(8);
      var signatureBuilderHmac2 = utf8.encode(signatureBuilder2);
      var digest2 = hmac256.convert(signatureBuilderHmac2);
      String requestUrl2 = 'https://' + _binanceUrl + '/api/v3/order?' + signatureBuilder2 + '&signature=$digest2';
      var response2 = await http.post(requestUrl2, headers: {'X-MBX-APIKEY': api});
      if(response2.statusCode == 200) {
        Map<String, dynamic> body = Map.from(json.decode(response2.body));
        debugPrint("Response of Binance sell is: " + body.toString());
        return body;
      } else {
        debugPrint("Excepted twice, throwing");
        debugPrint("Response Code = " + response2.statusCode.toString());
        debugPrint("Response data = " + response2.body.toString());
        throw Exception();
      }
    }
  }
}