import 'dart:io';

import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_bloc.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_event.dart';
import 'package:coinsnap/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_bloc.dart';
import 'package:coinsnap/bloc/logic/buy_portfolio_bloc_TEST_DELETE/buy_portfolio_bloc.dart';
import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_bloc.dart';
import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_state.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/data/repository/auth/buy_coin/binance_buy_coin.dart';
import 'package:coinsnap/data/repository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/data/repository/auth/get_all/ftx_get_balance.dart';
import 'package:coinsnap/data/repository/auth/sell_coin/binance_sell_coin.dart';
import 'package:coinsnap/data/repository/firestore/firestore_get_user_data.dart';
import 'package:coinsnap/data/repository/internal/coin_data/card/coinmarketcap_coin_latest.dart';
import 'package:coinsnap/data/repository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:coinsnap/data/repository/unauth/prices/binance_get_prices.dart';
import 'package:coinsnap/data/repository/unauth/prices/ftx_get_prices.dart';
import 'package:coinsnap/test/testjson/test_crypto_json.dart';
import 'package:coinsnap/ui_root/pages/builder/builder.dart';
import 'package:coinsnap/ui_root/pages/builder/test.dart';
import 'package:coinsnap/ui_root/pages/coin_view/coin_view.dart';
import 'package:coinsnap/ui_root/template/home/home_view_real.dart';
import 'package:coinsnap/ui_root/pages/portfolio.dart';
import 'package:coinsnap/ui_root/template/small/card/portfolio_list_tile.dart';
import 'package:coinsnap/ui_root/v2/authentication/authentication.dart';
import 'package:coinsnap/ui_root/v2/main/home_view.dart';
import 'package:coinsnap/ui_root/v2/welcome/first.dart';
import 'package:coinsnap/ui_root/v2/welcome/second.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui_root/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final dir = Directory(appDocumentDir.path + "/dir");
  await dir.create().then((value) {
    File file = File('${value.path}/example.txt');
    file.writeAsString('123)');
  });
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTotalValueBloc>(
          // create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl(), ftxGetPricesRepository: FtxGetPricesRepositoryImpl(), ftxGetBalanceRepository: FtxGetBalanceRepositoryImpl()),
          create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<GetPriceInfoBloc>(
          create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<SellPortfolioBloc>(
          create: (context) => SellPortfolioBloc(binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
         BlocProvider<BuyPortfolioBloc>(
          create: (context) => BuyPortfolioBloc(binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
        BlocProvider<FirestoreGetUserDataBloc> (
          // create: (context) => FirestoreGetUserDataBloc(firestoreGetUserDataRepository: FirestoreGetUserDataRepositoryImpl())..add(FetchFirestoreGetUserDataEvent()),
          create: (context) => FirestoreGetUserDataBloc(firestoreGetUserDataRepository: FirestoreGetUserDataRepositoryImpl()),
        ),
        BlocProvider<CardCryptoDataBloc> (
          create: (context) => CardCryptoDataBloc(cardCryptoDataRepository: CoinMarketCapCoinLatestRepositoryImpl()),
        ),
        // BlocProvider<BlocC>(
        //   create: (BuildContext context) => BlocC(),
        // ),
      ],

      child: MaterialApp(
        // theme: ThemeData(
        //   brightness: Brightness.dark
        // ),
        // initialRoute: '/hometest',
        initialRoute: '/hometest',
        routes: {
          '/home': (context) => First(),
          '/second': (context) => Second(),
          // '/home': (context) => HomeViewReal(), /// TODO: Change this to Authentication() for production
          // '/home': (context) => TestView(),
          // '/home': (context) => Authentication(),
          '/builder': (context) => PortfolioBuilderView(), /// TODO: Have {id} subroutes? If possible
          '/testview': (context) => TestView(),
          // '/homeviewreal': (context) => BlocProvider<GetPriceInfoBloc>(
          //   create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
          //   child: HomeViewReal(),
          // ),
          '/homeviewreal': (context) => HomeViewReal(),
          '/coinview': (context) => CoinView(),
          '/authentication': (context) => Authentication(),
          // '/portfolio': (context) => PriceContai
          '/hometest': (context) => HomeView(),
        }
      ),
    );
      // create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
      // child: MaterialApp(
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //   ),
      //   initialRoute: '/home',
      //   routes: {
      //     /// '/home': (context) => HomeViewReal(),
      //     '/home': (context) => Authentication(), /// TODO: Change this to Authentication() for production
      //     '/builder': (context) => PortfolioBuilderView(), /// TODO: Have {id} subroutes? If possible
      //     '/testview': (context) => TestView(),
      //     '/homeviewreal': (context) => BlocProvider<GetPriceInfoBloc>(
      //       create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
      //       child: HomeViewReal(),
      //     ),
      //     '/coinview': (context) => CoinView(),
      //     // '/portfolio': (context) => PriceContai
      //   }
      // ),
    // );
  }
}
