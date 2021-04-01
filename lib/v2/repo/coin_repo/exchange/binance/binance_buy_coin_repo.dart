import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

import 'dart:developer';

abstract class IBinanceBuyCoinRepository {
  Future binanceBuyCoin(String buyTicker, double quantity);
}

class BinanceBuyCoinRepositoryImpl implements IBinanceBuyCoinRepository {
  @override
    binanceBuyCoin(String buyTicker, double quantity) async {
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
    String signatureBuilder = 'timestamp=$timestamp&recvWindow=8000&symbol=' + buyTicker + '&side=BUY&type=MARKET&quoteOrderQty=' + quantity.toStringAsFixed(8);
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);
    log(buyTicker);
    String requestUrl = 'https://' + _binanceUrl + '/api/v3/order?' + signatureBuilder + '&signature=$digest';

    /// Make API Call
    var response = await http.post(requestUrl, headers: {'X-MBX-APIKEY': api});

    /// ###### End API Request ######
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      
      log("Response of Binance buy is: " + body.toString());
      return body;
    } else {
      log("excepted");
      log(response.statusCode.toString());
      log(response.body.toString());
      timestamp = ((DateTime.now().millisecondsSinceEpoch) + globals.binanceTimestampModifier).toString();
      String signatureBuilder2 = 'timestamp=$timestamp&recvWindow=8000&symbol=' + buyTicker + '&side=BUY&type=MARKET&quoteOrderQty=' + quantity.toStringAsFixed(8);
      var signatureBuilderHmac2 = utf8.encode(signatureBuilder2);
      var digest2 = hmac256.convert(signatureBuilderHmac2);
      String requestUrl2 = 'https://' + _binanceUrl + '/api/v3/order?' + signatureBuilder2 + '&signature=$digest2';
      var response2 = await http.post(requestUrl2, headers: {'X-MBX-APIKEY': api});
      if(response2.statusCode == 200) {
        Map<String, dynamic> body = Map.from(json.decode(response.body));
      
        log("Response of Binance buy is: " + body.toString());
        return body;
      } else {
        log("excepted twice, throwing");
        log(response.statusCode.toString());
        log(response.body.toString());
        throw Exception();
      }
    }
  }
}