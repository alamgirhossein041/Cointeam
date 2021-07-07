import 'package:coinsnap/features/data/binance_price/binance_price.dart';
import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/home/pages/home.dart';
import 'package:coinsnap/features/data/coinmarketcap/coinmarketcap.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:coinsnap/features/my_coins/pages/my_coins.dart';
import 'package:coinsnap/features/onboarding/pages/welcome_screen_1.dart';
import 'package:coinsnap/features/snapshots/snapshots.dart';
import 'package:coinsnap/features/trading/buy/pages/buy_portfolio_0.dart';
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
        BlocProvider<StartupBloc>(
          create: (context) => StartupBloc(
            binanceGetAllRepository: BinanceGetAllRepositoryImpl(),
            coinmarketcapListQuoteRepository:
                CardCoinmarketcapCoinListRepositoryImpl(),
            binanceGetPricesRepository: BinanceGetPricesRepositoryImpl(),
          ),
        ),
        BlocProvider<SellPortfolioBloc>(
          create: (context) => SellPortfolioBloc(
            binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(),
            binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(),
            binanceGetAllRepository: BinanceGetAllRepositoryImpl(),
            binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl(),
          ),
        ),
        BlocProvider<BuyPortfolioBloc>(
          create: (context) => BuyPortfolioBloc(
            binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(),
            binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(),
            binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl(),
          ),
        ),
        BlocProvider<GeckoGlobalStatsBloc>(
          create: (context) => GeckoGlobalStatsBloc(
            geckoGlobalStatsRepo: GeckoGlobalStatsRepoImpl(),
          ),
        ),
        BlocProvider<CoingeckoListTop100Bloc>(
          create: (context) => CoingeckoListTop100Bloc(
            coingeckoListTop100Repository: CoingeckoListTop100RepositoryImpl(),
          ),
        ),
        BlocProvider<CoingeckoListTrendingBloc>(
          create: (context) => CoingeckoListTrendingBloc(
            coingeckoListTrendingRepository:
                CoingeckoListTrendingRepositoryImpl(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Color(0xFFFF25CB9D),

          // Default brightness
          // brightness: Brightness.dark

          // Default font family
          fontFamily: 'Bahnschrift Static',

          // Default textTheme
          textTheme: TextTheme(
            // Headings
            // 34 Light
            headline1: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w200,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
              shadows: [
                Shadow(
                  color: primaryDark.withOpacity(0.16),
                  offset: Offset(0, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            // 24 Light
            headline2: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w200,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
            ),
            // 20 Regular
            headline3: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
            ),
            // 18 Regular
            headline4: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
            ),
            // 18 SemiLight
            headline5: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
            ),
            // 16 SemiLight
            headline6: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
            ),

            // Body
            // 14 Regular
            bodyText1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
            ),
            // 14 SemiLight
            bodyText2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.6,
            ),

            // Subtitle
            // 12 Regular
            subtitle1: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryDark,
              letterSpacing: 0.25,
              height: 1.4,
            ),
            // 12 Bold
            subtitle2: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryDark.withOpacity(0.5),
              letterSpacing: 0.25,
              height: 1.4,
            ),
          ),

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
          '/buyportfolio1': (context) => BuyPortfolioScreenOne(),
          '/buyportfolio': (context) => BuyPortfolioScreen(),
          // '/buyportfolio2': (context) => BuyPortfolioPage2(),
          // '/buyportfolio3': (context) => BuyPortfolioPage3(),
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
          '/marketoverview': (context) => MarketOverview(),
          '/mycoins': (context) => MyCoins(),
          // '/dashboardwithcategory': (context) => DashboardWithCategory(),
        },
      ),
    );
  }
}
