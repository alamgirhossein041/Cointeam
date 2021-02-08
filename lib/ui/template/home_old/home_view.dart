import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/data/model/unauth/prices/binance_get_prices.dart';
import 'package:coinsnap/data/respository/auth/get_all/binance_get_all.dart';
import 'package:coinsnap/data/respository/auth/sell_coin.dart/binance_sell_coin.dart';
import 'package:coinsnap/data/respository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:coinsnap/data/respository/unauth/prices/binance_get_prices.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer';

import '../home_content.dart';

/// class HomeView extends StatefulWidget {
///   HomeView({Key key}) : super(key: key);

///   @override
///   _HomeViewState createState() => _HomeViewState();
/// }

/// class _HomeViewState extends State<HomeView> {

/// *** The above is all that is different at the moment for stateless/stateful

class HomeView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldState,
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [appPink, Colors.blue],
            // colors: [darkRedColor, lightRedColor]
          ),
        ),
        child: Column(
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                IconButton(
                  icon: Icon(Icons.menu,
                    color: Colors.black,
                    size: 35),
                  onPressed: () {
                    scaffoldState.currentState.openDrawer();
                  }
                ),
              ],
            ),
            Container(
              height: displayHeight(context) * 0.88,
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: displayHeight(context),
                    child: Column(
                      children: <Widget> [
                        // SizedBox(height: displayHeight(context) * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget> [
                            Container(
                              child: BlocListener<GetTotalValueBloc, GetTotalValueState>(
                                listener: (context, state) {
                                  if (state is GetTotalValueErrorState) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.errorMessage)),
                                    );
                                  }
                                },
                                child: BlocBuilder<GetTotalValueBloc, GetTotalValueState>(
                                  builder: (context, state) {
                                    if (state is GetTotalValueLoadedState) {
                                      log("GetTotalValueLoadedState");
                                      return buildTicker(context, state.btcSpecial);
                                    } else {
                                      return SizedBox(height: displayHeight(context) * 0.02);
                                      // return SizedBox(height: displayHeight(context) * 0.075);
                                    }
                                  }
                                ),
                              ),
                            ),
                            SizedBox(width: displayWidth(context) * 0.06)
                          ],
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.s,
                          children: <Widget>[
                            SizedBox(height: displayHeight(context) * 0.02),
                            /// totalvalue
                            /// coinvalue
                            /// sellbutton
                            // BlocProvider(
                            //   create: (context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
                            //   child: InnerHomeView(),
                            // )
                            InnerHomeView(),
                            SizedBox(height: displayHeight(context) * 0.3),
                            BlocProvider<SellPortfolioBloc>( /// I think we use a BlocBuilder instread of a BlocProvider?
                              create: (_) => SellPortfolioBloc(binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),  /// GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
                              child: Builder(
                                builder: (context) {
                                  return IconButton(
                                // padding: EdgeInsets.all(0.0),
                                    icon: Icon(Icons.pause_circle_filled,
                                        color: Colors.black),
                                    iconSize: 100,
                                    onPressed: () async {
                                      BlocProvider.of<SellPortfolioBloc>(context).add(FetchSellPortfolioEvent());
                                      log("Did it work?");
                                    }
                                  );
                                  // _sellLogic.sellPortfolio(widget.coinList).then((val) => setState(() {
                                  //   _snapshot = val;
                                  //   globals.snapshot = _snapshot;
                                  //   showVisibility = !showVisibility;
                                    // }),
                                  // );
                                }
                              ),
                            ),
                            SizedBox(height: displayHeight(context) * 0.1),
                            ElevatedButton(child: Text("Go to next page"),
                              onPressed: () { Navigator.pushNamed(context, '/builder');}
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Future<Null> refreshEvent() async {
  //   /// setState(() {
  //   /// });
  //   /// 
  //   /// ***Instead of setState we use our Bloc event caller or whatever
  //   log("this is a very hard problem");

  // }

  Widget buildTicker(context, double btcSpecial) {
    return Container(
      height: displayHeight(context) * 0.02,
      child: Text("BTC: \$" + btcSpecial.toInt().toString()),
    );
  }
}