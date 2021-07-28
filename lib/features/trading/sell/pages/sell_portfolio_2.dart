import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/features/utils/number_formatter.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
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
                          behavior: HitTestBehavior.opaque,
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
                            child: Text("Your Portfolio Snapshot", style: TextStyle(color: Colors.black))
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
                              children: <Widget> [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
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
                                          /// SliverList with Delegate lets us build a list dyanmically through a list
                                          /// Possible to refactor into listview.builder(?), SliverList is expensive
                                          SliverList(
                                            delegate: SliverChildBuilderDelegate((context, index) {
                                              double tmp = state.binanceGetAllModel[index].free;
                                              log(tmp.toString());
                                              if (tmp != null) {
                                                double pmt = (state.binanceGetAllModel[index].totalUsdValue * percentageValue);
                                                // if(state.binanceGetAllModel[index].coin.toString() == symbol) {
                                                //   return Padding(
                                                //     padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                                //     child: Row(
                                                //       children: <Widget> [
                                                //         Flexible(
                                                //           flex: 1,
                                                //           fit: FlexFit.tight,
                                                //           child: Container(),
                                                //         ),
                                                //         Flexible(
                                                //           flex: 3,
                                                //           fit: FlexFit.tight,
                                                //           child: Text(state.binanceGetAllModel[index].coin.toString(), style: TextStyle(color: Color(0XFF0B2940))),
                                                //         ),
                                                //         Flexible(
                                                //           flex: 3,
                                                //           fit: FlexFit.tight,
                                                //           child: Text(numberFormatter(state.binanceGetAllModel[index].free * percentageValue), style: TextStyle(color: Color(0XFF0B2940), fontSize: 15)),
                                                //           /// 21st June
                                                //         ),
                                                //         Flexible(
                                                //           flex: 3,
                                                //           fit: FlexFit.tight,
                                                //           child: Align(
                                                //             alignment: Alignment.centerRight,
                                                //             child: Padding(
                                                //               padding: EdgeInsets.only(right: 15),
                                                //               child: Text("N/A"),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         GestureDetector(
                                                //           child: Padding(
                                                //             padding: EdgeInsets.only(right: 15),
                                                //             child: Icon(Icons.close, color: Color(0X660B2940), size: 18),
                                                //           ),
                                                //           onTap: () => {
                                                //             binanceModel.removeWhere((item) => item.coin == binanceModel[index].coin),
                                                //             coinsToRemove.add(binanceModel[index].coin),
                                                //             setState(() {}),
                                                //             /// ### Remove from state.coinListReceived??? Make a new lsit for it, then remove it, then setState refresh ### /// 
                                                //           },
                                                //         ), /// ### Todo: Icon
                                                //       ]
                                                //     ),
                                                //   );
                                                if (pmt <= 10) {
                                                  coinsToRemove.add(binanceModel[index].coin);
                                                  return Container();
                                                } else if (state.binanceGetAllModel[index].coin.toString() == symbol) {
                                                  // log("12312313");
                                                  coinsToRemove.add(binanceModel[index].coin);
                                                  return Container();
                                                } else if (state.securitiesFilter.contains(binanceModel[index].coin)) {
                                                  coinsToRemove.add(binanceModel[index].coin);
                                                  return Container();
                                                } else {
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
                                                          child: Text(numberFormatter(state.binanceGetAllModel[index].free * percentageValue), style: TextStyle(color: Color(0XFF0B2940), fontSize: 15)),
                                                          /// 21st June
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
                                                                  return Text("\$" + (binanceModel[index].totalUsdValue * percentageValue).toStringAsFixed(2), style: TextStyle(color: Color(0XFF0B2940), fontSize: 15));
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
                                                            coinsToRemove.add(binanceModel[index].coin),
                                                            binanceModel.removeWhere((item) => item.coin == binanceModel[index].coin),
                                                            log("Popping off " + binanceModel[index].coin),
                                                            setState(() {}),
                                                            /// ### Remove from state.coinListReceived??? Make a new lsit for it, then remove it, then setState refresh ### /// 
                                                          },
                                                        ), /// ### Todo: Icon
                                                      ]
                                                    ),
                                                  );
                                                }
                                              } else {
                                                return Container();
                                              }
                                            },
                                            childCount: (binanceModel.length),
                                            ),
                                          ),
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
                                                  child: Builder(
                                                    builder: (context) {
                                                      binanceModel.forEach((v) {
                                                        if(v.coin != symbol) {
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
                                          Text("This will attempt to sell " + (percentageValue * 100).toStringAsFixed(1) + "% of your coins.", style: TextStyle(color: Colors.black, fontSize: 14)),
                                          SizedBox(height: 10),
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
}