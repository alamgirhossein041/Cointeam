import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';

abstract class CoingeckoGetChartEvent extends Equatable {}

class FetchCoingeckoGetChartEvent extends CoingeckoGetChartEvent {
  final List coinList;
  final Map coinBalancesMap;
  final timeSelection;

  FetchCoingeckoGetChartEvent({this.coinList, this.coinBalancesMap, this.timeSelection});
  @override
  
  /// TODO: stuff
  List<Object> get props => null;
}