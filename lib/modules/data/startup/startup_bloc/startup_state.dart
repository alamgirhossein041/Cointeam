import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StartupState extends Equatable {}

class StartupInitialState extends StartupState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class StartupLoadingState extends StartupState {

  @override
  List<Object> get props => [];
}

// class StartupCoinListState extends StartupState {
//   // StartupCoinListState({this.coinList});

//   // final List coinList;

//   @override
//   /// TODO: implement props
//   List<Object> get props => null;
// }

// class StartupGlobalStatsState extends StartupState {

//   @override
//   List<Object> get props => [];
// }

class StartupLoadedState extends StartupState {
  StartupLoadedState({this.totalValue, this.coinListData, this.coinBalancesMap,
                      this.coinList, this.btcSpecial, this.ethSpecial});
  final totalValue;
  final coinListData;
  final coinBalancesMap;
  final coinList;
  final btcSpecial;
  final ethSpecial;

  // StartupLoadedState({this.coinList, this.coinBalancesMap});

  // final List coinList;
  // final coinBalancesMap;

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class StartupErrorState extends StartupState {

  final String errorMessage;

  StartupErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}