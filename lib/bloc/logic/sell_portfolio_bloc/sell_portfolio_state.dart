import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SellPortfolioState extends Equatable {}

class SellPortfolioInitialState extends SellPortfolioState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class SellPortfolioLoadingState extends SellPortfolioState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class SellPortfolioLoadedState extends SellPortfolioState {
  /// THIS IS THE MAIN ONE
  
  @override
  /// TODO: stuff
  List<Object> get props => null;
}

class SellPortfolioErrorState extends SellPortfolioState {

  @override
  /// TODO: stuff
  List<Object> get props => null;
}