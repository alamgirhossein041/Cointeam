import 'package:bloc/bloc.dart';
import 'package:coinsnap/v1/bloc/auth/get_all/ftx_get_balance_bloc/ftx_get_balance_event.dart';
import 'package:coinsnap/v1/bloc/auth/get_all/ftx_get_balance_bloc/ftx_get_balance_state.dart';
import 'package:coinsnap/v1/data/model/auth/get_all/ftx_get_balance_model.dart';
import 'package:coinsnap/v1/data/repository/auth/get_all/ftx_get_balance.dart';
import 'package:meta/meta.dart';

class FtxGetBalanceBloc extends Bloc<FtxGetBalanceEvent, FtxGetBalanceState> {
  
  FtxGetBalanceBloc({@required this.repository}) : super(FtxGetBalanceInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  FtxGetBalanceRepositoryImpl repository;

  @override
  Stream<FtxGetBalanceState> mapEventToState(FtxGetBalanceEvent event) async* {
    if (event is FetchFtxGetBalanceEvent) {
      yield FtxGetBalanceLoadingState();

      try {
        FtxGetBalanceModel ftxGetBalanceModel = await repository.getFtxGetBalance();
        /// TODO: probably fix up LIST
        yield FtxGetBalanceLoadedState(ftxGetBalanceModel: ftxGetBalanceModel);
      } catch (e) {
        yield FtxGetBalanceErrorState(errorMessage : e.toString());
      }
    }
  }
}