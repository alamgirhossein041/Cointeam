import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_portfolio_data_bloc/get_portfolio_data_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_portfolio_data_bloc/get_portfolio_data_state.dart';
import 'package:meta/meta.dart';

class GetPortfolioDataBloc extends Bloc<GetPortfolioDataEvent, GetPortfolioDataState> {

  GetPortfolioDataBloc() : super(GetPortfolioDataInitialState());


  /// Binance can give us:
  /// List of user's coins WITH balance
  /// -- List<BinanceCoins>
  /// 
  /// List.forEach(v) => apiQueryToBinance(v)
  /// 
  /// Binance can give us:
  /// Individual coin prices to USD
  /// 
  /// Coinmarketcap can give us:
  /// Prices for up to 100 coins at a time
  /// 
  /// 
  /// First we get DB data
  /// Second we get Binance data (async)
  /// 
  /// Then we query all that to coinmarketcap
  /// (Y)



  // GetPortfolioDataRepositoryImpl cardCoinmarketcapCoinLatestRepository;

  @override
  Stream<GetPortfolioDataState> mapEventToState(GetPortfolioDataEvent event) async* {
    if (event is FetchGetPortfolioDataEvent) {
      yield GetPortfolioDataLoadingState();

      try {
        // var data = await cardCoinmarketcapCoinLatestRepository.getCoinMarketCapCoinLatest();
        yield GetPortfolioDataLoadedState();
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        log(e.toString());
        yield GetPortfolioDataErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }