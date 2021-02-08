import 'package:equatable/equatable.dart';

abstract class GetPriceInfoEvent extends Equatable {}

class FetchGetPriceInfoEvent extends GetPriceInfoEvent {
  final String ticker;

  FetchGetPriceInfoEvent(this.ticker);
  @override
  /// TODO: stuff
  List<Object> get props => null;
}