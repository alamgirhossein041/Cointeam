import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

abstract class IFtxSellCoinRepository {
  Future ftxSellCoin(String sellTicker, double quantity);
}

class FtxSellCoinRepositoryImpl implements IFtxSellCoinRepository {
  @override

  ftxSellCoin(String sellTicker, double quantity) async {
    String _ftxUrl = 'ftx.com';

    String api = "mykdwU8Sde4IHAs0LNMPIYGUZ4wIR6wVdYpZZo_q";
    String sapi = "nI5jp5mGREebIeaOP0kWv_TQrwVOID0Nj5XIPe-i";
    String requestUrl = 'https://' + _ftxUrl + '' + sellTicker;

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String signatureBuilder = timestamp + 'POST' + 'api/orders';
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);

    var response = await http.get(requestUrl, headers: {
      'FTX-KEY': api,
      'FTX-TS': timestamp,
      'FTX-SIGN': digest.toString()
    });

    if (response.statusCode == 200) {

      Map<String, dynamic> body = Map.from(json.decode(response.body));
      log(body.toString());
    } else {
      throw Exception();
    }
  }
}