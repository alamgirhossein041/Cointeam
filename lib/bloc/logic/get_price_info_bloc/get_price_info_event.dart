import 'package:equatable/equatable.dart';

abstract class GetPriceInfoEvent extends Equatable {}

class FetchGetPriceInfoEvent extends GetPriceInfoEvent {
  final String coinTicker;

  FetchGetPriceInfoEvent({this.coinTicker});
  @override
  /// TODO: stuff
  List<Object> get props => null;
}