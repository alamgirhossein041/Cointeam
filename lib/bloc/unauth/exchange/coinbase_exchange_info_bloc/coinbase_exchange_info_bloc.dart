import 'package:bloc/bloc.dart';
import 'package:coinsnap/bloc/unauth/exchange/coinbase_exchange_info_bloc/coinbase_exchange_info_event.dart';
import 'package:coinsnap/bloc/unauth/exchange/coinbase_exchange_info_bloc/coinbase_exchange_info_state.dart';
import 'package:coinsnap/data/model/unauth/exchange/coinbase_exchange_info_model.dart';
import 'package:coinsnap/data/repository/unauth/exchange/coinbase_get_exchange_info.dart';
import 'package:meta/meta.dart';

class CoinbaseExchangeInfoBloc extends Bloc<CoinbaseExchangeInfoEvent, CoinbaseExchangeInfoState> {
  
  CoinbaseExchangeInfoBloc({@required this.repository}) : super(CoinbaseExchangeInfoInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  CoinbaseExchangeInfoRepositoryImpl repository;

  @override
  Stream<CoinbaseExchangeInfoState> mapEventToState(CoinbaseExchangeInfoEvent event) async* {
    if (event is FetchCoinbaseExchangeInfoEvent) {
      yield CoinbaseExchangeInfoLoadingState();

      try {
        List<CoinbaseExchangeInfoModel> coinbaseExchangeInfoModel = await repository.getCoinbaseExchangeInfo();
        /// TODO: probably fix up LIST
        yield CoinbaseExchangeInfoLoadedState(coinbaseExchangeInfoModel: coinbaseExchangeInfoModel);
      } catch (e) {
        yield CoinbaseExchangeInfoErrorState(errorMessage : e.toString());
      }
    }
  }
}