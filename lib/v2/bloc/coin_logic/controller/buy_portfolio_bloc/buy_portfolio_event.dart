import 'package:coinsnap/v2/model/db_model/db_porsche/get_portfolio_model.dart';
import 'package:equatable/equatable.dart';

abstract class BuyPortfolioEvent extends Equatable {}

class FetchBuyPortfolioEvent extends BuyPortfolioEvent {
  final double value;
  final String coinTicker;
  final List<String> portfolioList;
  final GetPortfolioModel portfolioDataMap;
  // final List<String> coinsToRemove;

  // FetchBuyPortfolioEvent({this.value, this.coinTicker, this.coinsToRemove});
  FetchBuyPortfolioEvent({this.value, this.coinTicker, this.portfolioList, this.portfolioDataMap});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}