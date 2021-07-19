import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/features/utils/global_library.dart' as globals;

import 'package:flutter/material.dart';

abstract class IBinanceApiCheckRepository  {
  Future getBinanceApiCheckLatest(String api, String sapi);
}

class BinanceApiCheckRepositoryImpl implements IBinanceApiCheckRepository {

  @override
  Future getBinanceApiCheckLatest(String api, String sapi) async {
    String _binanceUrl = 'api.binance.com';
    // final secureStorage = FlutterSecureStorage();
    // String api = await secureStorage.read(key: 'binanceApi');
    // String sapi = await secureStorage.read(key: 'binanceSapi');

    /// ### Should probably error check if it's not available ### ///
    /// Try catch statement for the above ///


    /// ##### Start API Request ######
    /// Build our signature and HMAC hash for Binance
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String signatureBuilder = 'timestamp=$timestamp&recvWindow=8000';
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);
    String requestUrl = 'https://' + _binanceUrl + '/sapi/v1/account/status?' + signatureBuilder + '&signature=$digest';
    log(requestUrl);

    /// Make API Call
    var response = await http.get(requestUrl, headers: {'X-MBX-APIKEY': api});

    /// ###### End API Request ######
    if(response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.toString());
      debugPrint(response.statusCode.toString());
      log(response.body.toString());
      log(response.statusCode.toString());
      return false;
    }
  }
}