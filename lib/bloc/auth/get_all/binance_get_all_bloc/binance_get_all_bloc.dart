import 'package:bloc/bloc.dart';
import 'package:coinsnap/data/model/auth/get_all/binance_get_all_model.dart';
import 'package:coinsnap/data/respository/auth/get_all/binance_get_all.dart';
import 'package:meta/meta.dart';
import 'package:coinsnap/bloc/auth/get_all/binance_get_all_bloc/binance_get_all_event.dart';
import 'package:coinsnap/bloc/auth/get_all/binance_get_all_bloc/binance_get_all_state.dart';

class BinanceGetAllBloc extends Bloc<BinanceGetAllEvent, BinanceGetAllState> {
  
  BinanceGetAllBloc({@required this.repository}) : super(BinanceGetAllInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceGetAllRepositoryImpl repository;

  @override
  Stream<BinanceGetAllState> mapEventToState(BinanceGetAllEvent event) async* {
    if (event is FetchBinanceGetAllEvent) {
      yield BinanceGetAllLoadingState();
      try {
        List<BinanceGetAllModel> binanceGetAllModel = await repository.getBinanceGetAll();
        /// TODO: probably fix up LIST
        yield BinanceGetAllLoadedState(binanceGetAllModel: binanceGetAllModel);
      } catch (e) {
        yield BinanceGetAllErrorState(errorMessage : e.toString());
      }
    }
  }
}