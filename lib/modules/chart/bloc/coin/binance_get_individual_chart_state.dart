import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BinanceGetIndividualChartState extends Equatable {}

class BinanceGetIndividualChartInitialState extends BinanceGetIndividualChartState {

  @override
  /// TODO: stuff
  List<Object> get props => [];

}

class BinanceGetIndividualChartLoadingState extends BinanceGetIndividualChartState {

  @override
  List<Object> get props => [];
}

class BinanceGetIndividualChartLoadedState extends BinanceGetIndividualChartState {
  final binanceGetIndividualChartData;
  final timeSelection;

  BinanceGetIndividualChartLoadedState({@required this.binanceGetIndividualChartData, this.timeSelection});
  // final BinanceGetIndividualChart;
  // BinanceGetIndividualChartLoadedState({@required this.coinPrice});
  // BinanceGetIndividualChartLoadedState({this.BinanceGetIndividualChart});


  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class BinanceGetIndividualChartErrorState extends BinanceGetIndividualChartState {

  final String errorMessage;

  BinanceGetIndividualChartErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}