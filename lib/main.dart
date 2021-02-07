import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/data/respository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/data/respository/unauth/prices/binance_get_prices.dart';
import 'package:coinsnap/ui/pages/builder/builder.dart';
import 'package:coinsnap/ui/pages/builder/test.dart';
import 'package:coinsnap/ui/home_view.dart';
import 'package:coinsnap/ui/pages/portfolio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/authentication.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetTotalValueBloc>(
      create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeView(), /// TODO: Change this to Authentication() for production
          '/builder': (context) => PortfolioBuilderView(), /// TODO: Have {id} links? If possible
          '/testview': (context) => TestView(),
          // '/portfolio': (context) => PriceContai
        }
      ),
    );
  }
}
