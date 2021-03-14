import 'package:coinsnap/v1/ui_root/pages/builder/test.dart';
import 'package:coinsnap/v1/ui_root/pages/coin_view/coin_view.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/top100/top100_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_price_info_bloc/get_price_info_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/global/global_coinmarketcap_stats_repo.dart';
// import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_buy_coin_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_chart_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_exchange_info_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_prices_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_sell_coin_repo.dart';
import 'package:coinsnap/v2/ui/authentication/authentication.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_add.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_edit.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_page/coin_page.dart';
import 'package:coinsnap/v2/ui/main/dashboard.dart';
import 'package:coinsnap/v2/ui/main/home_view.dart';
import 'package:coinsnap/v2/ui/welcome/first.dart';
import 'package:coinsnap/v2/ui/welcome/second.dart';
import 'package:coinsnap/working_files/dashboard_initial_noAPI.dart';
import 'package:coinsnap/working_files/practice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_bloc.dart';
// import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  /// ### Do we need to write to local storage? If so, see commented code below ### ///
  // final appDocumentDir = await getApplicationDocumentsDirectory();
  // final dir = Directory(appDocumentDir.path + "/dir");
  // await dir.create().then((value) {
  //   File file = File('${value.path}/example.txt');
  //   file.writeAsString('123)');
  // });
  /// ### Do we need to write to local storage? If so, see commented code above ### ///
  
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTotalValueBloc>(
        //   // create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl(), ftxGetPricesRepository: FtxGetPricesRepositoryImpl(), ftxGetBalanceRepository: FtxGetBalanceRepositoryImpl()),
          create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<GetPriceInfoBloc>(
          create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<SellPortfolioBloc>(
          create: (context) => SellPortfolioBloc(binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
        //  BlocProvider<BuyPortfolioBloc>(
        //   create: (context) => BuyPortfolioBloc(binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        // ),
        // BlocProvider<FirestoreGetUserDataBloc> (
        //   // create: (context) => FirestoreGetUserDataBloc(firestoreGetUserDataRepository: FirestoreGetUserDataRepositoryImpl())..add(FetchFirestoreGetUserDataEvent()),
        //   create: (context) => FirestoreGetUserDataBloc(firestoreGetUserDataRepository: FirestoreGetUserDataRepositoryImpl()),
        // ),
        BlocProvider<CardCoinmarketcapCoinLatestBloc> (
          create: (context) => CardCoinmarketcapCoinLatestBloc(cardCoinmarketcapCoinLatestRepository: CardCoinmarketcapCoinLatestRepositoryImpl()),
        ),
        BlocProvider<GlobalCoinmarketcapStatsBloc> (
          create: (context) => GlobalCoinmarketcapStatsBloc(globalCoinmarketcapStatsRepository: GlobalCoinmarketcapStatsRepositoryImpl()),
        ),
        BlocProvider<BinanceGetChartBloc> (
          create: (context) => BinanceGetChartBloc(binanceGetChartRepository: BinanceGetChartRepositoryImpl()),
        ),
        // BlocProvider<BlocC>(
        //   create: (BuildContext context) => BlocC(),
        // ),
        BlocProvider<ListTotalValueBloc> (
          create: (context) => ListTotalValueBloc(listTotalValueRepository: CardCoinmarketcapCoinListRepositoryImpl()),
        ),
        BlocProvider<Top100TotalValueBloc> (
          create: (context) => Top100TotalValueBloc(cardCoinmarketcapCoinLatestRepository: CardCoinmarketcapCoinLatestRepositoryImpl()),
        ),
      ],

      child: MaterialApp(
        // theme: ThemeData(
        //   brightness: Brightness.dark
        // ),
        // initialRoute: '/hometest',
        // initialRoute: '/dashboardnoapitest',
        // initialRoute: '/authentication',
        initialRoute: '/dashboard',
        // initialRoute: '/home',
        routes: {
          '/dashboard': (context) => Dashboard(),
          '/coinpage': (context) => CoinPage(),
          '/first': (context) => First(),
          '/second': (context) => Second(),
          // '/home': (context) => HomeViewReal(), /// TODO: Change this to Authentication() for production
          // '/home': (context) => TestView(),
          // '/home': (context) => Authentication(),

          /// ### Insert Build-A-Portfolio screen below ### ///
          // '/builder': (context) => PortfolioBuilderView(), /// TODO: Have {id} subroutes? If possible
          /// ### Insert Build-A-Portfolio screen above ### ///

          '/testviewV1': (context) => TestView(),
          // '/homeviewreal': (context) => BlocProvider<GetPriceInfoBloc>(
          //   create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
          //   child: HomeViewReal(),
          // ),
          // '/homeviewrealV1': (context) => HomeViewReal(),
          '/coinviewV1': (context) => CoinView(),
          '/authentication': (context) => Authentication(),
          // '/portfolio': (context) => PriceContai
          '/hometest': (context) => HomeView(),
          '/editcointest': (context) => EditCoin(),
          '/addcointest': (context) => AddCoin(),
          '/dashboardnoapitest': (context) => DashboardNoApiView(),
          '/dashboardwithcategory': (context) => DashboardWithCategory(),
        }
      ),
    );
  }
}
