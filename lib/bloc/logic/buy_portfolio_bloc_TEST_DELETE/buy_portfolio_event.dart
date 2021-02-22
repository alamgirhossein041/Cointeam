import 'package:equatable/equatable.dart';

abstract class BuyPortfolioEvent extends Equatable {}

class FetchBuyPortfolioEvent extends BuyPortfolioEvent {
  final double quoteOrderQty;
  final String coinTicker;

  FetchBuyPortfolioEvent({this.quoteOrderQty, this.coinTicker});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}