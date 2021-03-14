import 'package:equatable/equatable.dart';

abstract class GetCoinListTotalValueEvent extends Equatable {}

class FetchGetCoinListTotalValueEvent extends GetCoinListTotalValueEvent {
  final List coinList;
  final coinBalancesMap;

  FetchGetCoinListTotalValueEvent({this.coinList, this.coinBalancesMap});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}