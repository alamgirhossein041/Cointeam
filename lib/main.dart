import 'package:coinsnap/features/data/binance_price/binance_price.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/home/pages/home.dart';
import 'package:coinsnap/features/data/coinmarketcap/coinmarketcap.dart';
import 'package:coinsnap/features/onboarding/pages/welcome_screen_1.dart';
import 'package:coinsnap/features/snapshots/snapshots.dart';
import 'package:coinsnap/features/trading/trading.dart';
// import 'package:coinsnap/modules/widgets/api_link/modal_failure.dart';
// import 'package:coinsnap/modules/widgets/api_link/modal_success.dart';
// import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_2_select.dart';
// import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_3_ftx.dart';
// import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_3_qr.dart';
// import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_3_text.dart';
// import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_4_check.dart';
// import 'package:coinsnap/modules/widgets/api_link/pages/welcome_screen_4_check_ftx.dart';
// import 'package:coinsnap/modules/widgets/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:coinsnap/features/utils/colors_helper.dart';

/// ### Dev only ### ///
// import 'package:flutter_phoenix/flutter_phoenix.dart';

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
  // await Firebase.initializeApp();
  // runApp(MyApp());
  /// ### Dev Phoenix (resets app state) ### ///
  runApp(
    // Phoenix(
      // child: MyApp(),
      MyApp(),
    // ),
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
        // BlocProvider<ListTotalValueBloc> (
        //   create: (context) => ListTotalValueBloc(listTotalValueRepository: CardCoinmarketcapCoinListRepositoryImpl()),
        // ),
        // BlocProvider<GetCoinListBloc> (
        //   create: (context) => GetCoinListBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl()),
        // ),
        // BlocProvider<GetCoinListTotalValueBloc> (
        //   create: (context) => GetCoinListTotalValueBloc(coinmarketcapListQuoteRepository: CardCoinmarketcapCoinListRepositoryImpl()),
        // ),
        // BlocProvider<CoingeckoList250Bloc> (
        //   create: (context) => CoingeckoList250Bloc(coingeckoList250Repository: CoingeckoList250RepositoryImpl()),
        // ),
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
          // accentColor: Color(0xFFFF25CB9D),
        
          // Default font family
          fontFamily: 'Bahnschrift',

          // Default textTheme
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 34, fontWeight: FontWeight.w300, color: primaryDark, letterSpacing: 0.25, height: 1.8),
            bodyText1: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: primaryDark, letterSpacing: 0.25, height: 1.8),
            bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: primaryDark, letterSpacing: 0.25, height: 1.8),
            subtitle1: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primaryDark.withOpacity(0.5), letterSpacing: 0.25, height: 1.8),

          ),

          // primaryTextTheme: TextTheme(
            // subtitle1: TextStyle(fontFamily: 'Forestion', fontSize: 12, fontWeight: FontWeight.w800, color: primaryLight, letterSpacing: 0.5),
          // ),

          // Appbar theme
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            actionsIconTheme: IconThemeData(
              size: 24,
              color: Colors.white,
            ),
          ),

        ),
        initialRoute: '/home',
        routes: {
          '/buyportfolio': (context) => BuyPortfolioScreen(),
          '/buyportfolio2': (context) => BuyPortfolioPage2(),
          '/buyportfolio3': (context) => BuyPortfolioPage3 (),
          '/sellportfolio3': (context) => SellPortfolioPage3(),
          '/sellportfolio2': (context) => SellPortfolioPage2(),
          '/sellportfolio': (context) => SellPortfolioScreen(),
          // '/buildportfolio' : (context) => PortfolioBuilderSelect(),
          '/home': (context) => Home(),
          '/first': (context) => First(),
          // '/second': (context) => Second(),
          // '/third': (context) => Third(),
          // '/authentication': (context) => Authentication(),
          // '/editcointest': (context) => EditCoin(),
          // '/linkapiselect': (context) => LinkAPISelect(),
          // '/linkapitext': (context) => LinkAPIText(),
          // '/linkapiftx': (context) => LinkAPIFtx(),
          // '/checkapi': (context) => CheckBinanceApi(),
          // '/checkftxapi': (context) => CheckFtxApi(),
          // '/modalsuccess': (context) => ModalSuccess(),
          // '/modalfailure': (context) => ModalFailure(),
          '/selllog': (context) => SellLog(),
          '/snapshots': (context) => SnapshotList(),
          '/snapshotlog': (context) => SnapshotLog(),
          // '/dashboardwithcategory': (context) => DashboardWithCategory(),
        }
      ),
    );
  }
}
