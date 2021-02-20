import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_event.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_state.dart';
import 'package:coinsnap/bloc/ui/portfolio_builder_bloc/portfolio_builder_event.dart';
import 'package:coinsnap/bloc/ui/portfolio_builder_bloc/portfolio_builder_state.dart';
import 'package:coinsnap/bloc/unauth/exchange/binance_exchange_info_bloc/binance_exchange_info_event.dart';
import 'package:coinsnap/bloc/unauth/exchange/binance_exchange_info_bloc/binance_exchange_info_state.dart';
import 'package:coinsnap/data/model/unauth/exchange/binance_exchange_info_model.dart';
import 'package:coinsnap/data/repository/firestore/firestore_get_user_data.dart';
import 'package:coinsnap/data/repository/unauth/exchange/binance_get_exchange_info.dart';
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