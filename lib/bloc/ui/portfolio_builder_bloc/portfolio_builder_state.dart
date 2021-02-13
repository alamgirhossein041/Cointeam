import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PortfolioBuilderState extends Equatable {}

class PortfolioBuilderInitialState extends PortfolioBuilderState { /// when there's a brand new portfolio builder page

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class PortfolioBuilderLoadingState extends PortfolioBuilderState {

  // double totalValue;

  PortfolioBuilderLoadingState();

  /// THIS IS THE MAIN ONE
  
  @override
  /// TODO: stuff
  List<Object> get props => null;
}

class PortfolioBuilderLoadedState extends PortfolioBuilderState {

  // double totalValue;

  PortfolioBuilderLoadedState();

  /// THIS IS THE MAIN ONE
  
  @override
  /// TODO: stuff
  List<Object> get props => null;
}

class PortfolioBuilderErrorState extends PortfolioBuilderState {

  String errorMessage;

  PortfolioBuilderErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}