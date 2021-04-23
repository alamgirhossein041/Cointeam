import 'package:equatable/equatable.dart';

abstract class BinanceGetChartEvent extends Equatable {}

class FetchBinanceGetChartEvent extends BinanceGetChartEvent {
  final List binanceGetAllModelList;
  final Map binanceGetPricesMap;
  final timeSelection;

  FetchBinanceGetChartEvent({this.binanceGetAllModelList, this.binanceGetPricesMap, this.timeSelection});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}