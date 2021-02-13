import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coinsnap/data/model/ui/portfolio_builder_model.dart';

import 'dart:developer';

abstract class IPortfolioBuilderRepository  {
  Future getData();
}

class PortfolioBuilderRepositoryImpl implements IPortfolioBuilderRepository {

  @override
  Future getData() async {
    String requestUrl = 'https://www.binance.com/api/v1/exchangeInfo';

    var response = await http.get(requestUrl);
    if(response.statusCode == 200) {
      Map<String, dynamic> body = Map.from(json.decode(response.body));
      // PortfolioBuilderModel portfolioBuilderModel = PortfolioBuilderModel.fromJson(body);
      // return portfolioBuilderModel; /// Distill down response here https://www.youtube.com/watch?v=27EP04T824Y 13:25
    } else {
      throw Exception();
    }
  }
}