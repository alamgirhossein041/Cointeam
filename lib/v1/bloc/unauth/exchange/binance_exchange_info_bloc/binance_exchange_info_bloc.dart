import 'package:bloc/bloc.dart';
import 'package:coinsnap/v1/bloc/unauth/exchange/binance_exchange_info_bloc/binance_exchange_info_event.dart';
import 'package:coinsnap/v1/bloc/unauth/exchange/binance_exchange_info_bloc/binance_exchange_info_state.dart';
import 'package:coinsnap/v1/data/model/unauth/exchange/binance_exchange_info_model.dart';
import 'package:coinsnap/v1/data/repository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:meta/meta.dart';

class BinanceExchangeInfoBloc extends Bloc<BinanceExchangeInfoEvent, BinanceExchangeInfoState> {
  
  BinanceExchangeInfoBloc({@required this.repository}) : super(BinanceExchangeInfoInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceExchangeInfoRepositoryImpl repository;

  @override
  Stream<BinanceExchangeInfoState> mapEventToState(BinanceExchangeInfoEvent event) async* {
    if (event is FetchBinanceExchangeInfoEvent) {
      yield BinanceExchangeInfoLoadingState();

      try {
        List<BinanceExchangeInfoModel> binanceExchangeInfoModel = await repository.getBinanceExchangeInfo();
        /// TODO: probably fix up LIST
        yield BinanceExchangeInfoLoadedState(binanceExchangeInfoModel: binanceExchangeInfoModel);
      } catch (e) {
        yield BinanceExchangeInfoErrorState(errorMessage : e.toString());
      }
    }
  }
}