import 'package:coinsnap/modules/portfolio/models/coinmarketcap_coin_data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ListTotalValueState extends Equatable {}

class ListTotalValueInitialState extends ListTotalValueState {

  @override
  List<Object> get props => [];
}

class ListTotalValueLoadingState extends ListTotalValueState {

  @override
  List<Object> get props => [];
}

class ListTotalValueResponseState extends ListTotalValueState {

  @override
  List<Object> get props => [];
}

class ListTotalValueLoadedState extends ListTotalValueState {
  final List coinList;
  final CardCoinmarketcapListModel cardCoinmarketcapListModel;

  ListTotalValueLoadedState({this.coinList, this.cardCoinmarketcapListModel});

  @override
  List<Object> get props => null;
}

class ListTotalValueErrorState extends ListTotalValueState {
  final String errorMessage;

  ListTotalValueErrorState({@required this.errorMessage});

  @override
  List<Object> get props => null;
}