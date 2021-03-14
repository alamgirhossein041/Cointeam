import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';

class GetCoinListBloc extends Bloc<GetCoinListEvent, GetCoinListState> {

  GetCoinListBloc({this.binanceGetAllRepository}) : super(GetCoinListInitialState());

  BinanceGetAllRepositoryImpl binanceGetAllRepository;

  



  @override
  Stream<GetCoinListState> mapEventToState(GetCoinListEvent event) async* {
    if (event is FetchGetCoinListEvent) {
      yield GetCoinListLoadingState();

      try {


        /// What do we actually need to do?? ///
        /// 
        /// We need to call the localCache (aka dummy data) - but it's a repo
        /// 
        /// We need to call the binance portfolio
        /// 
        /// We need to GOGOGO
        
        // List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), localStorage.getLocalStorage()]);
        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll()]);

        Map coinBalancesMap = {};

        List coinList = [];

        /// TODO: Fix pseudocode
        // responses[0].forEach((v) => coinList.add(v.));
        // responses[1].forEach((v) => coinList.add(v./coinTicker/));

        // responses[0];
        for(BinanceGetAllModel coin in responses[0]) {
          coinList.add(coin.coin);
          coinBalancesMap[coin.coin] = coin.free + coin.locked;
        }

        /// ### Can add a yield here ### ///        
        yield GetCoinListLoadedState(coinList: coinList, coinBalancesMap: coinBalancesMap);
        /// ### We will continue getting all data ### ///
        
        // CardCoinmarketcapListModel coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);
        
        // // var data = await getCoinListRepository.getCoinList();
        // yield GetCoinListLoadedState(coinListData: coinListData);
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        log(e.toString());
        yield GetCoinListErrorState(errorMessage : e.toString());
      }
    }
  }
}

class CoinListBalances {
  String symbol;
  double totalBalance;

  CoinListBalances({this.symbol, this.totalBalance});

  CoinListBalances.constructFromBinance(data) {
    symbol = data.coin;
    totalBalance = data.free + data.locked;
  }
}

// class CoinList {
//   List<String> coinList = [];
//   double totalBalance = 0.0;
// }