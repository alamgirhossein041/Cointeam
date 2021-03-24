import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellPortfolioPage2 extends StatefulWidget {
  // SellPortfolioPage2({Key key}) : super(key: key);

  @override
  SellPortfolioPage2State createState() => SellPortfolioPage2State();
}

class SellPortfolioPage2State extends State<SellPortfolioPage2> {
  final _scrollController = ScrollController();

  int coinCount = 0;
  double coinTotalValue = 0.0;

  String symbol = '';
  double percentageValue = 0.0;

  List<String> coinsToRemove = [];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments == null) {
      log("Arguments is null");
    } else {
      symbol = arguments['symbol'];
      percentageValue = arguments['value'] / 100;
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
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
              )
            ),
            Flexible(
              flex: 12,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF36343E),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Your Portfolio Snapshot", style: TextStyle(color: Colors.white, fontSize: 22)),
                        ),
                      )
                    ),
                    // Flexible(
                    //   flex: 3,
                    //   fit: FlexFit.tight,
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: Row(
                    //       children: <Widget> [
                    //         Flexible(
                    //           flex: 1,
                    //           fit: FlexFit.tight,
                    //           child: Padding(
                    //             padding: EdgeInsets.only(left: displayWidth(context) * 0.14),
                    //             child: Text("Symbol", style: TextStyle(fontWeight: FontWeight.bold)),
                    //           ),
                    //         ),
                    //         Flexible(
                    //           flex: 1,
                    //           fit: FlexFit.tight,
                    //           // child: Text("Number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    //           child: Container(),
                    //         ),
                    //         Flexible(
                    //           flex: 1,
                    //           fit: FlexFit.tight,
                    //           child: Align(
                    //             alignment: Alignment.centerRight,
                    //             child: Padding(
                    //               padding: EdgeInsets.only(right: 40),
                    //               child: Text("USDT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                    //             ),
                    //           )
                    //         )
                    //       ]
                    //     )
                    //   )
                    // ),
                    Flexible(
                      flex: 17,
                      fit: FlexFit.tight,
                      child: BlocConsumer<GetTotalValueBloc, GetTotalValueState>(
                        listener: (context, state) {
                          if (state is GetTotalValueErrorState) {
                            log("Error occured in sell_portfolio_page_two.dart, GetTotalValueBloc");
                          }
                        },
                        builder: (context, state) {
                          if (state is GetTotalValueLoadedState) {
                            return Column(
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
                                            return Padding(
                                              padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                              child: Row(
                                                children: <Widget> [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(), /// ### Todo: Icon
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.tight,
                                                    child: Text(state.coinListReceived[index].coin),
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
                                                            final condition = state.binanceGetPricesMap[state.coinListReceived[index].coin + 'USDT'] != null;
                                                          //   if (condition) {
                                                          //     coinCount++;

                                                          //     log("HEll o" + coinCount.toString());
                                                          //     coinTotalValue += state.binanceGetPricesMap[state.coinListReceived[index].coin + 'USDT'] * (state.coinListReceived[index].free);
                                                          //     return Text("\$" + 
                                                          // (state.binanceGetPricesMap[state.coinListReceived[index].coin + 'USDT'] * (state.coinListReceived[index].free)).toStringAsFixed(2));
                                                          //   } else {
                                                          //     return Text("No USDT Pair");
                                                          //   }
                                                            
                                                          // (state.binanceGetPricesMap[state.coinListReceived[index].coin + 'USDT'] * (state.coinListReceived[index].free)).toStringAsFixed(2)) /// ### When we have logic to cancel 'locked' limit order coins, we will add .locked quantity here
                                                          return condition ? Text("\$" + 
                                                          (state.coinListReceived[index].totalUsdValue * percentageValue).toStringAsFixed(2))
                                                            : Text("No USDT Pair");
                                                          }
                                                        ),
                                                      ),
                                                    )
                                                  )
                                                ]
                                              ),
                                            );
                                          },
                                          childCount: state.coinListReceived.length
                                          ),
                                        )
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
                                              child: Builder(
                                                builder: (context) {
                                                  state.coinListReceived.forEach((v) {
                                                    var pmt = state.binanceGetPricesMap[v.coin + 'USDT'];
                                                    if(pmt != null) {
                                                      var tmp = pmt * (v.free) * percentageValue;
                                                      if (tmp > 10) {
                                                        coinTotalValue += tmp;
                                                      } else {
                                                        coinsToRemove.add(v.coin);
                                                      }
                                                    }
                                                  });
                                                  return Text("\$" + coinTotalValue.toStringAsFixed(2));
                                                }
                                              )
                                            ),
                                          )
                                        )
                                      ]
                                    )
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: <Widget> [
                                        Text("Selling \$" + coinTotalValue.toStringAsFixed(2) + " into USDT (estimated)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 30),
                                        Text("Binance Trade Rules:", style: TextStyle(color: Colors.white)),
                                        SizedBox(height: 10),
                                        Text("Values under \$10 cannot be sold.", style: TextStyle(color: Colors.white)),
                                      ]
                                    )
                                  )
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container( /// ### Sell button
                                      height: displayHeight(context) * 0.055,
                                      width: displayWidth(context) * 0.35,
                                      // child: Card(
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                                      //   ),
                                        child: InkWell(
                                          splashColor: Colors.red,
                                          highlightColor: Colors.red,
                                          hoverColor: Colors.red,
                                          focusColor: Colors.red,
                                          borderRadius: BorderRadius.circular(20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xFFF4C025),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Sell", style: TextStyle(color: Colors.black))
                                            ),
                                          ),
                                          onTap: () => {
                                            BlocProvider.of<SellPortfolioBloc>(context).add(FetchSellPortfolioEvent(value: percentageValue, coinTicker: symbol, coinsToRemove: coinsToRemove)),
                                            Navigator.pushNamed(context, '/sellportfolio3', arguments: {'value': percentageValue, 'symbol': symbol})
                                            // Navigator.pushNamed(context, '/hometest'),
                                            
                                          },
                                        // ),
                                        // elevation: 2,
                                      ),
                                    ),
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
                                      // child: Card(
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.all(Radius.circular(20)),
                                      //   ),
                                        child: InkWell(
                                          splashColor: Colors.red,
                                          highlightColor: Colors.red,
                                          hoverColor: Colors.red,
                                          focusColor: Colors.red,
                                          borderRadius: BorderRadius.circular(20),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.blue[200]),
                                              color: Color(0xFF2B3139),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Edit", style: TextStyle(color: Colors.white))
                                            ),
                                          ),
                                          onTap: () => {
                                            Navigator.pop(context),
                                            // Navigator.pushNamed(context, '/hometest'),
                                          },
                                        // ),
                                        // elevation: 2,
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
                            );
                          } else {
                            return loadingTemplateWidget();
                          }
                        }
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