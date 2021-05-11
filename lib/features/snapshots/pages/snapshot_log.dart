import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/modules/portfolio/models/exchanges/ftx_get_balance.dart';
// import 'package:coinsnap/modules/trading/portfolio/sell/bloc/sell_portfolio_bloc/sell_portfolio_bloc.dart';
// import 'package:coinsnap/modules/trading/portfolio/sell/bloc/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellLog extends StatefulWidget {

  @override
  SellLogState createState() => SellLogState();
}

class SellLogState extends State<SellLog> {
  final _scrollController = ScrollController();
  int coinCount = 0;
  double coinTotalValue = 0.0;
  ValueNotifier<double> totalValueChange = ValueNotifier(0.0);
  String symbol = '';
  double percentageValue = 0.0;
  bool preview = true;
  Map<String, dynamic> coinsToSave = {};

  List<String> key = [];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments == null) {
      debugPrint("Arguments is null");
      log("Argument is null");
    } else {
      preview = arguments['preview'];
      symbol = arguments['symbol'];
      coinsToSave = arguments['coinsToSave'];

      key = coinsToSave.keys.toList();
      log(coinsToSave.toString());
      log("Target symbol is " + symbol);
      log("Percentage to sell is " + percentageValue.toString());
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0E0F18),
        ),
        height: displayHeight(context),
        width: displayWidth(context),
        child: Column(
          children: <Widget> [
            if(preview)...[
              Container(
                height: 50,
                width: displayWidth(context),
                decoration: BoxDecoration(
                  color: Color(0xFF36343E),
                  // borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                  ),
                  child: Row(
                    children: <Widget> [
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("PREVIEW MODE", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ]
                  )
                )
              ),
            ] else...[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                )
              ),
            ],
            Flexible(
              flex: 13,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF36343E),
                  // borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Column(
                        children: <Widget> [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              Text("Transaction Log", style: TextStyle(fontSize: 28)),
                              Container(),
                            ]
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              Text("01 Mar 2021"),
                              Text("12:12:12PM EST"),
                            ]
                          )
                        ]
                      )
                    ),
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: Column(
                        children: <Widget> [
                          Flexible(
                            flex: 6,
                            fit: FlexFit.tight,
                            child: Scrollbar(
                              controller: _scrollController,
                              isAlwaysShown: true,
                              thickness: 5,
                              child: CustomScrollView(
                                controller: _scrollController,
                                slivers: <Widget> [
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0,20,0,30),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: <Widget> [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: displayWidth(context) * 0.14),
                                                child: Text("Symbol", style: TextStyle(fontWeight: FontWeight.bold)),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              // child: Text("Number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                              child: Container(),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 40),
                                                  child: Text("USDT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                                ),
                                              )
                                            )
                                          ]
                                        )
                                      ),
                                    )
                                  ),
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate((context, index) {
                                      String text = coinsToSave[key[index]].toStringAsFixed(2);
                                      // double tmp = state.binanceGetPricesMap[binanceListToSell.data[coin] + 'USDT'];
                                      // if (tmp != null) {
                                        // double pmt = tmp * (coinListReceived[index].free * percentageValue);
                                        // if (pmt > 10) {
                                      // double tmp = 0.0;
                                      // double pmt = 0.0;
                                      
                                      // String tickerIndex = '';
                                      // tmp = state.binanceGetPricesMap[binanceList[index] + symbol];
                                      // tmp = binanceModel?.data[binanceKeys[index]]?.totalUsdValue;
                                      //   if(binanceKeys[index] == 'USDT') {
                                      //     tmp = 1.0;
                                      //   }

                                      //   if(tmp != null) {
                                      //   pmt = tmp * binanceModel.data[binanceKeys[index]]?.free * percentageValue;
                                      //   // pmt = tmp * percentageValue;
                                      //   log(pmt.toString());
                                      // double tmp = state.binanceGetAllModel[index].free;
                                      // log(tmp.toString());
                                      // if (tmp != null) {
                                        // double pmt = (state.binanceGetAllModel[index].totalUsdValue * percentageValue);
                                        // if(pmt > 10) {
                                          if(key[index] != (symbol + "TOTAL")) {
                                            return Padding(
                                              padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                              child: Row(
                                                children: <Widget> [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.tight,
                                                    child: Text(key[index].toString()),
                                                    // child: Container(),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.tight,
                                                    child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                                                        child: Builder(
                                                          builder: (context) {
                                                            // return Text("\$" + binanceModel[index].totalUsdValue.toStringAsFixed(2));
                                                            return Text("\$" + text);
                                                            // final condition = state.binanceGetPricesMap[binanceList[index] + symbol] != null;
                                                            // return condition ? Text("\$" + 
                                                              // (binanceModel.data[binanceList[index]].totalUsdValue * percentageValue).toStringAsFixed(2))
                                                              // : Text("No USDT Pair");
                                                          }
                                                        ),
                                                      ),
                                                    )
                                                  )
                                                ]
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                      //   } else {
                                      //     // coinsToRemove.add(binanceKeys[index]);
                                      //     return Container();
                                      //   }
                                      // } else {
                                      //   return Container();
                                      // }
                                    },
                                    childCount: (key.length),
                                    ),
                                  ),
                                  // SliverList(
                                  //   delegate: SliverChildBuilderDelegate((context, index) {
                                    
                                  //   },
                                  //   childCount: (ftxKeys.length),
                                  //   ),
                                  // ),
                                ]
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text("-----------------------------------------------", style: TextStyle(color: Colors.grey))
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget> [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text("TOTAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    )
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      // child: Text(coinCount.toString() + " coins", style: TextStyle(color: Colors.grey)),
                                      child: Container(),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 30),
                                        // child: Text("\$" + coinTotalValue.toStringAsFixed(2), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        // child: Text("\$" + (state.totalValue * state.btcSpecial / 1.1).toStringAsFixed(2)),
                                        // child: Builder(
                                        //   builder: (context) {
                                            // binanceModel.data.forEach((k,v) {
                                            //   var pmt = state.binanceGetPricesMap[k + symbol];
                                            //   if(pmt != null) {
                                            //     var tmp = pmt * (v.free) * percentageValue;
                                            //     if (tmp > 10) {
                                            //       coinTotalValue += tmp;
                                            //       totalValueChange.value = coinTotalValue;
                                            //     } else {
                                            //       coinsToRemove.add(k);
                                            //     }
                                            //   }
                                            // });
                                            // return Text("\$" + coinTotalValue.toStringAsFixed(2));
                                            child: Text("\$" + coinsToSave[symbol + "TOTAL"].toStringAsFixed(2)),
                                          // }
                                        // )
                                      )
                                    )
                                  )
                                ]
                              )
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container( /// ### Edit button
                                height: displayHeight(context) * 0.055,
                                width: displayWidth(context) * 0.35,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.blue[200]),
                                        color: Color(0xFF2B3139),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Done", style: TextStyle(color: Colors.white))
                                      ),
                                    ),
                                    onTap: () {
                                      BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
                                      int count = 0;
                                      Navigator.popUntil(context, (route) {
                                          return count++ == 3;
                                      });
                                    },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(),
                          ),
                        ]
                      ),
                    ),
                  ]
                )
              ),
            ),
          ]
        )
      )
    );
  }
}