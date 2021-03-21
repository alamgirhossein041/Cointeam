import 'dart:convert';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;
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
    // String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String timestamp = (DateTime.now().millisecondsSinceEpoch).toString();
    log(timestamp);
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
        if(v.name == null) {
          toRemove.add(v);
        }
      });
      // log("`12123`");
      binanceGetAllModel.removeWhere((i) => toRemove.contains(i));
      // log("Something is wrong");
      // log(binanceGetAllModel.toString());
      return binanceGetAllModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      log("excepted");
      log(response.statusCode.toString());
      log(response.body.toString());
      timestamp = ((DateTime.now().millisecondsSinceEpoch) + globals.binanceTimestampModifier).toString();
      
      String signatureBuilder2 = 'timestamp=$timestamp&recvWindow=8000';
      var signatureBuilderHmac2 = utf8.encode(signatureBuilder2);
      var digest2 = hmac256.convert(signatureBuilderHmac2);
      String requestUrl2 = 'https://' + _binanceUrl + '/sapi/v1/capital/config/getall?timestamp=$timestamp&recvWindow=8000&signature=$digest2';

      var response2 = await http.get(requestUrl2, headers: {'X-MBX-APIKEY': api});
      if(response2.statusCode == 200) {
        List<BinanceGetAllModel> binanceGetAllModel = json.decode(response.body).cast<Map<String, dynamic>>().map<BinanceGetAllModel>((json) => BinanceGetAllModel.fromJson(json)).toList();
        // log("asdf");
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
        log("excepted twice, throwing");
        log(response.statusCode.toString());
        log(response.body.toString());
        throw Exception();
      }
    }
  }
}