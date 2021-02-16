import 'package:bloc/bloc.dart';
import 'package:coinsnap/bloc/auth/get_all/coinbase_get_account_bloc/coinbase_get_account_event.dart';
import 'package:coinsnap/bloc/auth/get_all/coinbase_get_account_bloc/coinbase_get_account_state.dart';
import 'package:coinsnap/data/model/auth/get_all/coinbase_get_account_model.dart';
import 'package:coinsnap/data/repository/auth/get_all/coinbase_get_account.dart';
import 'package:meta/meta.dart';

class CoinbaseGetAccountBloc extends Bloc<CoinbaseGetAccountEvent, CoinbaseGetAccountState> {
  
  CoinbaseGetAccountBloc({@required this.repository}) : super(CoinbaseGetAccountInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  CoinbaseGetAccountRepositoryImpl repository;

  @override
  Stream<CoinbaseGetAccountState> mapEventToState(CoinbaseGetAccountEvent event) async* {
    if (event is FetchCoinbaseGetAccountEvent) {
      yield CoinbaseGetAccountLoadingState();

      try {
        CoinbaseGetAccountModel coinbaseGetAccountModel = await repository.getCoinbaseGetAccount();
        /// TODO: probably fix up LIST
        yield CoinbaseGetAccountLoadedState(coinbaseGetAccountModel: coinbaseGetAccountModel);
      } catch (e) {
        yield CoinbaseGetAccountErrorState(errorMessage : e.toString());
      }
    }
  }
}