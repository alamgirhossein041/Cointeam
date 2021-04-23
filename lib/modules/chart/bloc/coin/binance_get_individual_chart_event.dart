import 'package:equatable/equatable.dart';

abstract class BinanceGetIndividualChartEvent extends Equatable {}

class FetchBinanceGetIndividualChartEvent extends BinanceGetIndividualChartEvent {
  final String binanceCoin;
  final double binancePrice;
  final timeSelection;

  FetchBinanceGetIndividualChartEvent({this.binanceCoin, this.binancePrice, this.timeSelection});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}