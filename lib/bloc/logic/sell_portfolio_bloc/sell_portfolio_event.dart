import 'package:equatable/equatable.dart';

abstract class SellPortfolioEvent extends Equatable {}

class FetchSellPortfolioEvent extends SellPortfolioEvent {
  final double value;
  final String coinTicker;

  FetchSellPortfolioEvent({this.value, this.coinTicker});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}