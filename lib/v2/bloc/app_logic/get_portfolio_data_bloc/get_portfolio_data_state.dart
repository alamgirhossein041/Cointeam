import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GetPortfolioDataState extends Equatable {}

class GetPortfolioDataInitialState extends GetPortfolioDataState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class GetPortfolioDataLoadingState extends GetPortfolioDataState {

  @override
  List<Object> get props => [];
}

class GetPortfolioDataLoadedState extends GetPortfolioDataState {

  GetPortfolioDataLoadedState();

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class GetPortfolioDataErrorState extends GetPortfolioDataState {

  final String errorMessage;

  GetPortfolioDataErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}