import 'package:equatable/equatable.dart';

abstract class StartupEvent extends Equatable {}

class FetchStartupEvent extends StartupEvent {

  FetchStartupEvent();
  @override
  /// TODO: stuff
  List<Object> get props => null;
}