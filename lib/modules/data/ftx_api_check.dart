import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/modules/utils/global_library.dart' as globals;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

abstract class IFtxApiCheckRepository  {
  Future getFtxApiCheckLatest(String api, String sapi);
}

class FtxApiCheckRepositoryImpl implements IFtxApiCheckRepository {

  @override
  Future getFtxApiCheckLatest(String api, String sapi) async {
    String _ftxUrl = 'ftx.com';
    String requestUrl = 'https://' + _ftxUrl + '/api/wallet/deposit_address/BTC';

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String signatureBuilder = timestamp + 'GET' + '/api/wallet/deposit_address/BTC';
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);

    var response = await http.get(requestUrl, headers: {
      'FTX-KEY': api,
      'FTX-TS': timestamp,
      'FTX-SIGN': digest.toString()
    });

    var timestamptest = DateTime.now().millisecondsSinceEpoch;
    var timestampFtx = await http.get('https://otc.ftx.com/api/time');
    // log(timestampFtx.body.toString());
    TimestampFtx result = TimestampFtx.fromJson(json.decode(timestampFtx.body));
    // TimestampFtx result = json.decode(timestampFtx.body);
    log(timestamptest.toString());
    // log(result.data.toString());

    var helloWorld = DateTime.parse(result.data['result']);

    log((helloWorld.millisecondsSinceEpoch - timestamptest).toString());

    if(response.statusCode == 200) {
      
    log(response.body.toString());
    // final secureStorage = FlutterSecureStorage();
    // String api = await secureStorage.read(key: 'binanceApi');
    // String sapi = await secureStorage.read(key: 'binanceSapi');

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

class TimestampFtx {
  Map<String, dynamic> data = {};

  TimestampFtx({this.data});

  TimestampFtx.fromJson(json) {
    json.forEach((k,v) {
      data[k] = v;
    });
  }
}