import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:equatable/equatable.dart';
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;
import 'package:flutter/foundation.dart';

abstract class BinanceGetChartEvent extends Equatable {}

class FetchBinanceGetChartEvent extends BinanceGetChartEvent {
  final List<BinanceGetAllModel> binanceGetAllModelList;
  final Map binanceGetPricesMap;
  var timeSelection;

  FetchBinanceGetChartEvent({this.binanceGetAllModelList, this.binanceGetPricesMap, this.timeSelection});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}