import 'package:bloc/bloc.dart';
import 'package:coinsnap/v1/bloc/unauth/exchange/ftx_exchange_info_bloc/ftx_exchange_info_event.dart';
import 'package:coinsnap/v1/bloc/unauth/exchange/ftx_exchange_info_bloc/ftx_exchange_info_state.dart';
import 'package:coinsnap/v1/data/model/unauth/exchange/ftx_exchange_info_model.dart';
import 'package:coinsnap/v1/data/repository/unauth/exchange/ftx_get_exchange_info.dart';
import 'package:meta/meta.dart';

class FtxExchangeInfoBloc extends Bloc<FtxExchangeInfoEvent, FtxExchangeInfoState> {
  
  FtxExchangeInfoBloc({@required this.repository}) : super(FtxExchangeInfoInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  FtxExchangeInfoRepositoryImpl repository;

  @override
  Stream<FtxExchangeInfoState> mapEventToState(FtxExchangeInfoEvent event) async* {
    if (event is FetchFtxExchangeInfoEvent) {
      yield FtxExchangeInfoLoadingState();

      try {
        List<FtxExchangeInfoModel> ftxExchangeInfoModel = await repository.getFtxExchangeInfo();
        /// TODO: probably fix up LIST
        yield FtxExchangeInfoLoadedState(ftxExchangeInfoModel: ftxExchangeInfoModel);
      } catch (e) {
        yield FtxExchangeInfoErrorState(errorMessage : e.toString());
      }
    }
  }
}