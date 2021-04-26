import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BinanceGetChartState extends Equatable {}

class BinanceGetChartInitialState extends BinanceGetChartState {

  @override
  /// TODO: stuff
  List<Object> get props => [];

}

class BinanceGetChartLoadingState extends BinanceGetChartState {

  @override
  List<Object> get props => [];
}

class BinanceGetChartLoadedState extends BinanceGetChartState {
  final List binanceGetChartDataList;
  final timeSelection;

  BinanceGetChartLoadedState({@required this.binanceGetChartDataList, this.timeSelection});
  // final binanceGetChart;
  // BinanceGetChartLoadedState({@required this.coinPrice});
  // BinanceGetChartLoadedState({this.binanceGetChart});


  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class BinanceGetChartErrorState extends BinanceGetChartState {

  final String errorMessage;

  BinanceGetChartErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}