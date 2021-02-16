import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/data/model/unauth/prices/ftx_get_prices.dart';
import 'package:http/http.dart' as http;


abstract class IFtxGetPricesRepository  {
  Future getFtxPricesInfo();
}

class FtxGetPricesRepositoryImpl implements IFtxGetPricesRepository {

  @override

  Future getFtxPricesInfo() async {
    String requestUrl = 'https://ftx.com/api/markets'; /// GET /markets/{market_name}

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      // List<FtxGetPricesModel> ftxGetPricesModel = json.decode(response.body).cast<Map<String, dynamic>>().map<FtxGetPricesModel>((json) => FtxGetPricesModel.fromJson(json)).toList();
      FtxGetPricesModel ftxGetPricesModel = FtxGetPricesModel.fromJson(Map.from(json.decode(response.body)));

      log(ftxGetPricesModel.toString());
      return ftxGetPricesModel;
    }
    throw Exception();
  }
}