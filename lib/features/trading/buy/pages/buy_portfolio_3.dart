import 'dart:developer';

import 'package:coinsnap/features/data/portfolio/user_data/model/get_portfolio.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/trading/trading.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyPortfolioScreenThree extends StatefulWidget {
  BuyPortfolioScreenThree({Key key}) : super(key: key);

  @override
  BuyPortfolioScreenThreeState createState() => BuyPortfolioScreenThreeState();
}

class BuyPortfolioScreenThreeState extends State<BuyPortfolioScreenThree> {
  Map<String, dynamic> coinDataStructure = {};
  List<String> keyString = [];
  double toSpend = 0.0;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments == null) {
      log("Arguments is null in snapshot_log.dart");
    } else {
      coinDataStructure = arguments['coinDataStructure'];
      toSpend = double.parse(arguments['toSpend']) ?? 0.0;
    }
    if(coinDataStructure['coins'] != null) {
      keyString = coinDataStructure['coins'].keys.toList();
      keyString.forEach((v) => log(v));
    }
    
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(title: Text('Buy from Snapshot')),
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Buy from Snapshot"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPaddingVertical(),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: BuyPortfolioReviewLog(coinDataStructure: coinDataStructure, keyString: keyString, toSpend: toSpend)
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }
}


class BuyPortfolioReviewLog extends StatefulWidget {
  const BuyPortfolioReviewLog({
    Key key,
    @required this.keyString,
    @required this.coinDataStructure,
    @required this.toSpend,
  }) : super(key: key);
  
  final Map<String, dynamic> coinDataStructure;
  final List<String> keyString;
  final double toSpend;

  @override
  BuyPortfolioReviewLogState createState() => BuyPortfolioReviewLogState();
}

