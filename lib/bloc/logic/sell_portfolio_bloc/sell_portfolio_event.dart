import 'package:equatable/equatable.dart';

abstract class SellPortfolioEvent extends Equatable {}

class FetchSellPortfolioEvent extends SellPortfolioEvent {
  final double value;

  FetchSellPortfolioEvent({this.value});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}