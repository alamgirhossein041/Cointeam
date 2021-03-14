import 'package:equatable/equatable.dart';

abstract class ListTotalValueEvent extends Equatable {}

class FetchListTotalValueEvent extends ListTotalValueEvent {
  final List coinList;

  FetchListTotalValueEvent({this.coinList});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}
