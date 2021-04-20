import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

import 'package:flutter/material.dart';

abstract class IBinanceApiCheckRepository  {
  Future getBinanceApiCheckLatest();
}

class BinanceApiCheckRepositoryImpl implements IBinanceApiCheckRepository {

  @override
  Future getBinanceApiCheckLatest() async {
    String _binanceUrl = 'api.binance.com';

    /// ##### Temporary API Key load-ins ###### 
    /// ##### TODO: Add Key storage implementation ###### 
    // String api = "cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU";
    // String sapi = "mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD";

    final secureStorage = FlutterSecureStorage();

    String api = await secureStorage.read(key: 'binanceApi');
    String sapi = await secureStorage.read(key: 'binanceSapi');

    /// ### Should probably error check if it's not available lol ### ///
    /// Just chuck a try catch statement for the above ///


    /// ##### Start API Request ######
    /// Build our signature and HMAC hash for Binance
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String signatureBuilder = 'timestamp=$timestamp&recvWindow=8000&coin=BTC';
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);
    String requestUrl = 'https://' + _binanceUrl + '/sapi/v1/capital/deposit/address?' + signatureBuilder + '&signature=$digest';

    /// Make API Call
    var response = await http.post(requestUrl, headers: {'X-MBX-APIKEY': api});

    /// ###### End API Request ######
    if(response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      return 0;
      // throw Exception();
    }
  }
}