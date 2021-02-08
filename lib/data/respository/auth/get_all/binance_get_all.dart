import 'dart:convert';
import 'package:coinsnap/data/model/auth/get_all/binance_get_all_model.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

abstract class IBinanceGetAllRepository {
  Future<List<BinanceGetAllModel>> getBinanceGetAll();
}

class BinanceGetAllRepositoryImpl implements IBinanceGetAllRepository {
  @override
  Future<List<BinanceGetAllModel>> getBinanceGetAll() async {
    String _binanceUrl = 'api.binance.com';

    /// ##### Temporary API Key load-ins ###### 
    /// ##### TODO: Add Key storage implementation ###### 
    String api = "cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU";
    String sapi = "mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD";


    /// ##### Start API Request ######
    /// Build our signature and HMAC hash for Binance
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
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
      // log(response.body.toString());
      /// Handle API response and parse
      List<BinanceGetAllModel> binanceGetAllModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetAllModel>((json) => BinanceGetAllModel.fromJson(json)).toList();
      // log("asdf");
      /// Remove coins from list that are empty
      var toRemove = [];
      binanceGetAllModel.forEach((v) {
        if(v.free == 0) {
          toRemove.add(v);
        }
      });
      // log("`12123`");
      binanceGetAllModel.removeWhere((i) => toRemove.contains(i));
      // log("Something is wrong");
      log(binanceGetAllModel.toString());
      return binanceGetAllModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      log("excepted");
      throw Exception();
    }
  }
}