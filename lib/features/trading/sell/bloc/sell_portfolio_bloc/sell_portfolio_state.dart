import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SellPortfolioState extends Equatable {}

class SellPortfolioInitialState extends SellPortfolioState {

  @override
  List<Object> get props => [];
}

class SellPortfolioLoadingState extends SellPortfolioState {

  @override
  List<Object> get props => [];
}

class SellPortfolioLoadedState extends SellPortfolioState {

  final double totalValue;
  final Map<String, dynamic> coinDataStructure;

  SellPortfolioLoadedState({@required this.totalValue, this.coinDataStructure});
  
  @override
  List<Object> get props => null;
}

class SellPortfolioErrorState extends SellPortfolioState {

  final String errorMessage;

  SellPortfolioErrorState({@required this.errorMessage});

  @override
  List<Object> get props => null;
}