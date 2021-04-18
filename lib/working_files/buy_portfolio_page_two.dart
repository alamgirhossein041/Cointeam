import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_event.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/model/db_model/db_porsche/get_portfolio_model.dart';
import 'package:coinsnap/v2/repo/db_repo/db_porsche/get_portfolio_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class BuyPortfolioPage2 extends StatefulWidget {

  @override
  BuyPortfolioPage2State createState() => BuyPortfolioPage2State();
}

class BuyPortfolioPage2State extends State<BuyPortfolioPage2> {
  final _scrollController = ScrollController();

  String symbol = '';
  double totalBuyQuote = 0.0;

  List<String> portfolioList = [];

  LocalStorage localStorage = LocalStorage("coinstreetapp");

  GetPortfolioImpl primePortfolio = GetPortfolioImpl();
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments == null) {
      log("Arguments is null");
    } else {
      symbol = arguments['symbol'];
      totalBuyQuote = arguments['value'];
      log("Target symbol is " + symbol);
      log("Total Buy Quote is " + totalBuyQuote.toString());
    }

    /// ### TODO: Maybe replace "portfolio" with an actual string variable
    /// ### -- GetPortfolioImpl takes a string and uses that to get portfolio from LocalStorage
    /// 
    /// IF NULL
    /// 
    GetPortfolioModel portfolioDataMap = primePortfolio.getPortfolio("portfolio");
    /// TODO: delete index
    int devindex = 0;
    portfolioDataMap.data.forEach((k,v) => {
      log(devindex.toString()),
      portfolioList.add(k),
      devindex++
    });

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
              child: Container(),
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
                          child: Text("Your Purchase Order", style: TextStyle(color: Colors.white, fontSize: 22)),
                        ),
                      )
                    ),
                    Flexible(
                      flex: 17,
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
                                              )
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
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
                                      )
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
                                              child: GestureDetector(
                                                child: Icon(Icons.close),
                                                onTap: () => {

                                                }
                                              )
                                            ),
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Text(portfolioList[index]),
                                              // child: Container(),
                                            ),
                                            Flexible(
                                              flex: 3,
                                              fit: FlexFit.tight,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                                                  child: Text("\$" + portfolioDataMap.data[portfolioList[index]].toString()),
                                                )
                                              )
                                            )
                                            // )
                                          ]
                                        )
                                      );
                                    },
                                    childCount: portfolioList.length
                                    )
                                  )
                                ]
                              )
                            )
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
                                        //     coinListReceived.forEach((v) {
                                        //       var pmt = state.binanceGetPricesMap[v.coin + 'USDT'];
                                        //       if(pmt != null) {
                                        //         var tmp = pmt * (v.free) * percentageValue;
                                        //         if (tmp > 10) {
                                        //           coinTotalValue += tmp;
                                        //           totalValueChange.value = coinTotalValue;
                                        //         } else {
                                        //           coinsToRemove.add(v.coin);
                                        //         }
                                        //       }
                                        //     });
                                        //     return Text("\$" + coinTotalValue.toStringAsFixed(2));
                                        //   }
                                        // )
                                        child: Text("Hello World"),
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
                                    // valueListenable: totalValueChange,
                                  //   builder: (BuildContext context, double coinTotalValue, Widget child) {
                                  //     return Text("Selling \$" + coinTotalValue.toStringAsFixed(2) + " into USDT (estimated)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
                                  //   }
                                  // ),
                                  SizedBox(height: 30),
                                  Text("Binance Trade Rules:", style: TextStyle(color: Colors.white)),
                                  SizedBox(height: 10),
                                  Text("Values under \$10 cannot be bought.", style: TextStyle(color: Colors.white)),
                                ]
                              )
                            )
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container( /// ### Buy button
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
                                      child: Text("Buy", style: TextStyle(color: Colors.black))
                                    ),
                                  ),
                                  onTap: () => {
                                    log("Buy Button Pressed"),
                                    BlocProvider.of<BuyPortfolioBloc>(context).add(FetchBuyPortfolioEvent(totalBuyQuote: totalBuyQuote, coinTicker: symbol, portfolioList: portfolioList, portfolioDataMap: portfolioDataMap)),
                                    Navigator.pushNamed(context, '/sellportfolio3')
                                    /// 7th - we need to pass in something - like a list or a map or something
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
                      )
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}