import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BuyPortfolioState extends Equatable {}

class BuyPortfolioInitialState extends BuyPortfolioState {

  @override
  List<Object> get props => [];
}

class BuyPortfolioLoadingState extends BuyPortfolioState {

  @override
  List<Object> get props => [];
}

class BuyPortfolioLoadedState extends BuyPortfolioState {

  final double totalValue;

  BuyPortfolioLoadedState({@required this.totalValue});
  
  @override
  List<Object> get props => null;
}

class BuyPortfolioErrorState extends BuyPortfolioState {

  final String errorMessage;

  BuyPortfolioErrorState({@required this.errorMessage});

  @override
  List<Object> get props => null;
}