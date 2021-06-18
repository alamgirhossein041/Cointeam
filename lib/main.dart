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
          create: (context) => StartupBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), coinmarketcapListQuoteRepository: CardCoinmarketcapCoinListRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<SellPortfolioBloc>(
          create: (context) => SellPortfolioBloc(binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(), binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
        BlocProvider<BuyPortfolioBloc> (
          create: (context) => BuyPortfolioBloc(binanceBuyCoinRepository: BinanceBuyCoinRepositoryImpl(), binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          
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
