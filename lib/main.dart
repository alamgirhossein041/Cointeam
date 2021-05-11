import 'package:coinsnap/features/data/binance_price/repos/binance_exchange_info.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/binance_price/repos/binance_get_prices.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/home/pages/home.dart';
import 'package:coinsnap/features/portfolio/pages/portfolio.dart';
import 'package:coinsnap/features/portfolio/repos/coinmarketcap_coin_data.dart';
import 'package:coinsnap/features/snapshots/pages/snapshot_list.dart';
import 'package:coinsnap/features/trading/buy/repos/binance_buy_coin.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/sell/pages/sell_portfolio_1.dart';
import 'package:coinsnap/features/trading/sell/pages/sell_portfolio_2.dart';
import 'package:coinsnap/features/trading/sell/pages/sell_portfolio_3.dart';
import 'package:coinsnap/features/trading/sell/pages/transaction_log.dart';
import 'package:coinsnap/features/trading/sell/repos/binance_sell_coin.dart';
import 'package:coinsnap/modules/app_load/bloc/coingecko_list_250_bloc/coingecko_list_250_bloc.dart';
import 'package:coinsnap/modules/app_load/initial_page.dart';
import 'package:coinsnap/modules/app_load/repos/coingecko_list_250.dart';
import 'package:coinsnap/modules/categories/top100/coinmarketcap_top100_data_bloc/top100_total_value_bloc.dart';
import 'package:coinsnap/modules/categories/top100/repos/coinmarketcap_top100.dart';
import 'package:coinsnap/modules/chart/bloc/coin/binance_get_individual_chart_bloc.dart';
import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_bloc.dart';
import 'package:coinsnap/modules/chart/repos/binance_chart.dart';
import 'package:coinsnap/modules/coin/pages/coin_add.dart';
import 'package:coinsnap/modules/coin/pages/coin_view.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/bloc/gecko_global_stats_bloc.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/repos/gecko_global_stats.dart';
import 'package:coinsnap/modules/data/global_stats/coinmarketcap/bloc/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/modules/data/global_stats/coinmarketcap/repos/global_coinmarketcap_stats_repo.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_bloc.dart';
import 'package:coinsnap/modules/onboarding/pages/welcome_screen_1.dart';
import 'package:coinsnap/modules/portfolio/repos/exchanges/ftx_get_balance.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';
import 'package:coinsnap/modules/widgets/api_link/modal_failure.dart';
import 'package:coinsnap/modules/widgets/api_link/modal_success.dart';
import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_2_select.dart';
import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_3_ftx.dart';
import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_3_qr.dart';
import 'package:coinsnap/modules/onboarding/pages/welcome_screen_3.dart';
import 'package:coinsnap/modules/home/pages/home.dart';
import 'package:coinsnap/modules/portfolio/bloc/coinmarketcap_list_data_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/modules/portfolio/pages/portfolio_dashboard.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/bloc/buy_portfolio_bloc/buy_portfolio_bloc.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/pages/buy_portfolio_1.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/pages/buy_portfolio_2.dart';
import 'package:coinsnap/modules/trading/portfolio/buy/pages/buy_portfolio_3.dart';
import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_3_text.dart';
import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_4_check.dart';
import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_4_check_ftx.dart';
import 'package:coinsnap/modules/widgets/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

