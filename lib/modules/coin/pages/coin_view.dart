import 'dart:developer';

import 'package:coinsnap/modules/chart/bloc/coin/binance_get_individual_chart_bloc.dart';
import 'package:coinsnap/modules/chart/bloc/coin/binance_get_individual_chart_event.dart';
import 'package:coinsnap/modules/chart/widgets/chart_coin.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:coinsnap/modules/widgets/menu/drawer.dart';
import 'package:coinsnap/modules/widgets/menu/top_menu_row.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;

class CoinPage extends StatefulWidget {
  CoinPage({Key key}) : super(key: key);

  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  final double modalEdgePadding = 10;
  double usdValue = 0.0;
  String usdValueString = '';
  double btcValue = 0.0;
  String coinName = '';
  String coinTicker = '';
  String coinBalanceString = '';
  double portfolioValue = 1.0;
  String portfolioShareString = '-';

  

  int index = 0;
  var coinBalance;
  var coinListData;
  double totalValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    
    /// ### Dev Testing Values ### ///
    
    if (arguments == null) {
      debugPrint("Arguments is null");
    } else {
    //   debugPrint("Arguments is: " + arguments['cryptoData'].toString());
    //   debugPrint(arguments['cryptoData'][arguments['index']].toString());
    //   debugPrint(arguments['cryptoData'][arguments['index']].coin);
    //   debugPrint(arguments['cryptoData'][arguments['index']].name);
    //   debugPrint(arguments['cryptoData'][arguments['index']].free.toString());
    //   debugPrint(arguments['cryptoData'][arguments['index']].locked.toString());
    //   debugPrint(arguments['cryptoData'][arguments['index']].btcValue.toString());
      index = arguments['index'];
      coinBalance = arguments['coinBalancesMap'];
      coinListData = arguments['coinListData'];
      totalValue = arguments['totalValue'];
      // usdValue = arguments['cryptoData'][arguments['index']].usdValue ;
      // balance = arguments['cryptoData'][arguments['index']].free + arguments['cryptoData'][arguments['index']].locked;
      // totalValue = balance * usdValue;
      // coinName = arguments['cryptoData'][arguments['index']].name;
      // portfolioValue = arguments['portfolioValue'];
      debugPrint(totalValue.toString());
    }

    usdValue = coinBalance * coinListData.quote.uSD.price;
    portfolioShareString = ((usdValue / totalValue)*100).toStringAsFixed(1);

    /// ### Neatly formatting total price of coin:
    /// Eg. Dogecoin is $0.054998 = 6 decimal places is neat
    /// Eg. Bitcoin is $57,582.51 = 2 decimal places is neat
    /// QED // Conditional - If coin is greater or less than 1:
    
