import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetTotalValueState extends Equatable {}

class GetTotalValueInitialState extends GetTotalValueState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class GetTotalValueLoadingState extends GetTotalValueState {

  @override
  List<Object> get props => [];
}

// class GetTotalValueCoinListReceivedState extends GetTotalValueState {

//   var coinListReceived;

//   GetTotalValueCoinListReceivedState({@required this.coinListReceived});


//   @override
//   List<Object> get props => [];
// }

class GetTotalValueLoadedState extends GetTotalValueState {

  final double totalValue;
  final double btcSpecial;
  var coinListReceived;

  GetTotalValueLoadedState({@required this.totalValue, @required this.btcSpecial, @required this.coinListReceived});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetTotalValueErrorState extends GetTotalValueState {

  final String errorMessage;

  GetTotalValueErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}