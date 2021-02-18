import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BuyPortfolioState extends Equatable {}

class BuyPortfolioInitialState extends BuyPortfolioState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class BuyPortfolioLoadingState extends BuyPortfolioState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class BuyPortfolioLoadedState extends BuyPortfolioState {

  final double totalValue;

  BuyPortfolioLoadedState({@required this.totalValue});

  /// THIS IS THE MAIN ONE
  
  @override
  /// TODO: stuff
  List<Object> get props => null;
}

class BuyPortfolioErrorState extends BuyPortfolioState {

  final String errorMessage;

  BuyPortfolioErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}