    if(usdValue > 1) {
      usdValueString = usdValue.toStringAsFixed(2);
    } else {
      usdValueString = usdValue.toStringAsFixed(6);
    }
    if(coinBalance > 1000) {
      coinBalanceString = coinBalance.toStringAsFixed(4);
    } else {
      coinBalanceString = coinBalance.toStringAsFixed(8);
    }
    if(usdValue > 1) {
      usdValueString = usdValue.toStringAsFixed(2);
    } else {
      usdValueString = ' < 1';
    }

    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.orientation == Orientation.landscape) {
      return Text("Hello World");
      /// if bloc check blabla see line 194
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF0E0F18),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomNavBar(),
        ),
        drawer: DrawerMenu(),
        body: Container(
          child: Column(
            children: <Widget> [
              SizedBox(height: displayHeight(context) * 0.05),
                /// ### Top Row starts here ### ///
              Builder(
                builder: (BuildContext innerContext) {
                  log(coinListData.toString());
                  return TopMenuRowBackButton(text: coinListData.name);
                }
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.only(left: 20), /// Constant padding
                      child: Icon(CryptoFontIcons.BTC, color: Colors.orange, size: 34),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: <Widget> [
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("\$" + usdValueString, style: TextStyle(color: Colors.white, fontSize: 24))
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("${coinListData.quote.uSD.percentChange24h.toStringAsFixed(2)}% (24h)", style: TextStyle(color: coinListData.quote.uSD.colorChange)),
                            ),),
                          )
                        ]
                      )
                    )
                  ]
                )
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [
                      SizedBox(width: displayWidth(context) * 0.1),
                      TextButton(
                        child: Text("( 24h )", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: () {
                          BlocProvider.of<BinanceGetIndividualChartBloc>(context).add(FetchBinanceGetIndividualChartEvent(binanceCoin: coinListData.symbol, binancePrice: coinListData.quote.uSD.price, timeSelection: globals.Status.daily));
                        }
                      ),
                      TextButton(
                        child: Text("( 7d )", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: () {
                          BlocProvider.of<BinanceGetIndividualChartBloc>(context).add(FetchBinanceGetIndividualChartEvent(binanceCoin: coinListData.symbol, binancePrice: coinListData.quote.uSD.price, timeSelection: globals.Status.weekly));
                        }
                      ),
                      TextButton(
                        child: Text("( 30d )", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: () {
                          BlocProvider.of<BinanceGetIndividualChartBloc>(context).add(FetchBinanceGetIndividualChartEvent(binanceCoin: coinListData.symbol, binancePrice: coinListData.quote.uSD.price, timeSelection: globals.Status.monthly));
                        }
                      ),
                      TextButton(
                        child: Text("( 1y )", style: TextStyle(color: Colors.white, fontSize: 14)),
                        onPressed: () {
                          BlocProvider.of<BinanceGetIndividualChartBloc>(context).add(FetchBinanceGetIndividualChartEvent(binanceCoin: coinListData.symbol, binancePrice: coinListData.quote.uSD.price, timeSelection: globals.Status.yearly));
                        }
                      ),
                      SizedBox(width: displayWidth(context) * 0.1),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Builder(
                  builder: (BuildContext buildcontext) {
                    BlocProvider.of<BinanceGetIndividualChartBloc>(context).add(FetchBinanceGetIndividualChartEvent(binanceCoin: coinListData.symbol, binancePrice: coinListData.quote.uSD.price, timeSelection: ''));
                    return ChartIndividual();
                  }
                ),
              ),
              // Expanded(
              //   flex: 2,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         /// ### Buy button ### ///
              //         Container(
              //           height: displayHeight(context) * 0.055,
              //           width: displayWidth(context) * 0.35,
              //             child: InkWell(
              //               splashColor: Colors.red,
              //               highlightColor: Colors.red,
              //               hoverColor: Colors.red,
              //               focusColor: Colors.red,
              //               borderRadius: BorderRadius.circular(20),
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(20),
              //                   color: Color(0xFF2B3139),
              //                 ),
              //                 child: Align(
              //                   alignment: Alignment.center,
              //                   child: Text("Buy", style: TextStyle(color: Colors.white))
              //                 ),
              //               ),
              //               onTap: () => {
              //                 // Navigator.pushNamed(context, '/hometest'),
              //               },
              //             // ),
              //             // elevation: 2,
              //           ),
              //         ),
              //         /// ### Sell Button ### ///
              //         Container(
              //           height: displayHeight(context) * 0.055,
              //           width: displayWidth(context) * 0.35,
              //           child: InkWell(
              //             splashColor: Color(0xFF2B3139),
              //             highlightColor: Color(0xFF2B3139),
              //             hoverColor: Color(0xFF2B3139),
              //             focusColor: Color(0xFF2B3139),
              //             borderRadius: BorderRadius.circular(20),
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Color(0xFF2B3139),
              //               ),
              //               child: Align(
              //                 alignment: Alignment.center,
              //                 child: Text("Sell", style: TextStyle(color: Colors.white))
              //               ),
              //             ),
              //             onTap: () => {
              //               // Navigator.pushNamed(context, '/hometest'),
                            
              //             },
              //           ),
              //         ),
              //       ]
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("------------", style: TextStyle(color: Colors.orange)),
                )
              ),
              Expanded(
                flex: 12,
                child: Container(
                  constraints: BoxConstraints.expand(),
                
                  decoration: BoxDecoration(color: Color(0xFF1A1B20)),
                  child: Container(
                    padding: EdgeInsets.only(top: 10), /// modal padding constant
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Investment", style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("\$" + usdValueString, style: TextStyle(color: Colors.white, fontSize: 24)),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget> [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Holdings", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        child: Text(coinBalanceString, style: TextStyle(color: Colors.white, fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Total Purchase Cost", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        child: Text("-", style: TextStyle(color: Colors.white, fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            ),
                          )
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget> [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Portfolio Share", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        child: Text(portfolioShareString + "%", style: TextStyle(color: Colors.blue[400], fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Total Profit/Loss", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        child: Text("-", style: TextStyle(color: Colors.greenAccent[400], fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            ),
                          )
                        ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: <Widget> [
                                Text("Have a suggestion?", style: TextStyle(color: Colors.white))
                              ]
                            )
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}