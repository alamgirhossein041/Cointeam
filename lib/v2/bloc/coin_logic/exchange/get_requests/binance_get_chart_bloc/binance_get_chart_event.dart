import 'package:coinsnap/v1/data/repository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:equatable/equatable.dart';

abstract class BinanceGetChartEvent extends Equatable {}

class FetchBinanceGetChartEvent extends BinanceGetChartEvent {
  final List<BinanceGetAllModel> binanceGetAllModelList;
  final Map binanceGetPricesMap;

  FetchBinanceGetChartEvent({this.binanceGetAllModelList, this.binanceGetPricesMap});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}