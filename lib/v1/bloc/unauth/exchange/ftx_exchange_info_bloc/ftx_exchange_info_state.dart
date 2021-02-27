import 'package:coinsnap/v1/data/model/unauth/exchange/ftx_exchange_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FtxExchangeInfoState extends Equatable {}

class FtxExchangeInfoInitialState extends FtxExchangeInfoState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class FtxExchangeInfoLoadingState extends FtxExchangeInfoState {

  @override
  List<Object> get props => [];
}

class FtxExchangeInfoLoadedState extends FtxExchangeInfoState {

  List<FtxExchangeInfoModel> ftxExchangeInfoModel;

  FtxExchangeInfoLoadedState({@required this.ftxExchangeInfoModel});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class FtxExchangeInfoErrorState extends FtxExchangeInfoState {

  String errorMessage;

  FtxExchangeInfoErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}