import 'package:bloc/bloc.dart';
import 'package:coinsnap/v1/bloc/auth/get_all/binance_get_all_bloc/binance_get_all_event.dart';
import 'package:coinsnap/v1/bloc/auth/get_all/binance_get_all_bloc/binance_get_all_state.dart';
import 'package:coinsnap/v1/data/model/auth/get_all/binance_get_all_model.dart';
import 'package:coinsnap/v1/data/repository/auth/get_all/binance_get_all.dart';
import 'package:meta/meta.dart';

class BinanceGetAllBloc extends Bloc<BinanceGetAllEvent, BinanceGetAllState> {
  
  BinanceGetAllBloc({@required this.repository}) : super(BinanceGetAllInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetAllRepositoryImpl repository;

  @override
  Stream<BinanceGetAllState> mapEventToState(BinanceGetAllEvent event) async* {
    if (event is FetchBinanceGetAllEvent) {
      yield BinanceGetAllLoadingState();
      try {
        List<BinanceGetAllModelv1> binanceGetAllModel = await repository.getBinanceGetAll();
        /// TODO: probably fix up LIST
        yield BinanceGetAllLoadedState(binanceGetAllModel: binanceGetAllModel);
      } catch (e) {
        yield BinanceGetAllErrorState(errorMessage : e.toString());
      }
    }
  }
}