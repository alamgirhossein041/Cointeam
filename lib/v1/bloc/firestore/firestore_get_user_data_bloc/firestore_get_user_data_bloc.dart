import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v1/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_event.dart';
import 'package:coinsnap/v1/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_state.dart';
import 'package:coinsnap/v1/data/repository/firestore/firestore_get_user_data.dart';
import 'package:meta/meta.dart';

// class FirestoreGetUserDataBloc extends Bloc<FirestoreGetUserDataEvent, FirestoreGetUserDataState> {
  
  // FirestoreGetUserDataBloc({@required this.repository}) : super(FirestoreGetUserDataInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class FirestoreGetUserDataBloc extends Bloc<FirestoreGetUserDataEvent, FirestoreGetUserDataState> {

  FirestoreGetUserDataBloc({@required this.firestoreGetUserDataRepository}) : super(FirestoreGetUserDataInitialState());

  FirestoreGetUserDataRepositoryImpl firestoreGetUserDataRepository;

  @override
  Stream<FirestoreGetUserDataState> mapEventToState(FirestoreGetUserDataEvent event) async* {
    if (event is FetchFirestoreGetUserDataEvent) {
      yield FirestoreGetUserDataLoadingState();

      try {

        var data = await firestoreGetUserDataRepository.firestoreGetUserData();
        log("Hello + " + data.toString());
        yield FirestoreGetUserDataLoadedState(portfolioMap: data);
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        yield FirestoreGetUserDataErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }