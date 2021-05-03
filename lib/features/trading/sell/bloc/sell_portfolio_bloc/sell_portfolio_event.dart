import 'package:equatable/equatable.dart';

abstract class SellPortfolioEvent extends Equatable {}

class FetchSellPortfolioEvent extends SellPortfolioEvent {
  final double value;
  final String coinTicker;
  final List<String> coinsToRemove;

  FetchSellPortfolioEvent({this.value, this.coinTicker, this.coinsToRemove});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}