class BuyPortfolioReviewLogState extends State<BuyPortfolioReviewLog> {
  final _scrollController = ScrollController();
  double usdTempQuote = 0.0;
  GetPortfolioModel buySnapshotData;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: displayHeight(context),
      width: displayWidth(context) * 0.97,
      decoration: BoxDecoration(
        color: primaryLight,
        // color: Color(0xFF36343E),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        children: <Widget> [
          // Flexible(
          //   flex: 2,
          //   fit: FlexFit.tight,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget> [
          //       Align(
          //         alignment: Alignment.centerLeft,
          //         child: Padding(
          //           padding: EdgeInsets.fromLTRB(30,0,0,0),
          //           child: Text(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(widget.coinDataStructure['timestamp'])), style: TextStyle(color: Colors.black)),
          //         ),
          //       ),
          //       Align(
          //         alignment: Alignment.centerLeft,
          //         child: Padding(
          //           padding: EdgeInsets.fromLTRB(30,10,0,0),
          //           child: Text(DateFormat('hh:mm:ss a').format(DateTime.fromMillisecondsSinceEpoch(widget.coinDataStructure['timestamp'])), style: TextStyle(fontSize: 14, color: Color(0x800B2940))),
          //         ),
          //       ),
          //       Container(height: 15),
          //     ]
          //   )
          // ),
          Flexible(
            flex: 14,
            fit: FlexFit.tight,
            child: Column(
              children: <Widget> [
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Text("-----------------------------------------------", style: TextStyle(color: Color(0x330B2940)))
                // ),
                // Container(height: 20),
                Flexible(
                  flex: 4,
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
                            padding: EdgeInsets.fromLTRB(0,0,0,30),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget> [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: displayWidth(context) * 0.1),
                                      // child: Text("Symbol", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                      child: Text("12 coins", style: TextStyle(color: Color(0x800B2940), fontSize: 14))
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      // child: Padding(
                                      //   padding: EdgeInsets.only(left: 20),
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text("%", style: TextStyle(color: Color(0x800B2940), fontSize: 14)),
                                        ),
                                      // ),
                                    ),
                                    // child: Container(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 35),
                                        child: Text("Quantity", style: TextStyle(color: Color(0x800B2940), fontSize: 14)),
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
                            Map<String, dynamic> text = widget.coinDataStructure['coins'][widget.keyString[index]];
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
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(widget.keyString[index].toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                                        // child: Container(),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                          // alignment: Alignment.centerRight,
                                            alignment: Alignment.centerRight,
                                            // child: Padding(
                                              // padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                                              child: Text(text['quantity'].toStringAsFixed(8), style: TextStyle(fontSize: 14, color: Colors.black)),
                                              // child: Text(999999999999.toStringAsFixed(8), style: TextStyle(fontSize: 15)),
                                              // child: Builder(
                                              //   builder: (context) {
                                              //     // return Text("\$" + binanceModel[index].totalUsdValue.toStringAsFixed(2));
                                              //     return Text("\$" + text);
                                              //     // final condition = state.binanceGetPricesMap[binanceList[index] + symbol] != null;
                                              //     // return condition ? Text("\$" + 
                                              //       // (binanceModel.data[binanceList[index]].totalUsdValue * percentageValue).toStringAsFixed(2))
                                              //       // : Text("No USDT Pair");
                                              //   }
                                              // ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        fit: FlexFit.tight,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                                            child: Text(text['value'].toStringAsFixed(2), style: TextStyle(fontSize: 15, color: Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                );
                            },
                            childCount: (widget.keyString.length),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("-----------------------------------------------", style: TextStyle(color: Color(0x330B2940)))
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    /// Balance Section
                    
                    child: Column(
                      children: <Widget> [
                        SizedBox(height: displayHeight(context) * 0.02),
                        Row(
                          children: <Widget> [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text("Available", style: TextStyle(color: Colors.black)),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 50),
                                  // child: Text("-\$250.00")
                                  // child: BlocConsumer<StartupBloc, StartupState>(
                                  //   listener: (context, state) {
                                  //     if (state is StartupErrorState) {
                                  //       log("An error has occurred in buy_portfolio_3.dart BuyPortfolioReviewLog");
                                  //     }
                                  //   },
                                  //   builder: (context, state) {
                                  //     if (state is StartupLoadedState) {
                                  //       usdTempQuote = state.usdTotal;
                                  //       return Text('\$' + state.usdTotal.toStringAsFixed(2));
                                  //     } else if (state is StartupErrorState) {
                                  //       return Text("An Error has occurred in Binance");
                                  //     } else {
                                  //       return loadingTemplateWidget();
                                  //     }
                                  //   }
                                  // )
                                  child: Text('\$' + widget.toSpend.toStringAsFixed(2))
                                )
                              )
                            )
                          ]
                        ),
                        Row(
                          children: <Widget> [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text("To Buy", style: TextStyle(color: Colors.black)),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 50),
                                  // child: Text("-\$250.00")
                                  // child: BlocConsumer<StartupBloc, StartupState>(
                                  //   listener: (context, state) {
                                  //     if (state is StartupErrorState) {
                                  //       log("An error has occurred in buy_portfolio_3.dart BuyPortfolioReviewLog");
                                  //     }
                                  //   },
                                  //   builder: (context, state) {
                                  //     if (state is StartupLoadedState) {
                                  //       return Text('-\$' + state.usdTotal.toStringAsFixed(2));
                                  //     } else if (state is StartupErrorState) {
                                  //       return Text("An Error has occurred in Binance");
                                  //     } else {
                                  //       return loadingTemplateWidget();
                                  //     }
                                  //   }
                                  // )
                                  child: Text('\$' + widget.toSpend.toStringAsFixed(2))
                                )
                              )
                            )
                          ]
                        ),
                        Row(
                          children: <Widget> [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text("Estimated Fees", style: TextStyle(color: Colors.black)),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 50),
                                  // child: Text("-\$250.00")
                                  // child: BlocConsumer<StartupBloc, StartupState>(
                                  //   listener: (context, state) {
                                  //     if (state is StartupErrorState) {
                                  //       log("An error has occurred in buy_portfolio_3.dart BuyPortfolioReviewLog");
                                  //     }
                                  //   },
                                  //   builder: (context, state) {
                                  //     if (state is StartupLoadedState) {
                                  //       return Text('-\$' + (state.usdTotal * 0.001).toStringAsFixed(2));
                                  //     } else if (state is StartupErrorState) {
                                  //       return Text("An Error has occurred in Binance");
                                  //     } else {
                                  //       return loadingTemplateWidget();
                                  //     }
                                  //   }
                                  // )
                                  child: Text('\$' + (widget.toSpend * 0.001).toStringAsFixed(2))
                                )
                              )
                            )
                          ]
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text("-----------------------------------------------", style: TextStyle(color: Color(0x330B2940)))
                        ),
                        Row(
                          children: <Widget> [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text("Balance", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                                  padding: EdgeInsets.only(right: 50),
                                  // child: BlocConsumer<StartupBloc, StartupState>(
                                  //   listener: (context, state) {
                                  //     if (state is StartupErrorState) {
                                  //       log("An error has occurred in buy_portfolio_3.dart BuyPortfolioReviewLog");
                                  //     }
                                  //   },
                                  //   builder: (context, state) {
                                  //     if (state is StartupLoadedState) {
                                  //       return Text('\$' + state.usdTotal.toStringAsFixed(2), style: TextStyle(color: Colors.black));
                                  //     } else if (state is StartupErrorState) {
                                  //       return Text("An Error has occurred in Binance");
                                  //     } else {
                                  //       return loadingTemplateWidget();
                                  //     }
                                  //   }
                                  // )
                                  child: Text('\$' + (widget.toSpend * 0.999).toStringAsFixed(2))
                                )
                              )
                            )
                          ]
                        ),
                        Row(),
                      ]
                    )
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.bottomCenter,
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
                              child: Text("Edit", style: TextStyle(color: Colors.white))
                            ),
                          ),
                          onTap: () => {
                            Navigator.pop(context),
                          },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.topCenter,
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
                              child: Text("Buy", style: TextStyle(color: Colors.white))
                            ),
                          ),
                          onTap: () => {
                            buySnapshotData = GetPortfolioModel.fromJson(widget.coinDataStructure),
                            BlocProvider.of<BuyPortfolioBloc>(context).add(FetchBuyPortfolioEvent(totalBuyQuote: widget.toSpend, coinTicker: 'USDT', portfolioList: widget.keyString, portfolioDataMap: buySnapshotData)), /// TODO: update temporary 7th July
                          }
                        )
                      ),
                    ),
                  ),
                // Flexible(
                //   flex: 1,
                //   fit: FlexFit.tight,
                //   child: Container(),
                // ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}