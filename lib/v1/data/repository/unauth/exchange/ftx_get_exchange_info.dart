import 'dart:convert';
import 'package:coinsnap/v1/data/model/unauth/exchange/ftx_exchange_info_model.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class IFtxExchangeInfoRepository {
  Future getFtxExchangeInfo();
}

class FtxExchangeInfoRepositoryImpl implements IFtxExchangeInfoRepository {
  @override
  Future getFtxExchangeInfo() async {

    /// ##### Start API Request ######
   
    String _ftxUrl = 'ftx.com';
    String requestUrl = 'https://' + _ftxUrl + '/api/markets';

    /// ###### Make API Call #####
    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      FtxExchangeInfoModel ftxExchangeInfoModel = FtxExchangeInfoModel.fromJson(Map.from(json.decode(response.body)));
      return ftxExchangeInfoModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      throw Exception();
    }
  }
}