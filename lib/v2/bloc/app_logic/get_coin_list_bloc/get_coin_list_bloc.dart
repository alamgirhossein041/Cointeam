import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/model/coin_model/exchange/binance/binance_get_all_model.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class GetCoinListBloc extends Bloc<GetCoinListEvent, GetCoinListState> {

  GetCoinListBloc({this.binanceGetAllRepository}) : super(GetCoinListInitialState());

  BinanceGetAllRepositoryImpl binanceGetAllRepository;

  @override
  Stream<GetCoinListState> mapEventToState(GetCoinListEvent event) async* {
    if (event is FetchGetCoinListEvent) {
      yield GetCoinListLoadingState();

      try {

        final FlutterSecureStorage secureStorage = FlutterSecureStorage();
        final LocalStorage localStorage = LocalStorage("coinstreetapp");
        Map primeCoin;

        // String isBinanceTrading = await secureStorage.read(key: "trading");
        String isBinanceTrading = await secureStorage.read(key: "binance");
        var localStorageResponse = await localStorage.getItem("prime");
        if(localStorageResponse != null) {
          primeCoin = Map.from(json.decode(await localStorage.getItem("prime")));
        } else {
          primeCoin = {};
        }

        List coinList = [];
        List responses = await Future.wait([binanceGetAllRepository.getBinanceGetAll()]);
        primeCoin.forEach((k,v) {
          coinList.add(k);
        });
        if (isBinanceTrading != null) {
          for(BinanceGetAllModel coin in responses[0]) {
              coinList.add(coin.coin);
            if(primeCoin[coin.coin] != null) {
              primeCoin[coin.coin] += coin.free + coin.locked;
            } else {
              primeCoin[coin.coin] = coin.free + coin.locked;
            }
          }
        }
        coinList.add('BTC');
        coinList.add('ETH');
        coinList = coinList.toSet().toList();

        /// ### Can add a yield here ### ///        
        yield GetCoinListLoadedState(coinList: coinList, coinBalancesMap: primeCoin);
        /// ### We will continue getting all data ### ///
        
      } catch (e) {
        debugPrint("The error is in get_coin_list_bloc.dart");
        debugPrint(e.toString());
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