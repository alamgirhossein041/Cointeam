import 'package:equatable/equatable.dart';

abstract class BuyPortfolioEvent extends Equatable {}

class FetchBuyPortfolioEvent extends BuyPortfolioEvent {
  final double value;
  final String coinTicker;
  final List<String> coinsToRemove;

  FetchBuyPortfolioEvent({this.value, this.coinTicker, this.coinsToRemove});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}