import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

abstract class IBinanceBuyCoinRepository {
  // Future<List<BinanceSellCoinModel>> binanceSellCoin();
  Future binanceBuyCoin(String buyTicker, double quantity);
}

class BinanceBuyCoinRepositoryImpl implements IBinanceBuyCoinRepository {
  @override
  // Future<List<BinanceSellCoinModel>> binanceSellCoin() async {
    binanceBuyCoin(String buyTicker, double quantity) async {
    String _binanceUrl = 'api.binance.com';

    /// ##### Temporary API Key load-ins ###### 
    /// ##### TODO: Add Key storage implementation ###### 
    String api = "cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU";
    String sapi = "mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD";


    /// ##### Start API Request ######
    /// Build our signature and HMAC hash for Binance
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String signatureBuilder = 'timestamp=$timestamp&recvWindow=8000&symbol=' + buyTicker + '&side=BUY&type=MARKET&quoteOrderQty=' + quantity.toStringAsFixed(8);
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);
    String requestUrl = 'https://' + _binanceUrl + '/api/v3/order?' + signatureBuilder + '&signature=$digest';

    /// Make API Call
    var response = await http.post(requestUrl, headers: {'X-MBX-APIKEY': api});

    /// ###### End API Request ######
    
    Map<String, dynamic> body = Map.from(json.decode(response.body));
    log("Response of Binance buy is: " + body.toString());
    return body;
  }
}