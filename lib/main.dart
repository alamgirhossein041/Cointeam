import 'dart:io';

import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_bloc.dart';
import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_state.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/data/repository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/data/repository/auth/get_all/ftx_get_balance.dart';
import 'package:coinsnap/data/repository/auth/sell_coin/binance_sell_coin.dart';
import 'package:coinsnap/data/repository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:coinsnap/data/repository/unauth/prices/binance_get_prices.dart';
import 'package:coinsnap/data/repository/unauth/prices/ftx_get_prices.dart';
import 'package:coinsnap/test/testjson/test_crypto_json.dart';
import 'package:coinsnap/ui/pages/builder/builder.dart';
import 'package:coinsnap/ui/pages/builder/test.dart';
import 'package:coinsnap/ui/pages/coin_view/coin_view.dart';
import 'package:coinsnap/ui/template/home_old/home_view.dart';
import 'package:coinsnap/ui/template/home/home_view_real.dart';
import 'package:coinsnap/ui/pages/portfolio.dart';
import 'package:coinsnap/ui/template/small/card/portfolio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/authentication.dart';
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
          create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl(), ftxGetPricesRepository: FtxGetPricesRepositoryImpl(), ftxGetBalanceRepository: FtxGetBalanceRepositoryImpl()),
        ),
        BlocProvider<GetPriceInfoBloc>(
          create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<SellPortfolioBloc>(
          create: (context) => SellPortfolioBloc(binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
        // BlocProvider<BlocC>(
        //   create: (BuildContext context) => BlocC(),
        // ),
      ],

      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          /// '/home': (context) => HomeViewReal(),
          // '/home': (context) => HomeViewReal(), /// TODO: Change this to Authentication() for production
          '/home': (context) => Authentication(),
          '/builder': (context) => PortfolioBuilderView(), /// TODO: Have {id} subroutes? If possible
          '/testview': (context) => TestView(),
          // '/homeviewreal': (context) => BlocProvider<GetPriceInfoBloc>(
          //   create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
          //   child: HomeViewReal(),
          // ),
          '/homeviewreal': (context) => HomeViewReal(),
          '/coinview': (context) => CoinView(),
          // '/portfolio': (context) => PriceContai
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
