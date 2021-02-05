import 'package:coinsnap/data/model/auth/get_all/coinbase_get_account_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CoinbaseGetAccountState extends Equatable {}

class CoinbaseGetAccountInitialState extends CoinbaseGetAccountState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class CoinbaseGetAccountLoadingState extends CoinbaseGetAccountState {

  @override
  List<Object> get props => [];
}

class CoinbaseGetAccountLoadedState extends CoinbaseGetAccountState {

  CoinbaseGetAccountModel coinbaseGetAccountModel;

  CoinbaseGetAccountLoadedState({@required this.coinbaseGetAccountModel});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class CoinbaseGetAccountErrorState extends CoinbaseGetAccountState {

  String errorMessage;

  CoinbaseGetAccountErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}