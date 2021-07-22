import 'package:coinsnap/features/market/bloc/coingecko_list_top_100_event.dart';
import 'package:coinsnap/features/market/bloc/coingecko_list_top_100_state.dart';
import 'package:coinsnap/features/market/models/coingecko_list_top_100_model.dart';
import 'package:coinsnap/features/market/repos/coingecko_list_top_100_repo.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // FirestoreGetUserDataRepositoryImpl repository;


class CoingeckoListTop100Bloc extends Bloc<CoingeckoListTop100Event, CoingeckoListTop100State> {

  CoingeckoListTop100Bloc({@required this.coingeckoListTop100Repository}) : super(CoingeckoListTop100InitialState());

  CoingeckoListTop100RepositoryImpl coingeckoListTop100Repository;

  @override
  Stream<CoingeckoListTop100State> mapEventToState(CoingeckoListTop100Event event) async* {
    if (event is FetchCoingeckoListTop100Event) {
      yield CoingeckoListTop100LoadingState();

      try {
        /// ### data is a list of CoingeckoList250Model ### ///
        
        List<CoingeckoListTop100Model> data = await coingeckoListTop100Repository.getCoinMarketCapCoinLatest('1');

        // List<CoingeckoListTop100Model> firstTen = data.take(10);
        String coinTickerMarqueeText = '';
        List<String> stablecoins = ['USDT', 'USDC', 'BUSD'];        

        /// List<Stuff> = [BTC, ETH, XRP, ADA, USDT, USDC, BUSD, DOGE]
        for(int i = 0; i < 10; i++) {
          bool stablecoinCheck = true;
          // firstTen.forEach((v) => {
          while(stablecoinCheck) {
            if(stablecoins.contains(data[i].symbol)) {
              stablecoins.remove(data[i].symbol);
              data.removeAt(i);
            } else {
              stablecoinCheck = false;
            }
          }
          // coinTickerMarqueeText += i.toString() + ". " + data[i].symbol;
          coinTickerMarqueeText += data[i].symbol;
          // coinTickerMarqueeText += ": \$";
          coinTickerMarqueeText += " \$";
          coinTickerMarqueeText += data[i].currentPrice.toStringAsFixed(2);
          coinTickerMarqueeText += "    ";
        }
        yield CoingeckoListTop100LoadedState(coingeckoModelList: data, coinTickerMarqueeText: coinTickerMarqueeText);
      } catch (e) {
        debugPrint(e.toString());
        yield CoingeckoListTop100ErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }