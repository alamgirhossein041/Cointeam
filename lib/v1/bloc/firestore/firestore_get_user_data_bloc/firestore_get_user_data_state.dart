import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FirestoreGetUserDataState extends Equatable {}

class FirestoreGetUserDataInitialState extends FirestoreGetUserDataState {

  @override
  /// TODO: stuff
  List<Object> get props => [];
}

class FirestoreGetUserDataLoadingState extends FirestoreGetUserDataState {

  @override
  List<Object> get props => [];
}

class FirestoreGetUserDataLoadedState extends FirestoreGetUserDataState {

  final Map portfolioMap;

  FirestoreGetUserDataLoadedState({this.portfolioMap});

  @override
  /// TODO: implement props
  List<Object> get props => null;
}

class FirestoreGetUserDataErrorState extends FirestoreGetUserDataState {

  final String errorMessage;

  FirestoreGetUserDataErrorState({@required this.errorMessage});

  @override
  /// TODO: stuff
  List<Object> get props => null;
}