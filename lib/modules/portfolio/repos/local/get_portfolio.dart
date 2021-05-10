import 'package:coinsnap/modules/portfolio/models/local/get_portfolio.dart';
import 'package:localstorage/localstorage.dart';

abstract class IGetPortfolioRepository {
  GetPortfolioModel getPortfolio(String _portfolio);
}

class GetPortfolioImpl implements IGetPortfolioRepository {
  @override
  GetPortfolioModel getPortfolio(String _portfolio) {
    final LocalStorage localStorage = LocalStorage("coinstreetapp");
    var localStorageResponse = localStorage.getItem(_portfolio);
    return GetPortfolioModel.fromJson(localStorageResponse);
  }
}