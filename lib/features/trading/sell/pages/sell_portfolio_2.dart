import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/modules/portfolio/models/exchanges/ftx_get_balance.dart';
import 'package:coinsnap/modules/utils/number_formatter.dart';
// import 'package:coinsnap/modules/trading/portfolio/sell/bloc/sell_portfolio_bloc/sell_portfolio_bloc.dart';
// import 'package:coinsnap/modules/trading/portfolio/sell/bloc/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellPortfolioPage2 extends StatefulWidget {

  @override
  SellPortfolioPage2State createState() => SellPortfolioPage2State();
}

class SellPortfolioPage2State extends State<SellPortfolioPage2> {
  final _scrollController = ScrollController();
  int coinCount = 0;
  double coinTotalValue = 0.0;
  ValueNotifier<double> totalValueChange = ValueNotifier(0.0);
  String symbol = '';
  double percentageValue = 0.0;
  bool preview = true;

  List<BinanceGetAllModel> binanceModel;
  FtxGetBalanceModel ftxModel;

  List<String> coinsToRemove = [];
  List<String> binanceList = [];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments == null) {
      debugPrint("Arguments is null");
    } else {
      preview = arguments['preview'];
      symbol = arguments['symbol'];
      percentageValue = arguments['value'] / 100;
      log("Target symbol is " + symbol);
      log("Percentage to sell is " + percentageValue.toString());
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2197F2),
        ),
        height: displayHeight(context),
        width: displayWidth(context),
        child: Column(
          children: <Widget> [
            // if(preview)...[
            //   Container(
            //     height: 50,
            //     width: displayWidth(context),
            //     decoration: BoxDecoration(
            //       color: Color(0xFF36343E),
            //       // borderRadius: BorderRadius.all(Radius.circular(10))
            //     ),
            //   ),
            //   Flexible(
            //     flex: 2,
            //     fit: FlexFit.tight,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Colors.grey[600],
            //       ),
            //       child: Row(
            //         children: <Widget> [
            //           Flexible(
            //             flex: 4,
            //             fit: FlexFit.tight,
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Text("PREVIEW MODE", style: TextStyle(color: Colors.white)),
            //             ),
            //           ),
            //         ]
            //       )
            //     )
            //   ),
            // ] else...[
            //   Flexible(
            //     flex: 1,
            //     fit: FlexFit.tight,
            //     child: Container(
            //     )
            //   ),
            // ],
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.only(top: 35),
                child: Row(
                  children: <Widget> [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          onTap: () => {
                            BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
                            Navigator.pop(context),
                          },
                        )
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Review Sell Order", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(),
                    )
                  ]
                )
              )
            ),
            Flexible(
              flex: 18,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: displayWidth(context) * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: <Widget> [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container()
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          // child: Padding(
                            // padding: EdgeInsets.fromLTRB(40,20,0,0),
                            child: Text("Your Portfolio Snapshot", style: TextStyle(color: Colors.black))
                          // )
                        )
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,20,0,30),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget> [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  // child: Text("Number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 33),
                                      child: Text("Symbol", style: TextStyle(color: Color(0X800B2940))),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Quantity", style: TextStyle(color: Color(0X800B2940))),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 55),
                                      child: Text("Cost", style: TextStyle(color: Color(0X800B2940)))
                                    ),
                                  )
                                )
                              ]
                            )
                          ),
                        )
                      ),
                      Flexible(
                        flex: 16,
                        fit: FlexFit.tight,
                        child: BlocConsumer<StartupBloc, StartupState>(
                          listener: (context, state) {
                            if (state is StartupErrorState) {
                              debugPrint("Error occured in sell_portfolio_page_two.dart, StartupBloc");
                            }
                          },
                          builder: (context, state) {
                            if (state is StartupLoadedState) {
                              log(binanceModel.toString());
                              binanceModel = state.binanceGetAllModel;
                              log(binanceModel.toString());
                              // binanceModel.data.remove(symbol);
                              // ftxModel = state.ftxPortfolioModel;
                              // ftxModel.data.remove(symbol);
                              // var binanceKeys = binanceModel.data.keys.toList();
                              // var ftxKeys = ftxModel.data.keys.toList();

                              return Column(
                                children: <Widget> [
                                  Flexible(
                                    flex: 10,
                                    fit: FlexFit.tight,
                                    child: Scrollbar(
                                      controller: _scrollController,
                                      isAlwaysShown: true,
                                      thickness: 5,
                                      child: CustomScrollView(
                                        controller: _scrollController,
                                        slivers: <Widget> [
                                          // SliverToBoxAdapter(
                                          SliverList(
                                            delegate: SliverChildBuilderDelegate((context, index) {
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
                                              double tmp = state.binanceGetAllModel[index].free;
                                              log(tmp.toString());
                                              if (tmp != null) {
                                                double pmt = (state.binanceGetAllModel[index].totalUsdValue * percentageValue);
                                                if(pmt > 10) {
                                                  coinTotalValue += pmt;
                                                  totalValueChange.value = coinTotalValue;
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
                                                          child: Text(state.binanceGetAllModel[index].coin.toString(), style: TextStyle(color: Color(0XFF0B2940))),
                                                        ),
                                                        Flexible(
                                                          flex: 3,
                                                          fit: FlexFit.tight,
                                                          child: Text(numberFormatter(state.binanceGetAllModel[index].free), style: TextStyle(color: Color(0XFF0B2940), fontSize: 15)),
                                                        ),
                                                        Flexible(
                                                          flex: 3,
                                                          fit: FlexFit.tight,
                                                          child: Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(right: 15),
                                                              child: Builder(
                                                                builder: (context) {
                                                                  // return Text("\$" + binanceModel[index].totalUsdValue.toStringAsFixed(2));
                                                                  return Text("\$" + (binanceModel[index].totalUsdValue * percentageValue).toStringAsFixed(2), style: TextStyle(color: Color(0XFF0B2940), fontSize: 15));
                                                                  // final condition = state.binanceGetPricesMap[binanceList[index] + symbol] != null;
                                                                  // return condition ? Text("\$" + 
                                                                    // (binanceModel.data[binanceList[index]].totalUsdValue * percentageValue).toStringAsFixed(2))
                                                                    // : Text("No USDT Pair");
                                                                }
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(right: 15),
                                                            child: Icon(Icons.close, color: Color(0X660B2940), size: 18),
                                                          ),
                                                          onTap: () => {
                                                            binanceModel.removeWhere((item) => item.coin == binanceModel[index].coin),
                                                            coinsToRemove.add(binanceModel[index].coin),
                                                            // binanceModel.data.remove(binanceKeys[index]),
                                                            // binanceKeys.removeAt(index),
                                                            setState(() {}),
                                                            /// ### Remove from state.coinListReceived??? Make a new lsit for it, then remove it, then setState refresh ### /// 
                                                          },
                                                        ), /// ### Todo: Icon
                                                      ]
                                                    ),
                                                  );
                                                } else {
                                                  // coinsToRemove.add(binanceKeys[index]);
                                                  return Container();
                                                }
                                              } else {
                                                return Container();
                                              }
                                            },
                                            childCount: (binanceModel.length),
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
                                              child: Text("TOTAL", style: TextStyle(color: Color(0XFF0B2940), fontWeight: FontWeight.bold)),
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
                                                //     binanceModel.data.forEach((k,v) {
                                                //       var pmt = state.binanceGetPricesMap[k + symbol];
                                                //       if(pmt != null) {
                                                //         var tmp = pmt * (v.free) * percentageValue;
                                                //         if (tmp > 10) {
                                                //           coinTotalValue += tmp;
                                                //           totalValueChange.value = coinTotalValue;
                                                //         } else {
                                                //           coinsToRemove.add(k);
                                                //         }
                                                //       }
                                                //     });
                                                    // return Text("\$" + coinTotalValue.toStringAsFixed(2));
                                                  child: Builder(
                                                    builder: (context) {
                                                      binanceModel.forEach((v) {
                                                        var pmt = v.totalUsdValue;
                                                        if(pmt != null && pmt > 0) {
                                                          var tmp = pmt * percentageValue;
                                                          if (tmp > 10) {
                                                            coinTotalValue += tmp;
                                                            totalValueChange.value = coinTotalValue;
                                                          } else {
                                                            coinsToRemove.add(v.coin);
                                                          }
                                                        }
                                                      });
                                                      return ValueListenableBuilder(
                                                        valueListenable: totalValueChange,
                                                        builder: (BuildContext context, double coinTotalValue, Widget child) {
                                                          log(coinTotalValue.toString());
                                                          return Text("\$" + coinTotalValue.toStringAsFixed(2), style: TextStyle(color: Color(0XFF0B2940)));
                                                        }
                                                      );
                                                    }
                                                  // }
                                                // )
                                              )
                                            )
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
                                          // ValueListenableBuilder(
                                          //   valueListenable: totalValueChange,
                                          //   builder: (BuildContext context, double coinTotalValue, Widget child) {
                                          //     return Text("Selling \$" + coinTotalValue.toStringAsFixed(2) + " into USDT (estimated)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
                                          //   }
                                          // ),
                                          // SizedBox(height: 30),
                                          // Text("Binance Trade Rules:", style: TextStyle(color: Colors.black)),
                                          Text("This will attempt to sell " + (percentageValue * 100).toStringAsFixed(1) + "% of your coins.", style: TextStyle(color: Colors.black, fontSize: 14)),
                                          SizedBox(height: 10),
                                          // Text("Values under \$10 cannot be sold.", style: TextStyle(color: Colors.black)),
                                          Text("Your portfolio will be saved.", style: TextStyle(color: Colors.black, fontSize: 14)),
                                        ]
                                      )
                                    )
                                  ),
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: displayHeight(context) * 0.03),
                                        child: Container( /// ### Review Order button
                                          height: displayHeight(context) * 0.065,
                                          width: displayWidth(context) * 0.825,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(40),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(40),
                                                color: Color(0xFF2197F2),
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text("Sell", style: TextStyle(color: Colors.white))
                                              ),
                                            ),
                                            onTap: () => {
                                              BlocProvider.of<SellPortfolioBloc>(context).add(FetchSellPortfolioEvent(value: percentageValue, coinTicker: symbol, coinsToRemove: coinsToRemove, preview: preview)),
                                              Navigator.pushNamed(context, '/sellportfolio3', arguments: {'value': percentageValue, 'symbol': symbol, 'preview': preview})
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Flexible(
                                  //   flex: 2,
                                  //   fit: FlexFit.tight,
                                  //   child: Align(
                                  //     alignment: Alignment.center,
                                  //     child: Container( /// ### Edit button
                                  //       height: displayHeight(context) * 0.055,
                                  //       width: displayWidth(context) * 0.35,
                                  //         child: InkWell(
                                  //           splashColor: Colors.red,
                                  //           highlightColor: Colors.red,
                                  //           hoverColor: Colors.red,
                                  //           focusColor: Colors.red,
                                  //           borderRadius: BorderRadius.circular(20),
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(20),
                                  //               border: Border.all(color: Colors.blue[200]),
                                  //               color: Color(0xFF2B3139),
                                  //             ),
                                  //             child: Align(
                                  //               alignment: Alignment.center,
                                  //               child: Text("Edit", style: TextStyle(color: Colors.white))
                                  //             ),
                                  //           ),
                                  //           onTap: () => {
                                  //             BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
                                  //             Navigator.pop(context),
                                  //           },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Container(),
                                  ),
                                ]
                              );
                            } else {
                              return loadingTemplateWidget();
                            }
                          }
                      )
                      // Flexible(
                      //   flex: 3,
                      //   fit: FlexFit.tight,
                      //   child: Align(
                      //     alignment: Alignment.center,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(top: 20),
                      //       child: Text("Your Portfolio Snapshot", style: TextStyle(color: Colors.white, fontSize: 22)),
                      //     ),
                      //   )
                      // ),
                      // Flexible(
                      //   flex: 17,
                      //   fit: FlexFit.tight,
                      //   child: BlocConsumer<StartupBloc, StartupState>(
                      //     listener: (context, state) {
                      //       if (state is StartupErrorState) {
                      //         debugPrint("Error occured in sell_portfolio_page_two.dart, StartupBloc");
                      //       }
                      //     },
                      //     builder: (context, state) {
                      //       if (state is StartupLoadedState) {
                      //         log(binanceModel.toString());
                      //         binanceModel = state.binanceGetAllModel;
                      //         log(binanceModel.toString());
                      //         // binanceModel.data.remove(symbol);
                      //         // ftxModel = state.ftxPortfolioModel;
                      //         // ftxModel.data.remove(symbol);
                      //         // var binanceKeys = binanceModel.data.keys.toList();
                      //         // var ftxKeys = ftxModel.data.keys.toList();

                      //         return Column(
                      //           children: <Widget> [
                      //             Flexible(
                      //               flex: 6,
                      //               fit: FlexFit.tight,
                      //               child: Scrollbar(
                      //                 controller: _scrollController,
                      //                 isAlwaysShown: true,
                      //                 thickness: 5,
                      //                 child: CustomScrollView(
                      //                   controller: _scrollController,
                      //                   slivers: <Widget> [
                      //                     SliverToBoxAdapter(
                      //                       child: Padding(
                      //                         padding: EdgeInsets.fromLTRB(0,20,0,30),
                      //                         child: Align(
                      //                           alignment: Alignment.center,
                      //                           child: Row(
                      //                             children: <Widget> [
                      //                               Flexible(
                      //                                 flex: 1,
                      //                                 fit: FlexFit.tight,
                      //                                 child: Padding(
                      //                                   padding: EdgeInsets.only(left: displayWidth(context) * 0.14),
                      //                                   child: Text("Symbol", style: TextStyle(fontWeight: FontWeight.bold)),
                      //                                 ),
                      //                               ),
                      //                               Flexible(
                      //                                 flex: 1,
                      //                                 fit: FlexFit.tight,
                      //                                 // child: Text("Number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      //                                 child: Container(),
                      //                               ),
                      //                               Flexible(
                      //                                 flex: 1,
                      //                                 fit: FlexFit.tight,
                      //                                 child: Align(
                      //                                   alignment: Alignment.centerRight,
                      //                                   child: Padding(
                      //                                     padding: EdgeInsets.only(right: 40),
                      //                                     child: Text("USDT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                      //                                   ),
                      //                                 )
                      //                               )
                      //                             ]
                      //                           )
                      //                         ),
                      //                       )
                      //                     ),
                      //                     SliverList(
                      //                       delegate: SliverChildBuilderDelegate((context, index) {
                      //                         // double tmp = state.binanceGetPricesMap[binanceListToSell.data[coin] + 'USDT'];
                      //                         // if (tmp != null) {
                      //                           // double pmt = tmp * (coinListReceived[index].free * percentageValue);
                      //                           // if (pmt > 10) {
                      //                         // double tmp = 0.0;
                      //                         // double pmt = 0.0;
                                              
                      //                         // String tickerIndex = '';
                      //                         // tmp = state.binanceGetPricesMap[binanceList[index] + symbol];
                      //                         // tmp = binanceModel?.data[binanceKeys[index]]?.totalUsdValue;
                      //                         //   if(binanceKeys[index] == 'USDT') {
                      //                         //     tmp = 1.0;
                      //                         //   }

                      //                         //   if(tmp != null) {
                      //                         //   pmt = tmp * binanceModel.data[binanceKeys[index]]?.free * percentageValue;
                      //                         //   // pmt = tmp * percentageValue;
                      //                         //   log(pmt.toString());
                      //                         double tmp = state.binanceGetAllModel[index].free;
                      //                         log(tmp.toString());
                      //                         if (tmp != null) {
                      //                           double pmt = (state.binanceGetAllModel[index].totalUsdValue * percentageValue);
                      //                           if(pmt > 10) {
                      //                             return Padding(
                      //                               padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                      //                               child: Row(
                      //                                 children: <Widget> [
                      //                                   Flexible(
                      //                                     flex: 1,
                      //                                     fit: FlexFit.tight,
                      //                                     child: GestureDetector(
                      //                                       child: Icon(Icons.close),
                      //                                       onTap: () => {
                      //                                         binanceModel.removeWhere((item) => item.coin == binanceModel[index].coin),
                      //                                         coinsToRemove.add(binanceModel[index].coin),
                      //                                         // binanceModel.data.remove(binanceKeys[index]),
                      //                                         // binanceKeys.removeAt(index),
                      //                                         setState(() {}),
                      //                                         /// ### Remove from state.coinListReceived??? Make a new lsit for it, then remove it, then setState refresh ### /// 
                      //                                       },
                      //                                     ), /// ### Todo: Icon
                      //                                   ),
                      //                                   Flexible(
                      //                                     flex: 3,
                      //                                     fit: FlexFit.tight,
                      //                                     child: Text(state.binanceGetAllModel[index].name.toString()),
                      //                                   ),
                      //                                   Flexible(
                      //                                     flex: 3,
                      //                                     fit: FlexFit.tight,
                      //                                     child: Align(
                      //                                       alignment: Alignment.centerRight,
                      //                                       child: Padding(
                      //                                         padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                      //                                         child: Builder(
                      //                                           builder: (context) {
                      //                                             // return Text("\$" + binanceModel[index].totalUsdValue.toStringAsFixed(2));
                      //                                             return Text("\$" + (binanceModel[index].totalUsdValue * percentageValue).toStringAsFixed(2));
                      //                                             // final condition = state.binanceGetPricesMap[binanceList[index] + symbol] != null;
                      //                                             // return condition ? Text("\$" + 
                      //                                               // (binanceModel.data[binanceList[index]].totalUsdValue * percentageValue).toStringAsFixed(2))
                      //                                               // : Text("No USDT Pair");
                      //                                           }
                      //                                         ),
                      //                                       ),
                      //                                     )
                      //                                   )
                      //                                 ]
                      //                               ),
                      //                             );
                      //                           } else {
                      //                             // coinsToRemove.add(binanceKeys[index]);
                      //                             return Container();
                      //                           }
                      //                         } else {
                      //                           return Container();
                      //                         }
                      //                       },
                      //                       childCount: (binanceModel.length),
                      //                       ),
                      //                     ),
                      //                     // SliverList(
                      //                     //   delegate: SliverChildBuilderDelegate((context, index) {
                                            
                      //                     //   },
                      //                     //   childCount: (ftxKeys.length),
                      //                     //   ),
                      //                     // ),
                      //                   ]
                      //                 ),
                      //               ),
                      //             ),
                      //             Align(
                      //               alignment: Alignment.topCenter,
                      //               child: Text("-----------------------------------------------", style: TextStyle(color: Colors.grey))
                      //             ),
                      //             Flexible(
                      //               flex: 2,
                      //               fit: FlexFit.tight,
                      //               child: Align(
                      //                 alignment: Alignment.center,
                      //                 child: Row(
                      //                   children: <Widget> [
                      //                     Flexible(
                      //                       flex: 1,
                      //                       fit: FlexFit.tight,
                      //                       child: Padding(
                      //                         padding: EdgeInsets.only(left: 30),
                      //                         child: Text("TOTAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      //                       )
                      //                     ),
                      //                     Flexible(
                      //                       flex: 1,
                      //                       fit: FlexFit.tight,
                      //                       child: Align(
                      //                         alignment: Alignment.centerLeft,
                      //                         // child: Text(coinCount.toString() + " coins", style: TextStyle(color: Colors.grey)),
                      //                         child: Container(),
                      //                       ),
                      //                     ),
                      //                     Flexible(
                      //                       flex: 1,
                      //                       fit: FlexFit.tight,
                      //                       child: Align(
                      //                         alignment: Alignment.centerRight,
                      //                         child: Padding(
                      //                           padding: EdgeInsets.only(right: 30),
                      //                           // child: Text("\$" + coinTotalValue.toStringAsFixed(2), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      //                           // child: Text("\$" + (state.totalValue * state.btcSpecial / 1.1).toStringAsFixed(2)),
                      //                           // child: Builder(
                      //                           //   builder: (context) {
                      //                               // binanceModel.data.forEach((k,v) {
                      //                               //   var pmt = state.binanceGetPricesMap[k + symbol];
                      //                               //   if(pmt != null) {
                      //                               //     var tmp = pmt * (v.free) * percentageValue;
                      //                               //     if (tmp > 10) {
                      //                               //       coinTotalValue += tmp;
                      //                               //       totalValueChange.value = coinTotalValue;
                      //                               //     } else {
                      //                               //       coinsToRemove.add(k);
                      //                               //     }
                      //                               //   }
                      //                               // });
                      //                               // return Text("\$" + coinTotalValue.toStringAsFixed(2));
                      //                               child: Text("\$" + coinTotalValue.toStringAsFixed(2)),
                      //                             // }
                      //                           // )
                      //                         )
                      //                       )
                      //                     )
                      //                   ]
                      //                 )
                      //               ),
                      //             ),
                      //             Flexible(
                      //               flex: 3,
                      //               fit: FlexFit.tight,
                      //               child: Align(
                      //                 alignment: Alignment.center,
                      //                 child: Column(
                      //                   children: <Widget> [
                      //                     ValueListenableBuilder(
                      //                       valueListenable: totalValueChange,
                      //                       builder: (BuildContext context, double coinTotalValue, Widget child) {
                      //                         return Text("Selling \$" + coinTotalValue.toStringAsFixed(2) + " into USDT (estimated)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
                      //                       }
                      //                     ),
                      //                     SizedBox(height: 30),
                      //                     Text("Binance Trade Rules:", style: TextStyle(color: Colors.white)),
                      //                     SizedBox(height: 10),
                      //                     Text("Values under \$10 cannot be sold.", style: TextStyle(color: Colors.white)),
                      //                   ]
                      //                 )
                      //               )
                      //             ),
                      //             Flexible(
                      //               flex: 2,
                      //               fit: FlexFit.tight,
                      //               child: Align(
                      //                 alignment: Alignment.center,
                      //                 child: Container( /// ### Sell button
                      //                   height: displayHeight(context) * 0.055,
                      //                   width: displayWidth(context) * 0.35,
                      //                     child: InkWell(
                      //                       splashColor: Colors.red,
                      //                       highlightColor: Colors.red,
                      //                       hoverColor: Colors.red,
                      //                       focusColor: Colors.red,
                      //                       borderRadius: BorderRadius.circular(20),
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(20),
                      //                           color: Color(0xFFF4C025),
                      //                         ),
                      //                         child: Align(
                      //                           alignment: Alignment.center,
                      //                           child: Text("Sell", style: TextStyle(color: Colors.black))
                      //                         ),
                      //                       ),
                      //                       onTap: () => {
                      //                         BlocProvider.of<SellPortfolioBloc>(context).add(FetchSellPortfolioEvent(value: percentageValue, coinTicker: symbol, coinsToRemove: coinsToRemove, preview: preview)),
                      //                         Navigator.pushNamed(context, '/sellportfolio3', arguments: {'value': percentageValue, 'symbol': symbol, 'preview': preview})
                      //                       },
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Flexible(
                      //               flex: 2,
                      //               fit: FlexFit.tight,
                      //               child: Align(
                      //                 alignment: Alignment.center,
                      //                 child: Container( /// ### Edit button
                      //                   height: displayHeight(context) * 0.055,
                      //                   width: displayWidth(context) * 0.35,
                      //                     child: InkWell(
                      //                       splashColor: Colors.red,
                      //                       highlightColor: Colors.red,
                      //                       hoverColor: Colors.red,
                      //                       focusColor: Colors.red,
                      //                       borderRadius: BorderRadius.circular(20),
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(20),
                      //                           border: Border.all(color: Colors.blue[200]),
                      //                           color: Color(0xFF2B3139),
                      //                         ),
                      //                         child: Align(
                      //                           alignment: Alignment.center,
                      //                           child: Text("Edit", style: TextStyle(color: Colors.white))
                      //                         ),
                      //                       ),
                      //                       onTap: () => {
                      //                         BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
                      //                         Navigator.pop(context),
                      //                       },
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Flexible(
                      //               flex: 1,
                      //               fit: FlexFit.tight,
                      //               child: Container(),
                      //             ),
                      //           ]
                      //         );
                      //       } else {
                      //         return loadingTemplateWidget();
                      //       }
                      //     }
                      //   ),
                      // ),
                      ),
                    ]
                  )
                ),
              ),
            ),
          ]
        )
      )
    );
  }
  // changevaluenotifiervalue(double _value) async {

  //   await Future.delayed(Duration(microseconds: 1));
  //   totalValueChange.value += _value;
  //   coinTotalValue = totalValueChange.value;
  // }
}