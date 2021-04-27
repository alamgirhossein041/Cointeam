import 'package:coinsnap/modules/portfolio/models/local/get_portfolio.dart';
import 'package:equatable/equatable.dart';

abstract class BuyPortfolioEvent extends Equatable {}

class FetchBuyPortfolioEvent extends BuyPortfolioEvent {
  final double totalBuyQuote;
  final String coinTicker;
  final List<String> portfolioList;
  final GetPortfolioModel portfolioDataMap;
  // final List<String> coinsToRemove;

  FetchBuyPortfolioEvent({this.totalBuyQuote, this.coinTicker, this.portfolioList, this.portfolioDataMap});
  @override
  List<Object> get props => null;
}