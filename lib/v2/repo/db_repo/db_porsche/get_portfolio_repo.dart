

import 'package:coinsnap/v2/model/db_model/db_porsche/get_portfolio_model.dart';

abstract class IGetPortfolioRepository {
  GetPortfolioModel getPortfolio();
}

class GetPortfolioImpl implements IGetPortfolioRepository {
  @override
  GetPortfolioModel getPortfolio() {
    return GetPortfolioModel.fromJson(GetPortfolioDummyData.getData);
  }
}

class GetPortfolioDummyData {

 static final getData = 
    {
      'BTC': 40,
      'ETH': 30,
      //  'icon': CryptoFontIcons.BTC,
      //  'iconColor': Colors.orange,
      //  'change': '+3.67%',
      //  'changeValue': '+202.835',
      //  'changeColor': Colors.green,
      'XRP': 25,
      'totalValue': 95
    };
}