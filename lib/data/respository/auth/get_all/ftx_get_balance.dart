import 'dart:convert';
import 'package:coinsnap/data/model/auth/get_all/ftx_get_balance_model.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class IFtxGetBalanceRepository {
  Future<FtxGetBalanceModel> getFtxGetBalance();
}

class FtxGetBalanceRepositoryImpl implements IFtxGetBalanceRepository {
  @override
  Future<FtxGetBalanceModel> getFtxGetBalance() async {

    /// ##### Start API Request ######
   
    String _ftxUrl = 'ftx.com';
    String requestUrl = 'https://' + _ftxUrl + '/api/wallet/balances';

    /// ##### Temporary API Key load-ins ###### 
    /// ##### TODO: Add Key storage implementation ###### 
    String api = "mykdwU8Sde4IHAs0LNMPIYGUZ4wIR6wVdYpZZo_q";
    String sapi = "nI5jp5mGREebIeaOP0kWv_TQrwVOID0Nj5XIPe-i";

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String signatureBuilder = timestamp + 'GET' + '/api/wallet/balances';
    var sapiHmac = utf8.encode(sapi);
    var signatureBuilderHmac = utf8.encode(signatureBuilder);
    var hmac256 = new Hmac(sha256, sapiHmac);
    var digest = hmac256.convert(signatureBuilderHmac);

    /// ###### Make API Call #####
    var response = await http.get(requestUrl, headers: {
      'FTX-KEY': api,
      'FTX-TS': timestamp,
      'FTX-SIGN': digest.toString()
    });

    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      // log(body.toString());

      FtxGetBalanceModel ftxGetBalanceModel = FtxGetBalanceModel.fromJson(Map.from(json.decode(response.body)));

      // log(ftxGetBalanceModel.toString());
      return ftxGetBalanceModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      throw Exception();
    }
  }
}