/// ### Dev only ### ///
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = false;
  // debugPaintLayerBordersEnabled = false;
  // debugPaintPointersEnabled = false;
  // debugRepaintRainbowEnabled = false;
  // debugRepaintTextRainbowEnabled = false;
  // debugCheckElevationsEnabled = false;
  // debugDisableClipLayers = false;
  // debugDisablePhysicalShapeLayers = false;
  // debugDisableOpacityLayers = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(MyApp());
  /// ### Dev Phoenix (resets app state) ### ///
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        // BlocProvider<GetTotalValueBloc>(
        //   create: (context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        // ),
        BlocProvider<StartupBloc>(
          // create: (context) => StartupBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), coinmarketcapListQuoteRepository: CardCoinmarketcapCoinListRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl(), ftxGetBalanceRepository: FtxGetBalanceRepositoryImpl()),
          create: (context) => StartupBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), coinmarketcapListQuoteRepository: CardCoinmarketcapCoinListRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        // BlocProvider<GetPriceInfoBloc>(
        //   create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        // ),
        BlocProvider<SellPortfolioBloc>(
          create: (context) => SellPortfolioBloc(binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(), binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
        // BlocProvider<CardCoinmarketcapCoinLatestBloc> (
        //   create: (context) => CardCoinmarketcapCoinLatestBloc(cardCoinmarketcapCoinLatestRepository: CardCoinmarketcapCoinLatestRepositoryImpl()),
        // ),
        BlocProvider<GlobalCoinmarketcapStatsBloc> (
          create: (context) => GlobalCoinmarketcapStatsBloc(globalCoinmarketcapStatsRepository: GlobalCoinmarketcapStatsRepositoryImpl()),
        ),
        BlocProvider<GeckoGlobalStatsBloc> (
          create: (context) => GeckoGlobalStatsBloc(geckoGlobalStatsRepo: GeckoGlobalStatsRepoImpl()),
        ),
        BlocProvider<BinanceGetChartBloc> (
          create: (context) => BinanceGetChartBloc(binanceGetChartRepository: BinanceGetChartRepositoryImpl()),
        ),
        BlocProvider<BinanceGetIndividualChartBloc> (
          create: (context) => BinanceGetIndividualChartBloc(binanceGetChartRepository: BinanceGetChartRepositoryImpl()),
        ),
        // BlocProvider<ListTotalValueBloc> (
        //   create: (context) => ListTotalValueBloc(listTotalValueRepository: CardCoinmarketcapCoinListRepositoryImpl()),
        // ),
        BlocProvider<Top100TotalValueBloc> (
          create: (context) => Top100TotalValueBloc(cardCoinmarketcapCoinLatestRepository: CardCoinmarketcapCoinLatestRepositoryImpl()),
        ),
        // BlocProvider<GetCoinListBloc> (
        //   create: (context) => GetCoinListBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl()),
        // ),
        // BlocProvider<GetCoinListTotalValueBloc> (
        //   create: (context) => GetCoinListTotalValueBloc(coinmarketcapListQuoteRepository: CardCoinmarketcapCoinListRepositoryImpl()),
        // ),
        BlocProvider<CoingeckoList250Bloc> (
          create: (context) => CoingeckoList250Bloc(coingeckoList250Repository: CoingeckoList250RepositoryImpl()),
        ),
        BlocProvider<BuyPortfolioBloc> (
          create: (context) => BuyPortfolioBloc(binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(), binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        // navigatorObservers: <NavigatorObserver>[
          // observer
        // ],
        theme: ThemeData(
          // Default brightness
          // brightness: Brightness.dark
          // Default colours
          // accentColor: Color(0xff8270FF),
          // accentColor: Color(0xFF2197F2),
          // accentColor: Colors.orange[300],
          accentColor: Color(0xFFFF25CB9D),
        
          // Default font family
          fontFamily: 'Roboto',

          highlightColor: Colors.deepPurpleAccent.withAlpha(10),

          // Default textTheme
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, color: Colors.white),
            headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.normal, color: Colors.white),
            headline3: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
            bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white, letterSpacing: 0.25, height: 1.8),
            bodyText2: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white, letterSpacing: 0.25),

          ),

          primaryTextTheme: TextTheme(
            subtitle1: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: primaryLight, letterSpacing: 0.5),
          ),

          // Appbar theme
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            actionsIconTheme: IconThemeData(
              size: 24,
              color: Colors.white,
            ),
          ),

          // Scaffold background colour
          scaffoldBackgroundColor: Colors.transparent,

          // Popup menu theme
          popupMenuTheme: PopupMenuThemeData(
            color: Color(0xFF101010),
          ),
          
          // Default button theme
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.deepPurple[200])
          ),

          // Divider theme
          dividerTheme: DividerThemeData(
            space: 30,
            color: Colors.white12,
            indent: 10,
            endIndent: 10,
          ),
        ),
        initialRoute: '/home',
        routes: {
          '/initialpage': (context) => InitialPage(),
          '/buyportfolio': (context) => BuyPortfolioScreen(),
          '/buyportfolio2': (context) => BuyPortfolioPage2(),
          '/buyportfolio3': (context) => BuyPortfolioPage3 (),
          '/sellportfolio3': (context) => SellPortfolioPage3(),
          '/sellportfolio2': (context) => SellPortfolioPage2(),
          '/sellportfolio': (context) => SellPortfolioScreen(),
          // '/buildportfolio' : (context) => PortfolioBuilderSelect(),
          '/settings': (context) => Settings(),
          '/homeold': (context) => DashboardNoApiView(),
          '/home': (context) => Home(),
          '/viewportfolio': (context) => Dashboard(),
          '/viewcoin': (context) => CoinPage(),
          '/first': (context) => First(),
          '/second': (context) => Second(),
          // '/third': (context) => Third(),
          // '/authentication': (context) => Authentication(),
          // '/editcointest': (context) => EditCoin(),
          '/addcoin': (context) => AddCoin(),
          '/linkapiselect': (context) => LinkAPISelect(),
          '/linkapitext': (context) => LinkAPIText(),
          '/linkapiftx': (context) => LinkAPIFtx(),
          '/checkapi': (context) => CheckBinanceApi(),
          '/checkftxapi': (context) => CheckFtxApi(),
          '/modalsuccess': (context) => ModalSuccess(),
          '/modalfailure': (context) => ModalFailure(),
          '/portfolio': (context) => Portfolio(),
          '/selllog': (context) => SellLog(),
          '/snapshots': (context) => SnapshotList(),
          // '/dashboardwithcategory': (context) => DashboardWithCategory(),
        }
      ),
    );
  }
}
