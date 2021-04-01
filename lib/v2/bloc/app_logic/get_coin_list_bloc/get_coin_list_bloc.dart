import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_add.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class GetCoinListBloc extends Bloc<GetCoinListEvent, GetCoinListState> {

  // bool btcCheck = false;
  // bool ethCheck = false;

  GetCoinListBloc({this.binanceGetAllRepository}) : super(GetCoinListInitialState());

  BinanceGetAllRepositoryImpl binanceGetAllRepository;

  



  @override
  Stream<GetCoinListState> mapEventToState(GetCoinListEvent event) async* {
    log("HEIWJOFJIDSF");
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
        final FlutterSecureStorage secureStorage = FlutterSecureStorage();
        final LocalStorage localStorage = LocalStorage("coinstreetapp");
        Map primeCoin;

        String isBinanceTrading = await secureStorage.read(key: "trading");
        var localStorageResponse = await localStorage.getItem("prime");
        if(localStorageResponse != null) {
          primeCoin = Map.from(json.decode(await localStorage.getItem("prime")));
          // log(primeCoin.toString());
        } else {
          // log("HEWJFOISJFOSDF");
          primeCoin = {};
        }
        List coinList = [];

        // List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll(), localStorage.getLocalStorage()]);
        
        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll()]);
        // log("Our responses is " + responses[0].toString());

        // Map coinBalancesMap = {};
        // log("primeCoin is " + primeCoin.toString());
        // log("hello1");
        // if(primeCoin == null) {
        //   primeCoin = {};
        // }
        // log("hello2");
        primeCoin.forEach((k,v) {
          log("Key is: " + k.toString());
          log("Value (unused) is: " + v.toString());
          // log(coinList
          coinList.add(k);
          // coinBalancesMap[k] = v;
        });
      
        // log("Hello World");
        // primeCoin.forEach((k,v) {
        //   coinList.add(k);
        //   log("Adding " + primeCoin[k].toString());
        // });
        // coinList = primeCoinList;


        
        /// TODO: Fix pseudocode
        // responses[0].forEach((v) => coinList.add(v.));
        // responses[1].forEach((v) => coinList.add(v./coinTicker/));

        // responses[0];

        /// First list: coinList
        /// Second List: 
        // log("hello3");

        if (isBinanceTrading != null) {
          for(BinanceGetAllModel coin in responses[0]) {
            // if(primeCoin == null) {
              log("coin.coin is: " + coin.coin);
              
              coinList.add(coin.coin);
              
              
            // }
            if(primeCoin[coin.coin] != null) {
              log("Primecoin not null");
              primeCoin[coin.coin] += coin.free + coin.locked;
            } else {
              log("Primecoin null");
              log("coin.free + coin.locked is: " + (coin.free + coin.locked).toString());
              primeCoin[coin.coin] = coin.free + coin.locked;
            }
          }
        }
        coinList.add('BTC');
        coinList.add('ETH');
        coinList = coinList.toSet().toList();
        // coinList.forEach((v) =>
          // log(v.toString()));
        
        log("PrimeCoin: " + primeCoin.toString());

        /// ### Can add a yield here ### ///        
        yield GetCoinListLoadedState(coinList: coinList, coinBalancesMap: primeCoin);
        /// ### We will continue getting all data ### ///
        
        // CardCoinmarketcapListModel coinListData = await coinmarketcapListQuoteRepository.getCoinMarketCapCoinList(coinList);
        
        // // var data = await getCoinListRepository.getCoinList();
        // yield GetCoinListLoadedState(coinListData: coinListData);
        // List<FirestoreGetUserDataModel> FirestoreGetUserDataModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield FirestoreGetUserDataLoadedState(FirestoreGetUserDataModel: FirestoreGetUserDataModel);
      } catch (e) {
        log("The error is in get_coin_list_bloc.dart");
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