import 'package:coinsnap/v1/data/model/auth/get_all/ftx_get_balance_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FtxGetBalanceState extends Equatable {}

class FtxGetBalanceInitialState extends FtxGetBalanceState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class FtxGetBalanceLoadingState extends FtxGetBalanceState {

  @override
  List<Object> get props => [];
}

class FtxGetBalanceLoadedState extends FtxGetBalanceState {

  FtxGetBalanceModel ftxGetBalanceModel;

  FtxGetBalanceLoadedState({@required this.ftxGetBalanceModel});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class FtxGetBalanceErrorState extends FtxGetBalanceState {

  String errorMessage;

  FtxGetBalanceErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}