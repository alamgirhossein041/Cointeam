import 'dart:developer';

import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/model/db_model/db_porsche/get_portfolio_model.dart';
import 'package:coinsnap/v2/repo/db_repo/db_porsche/get_portfolio_repo.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class BuyPortfolioPage2 extends StatefulWidget {

  @override
  BuyPortfolioPage2State createState() => BuyPortfolioPage2State();
}

class BuyPortfolioPage2State extends State<BuyPortfolioPage2> {
  final _scrollController = ScrollController();

  String symbol = '';
  double percentageValue = 0.0;

  List<String> portfolioList = [];

  LocalStorage localStorage = LocalStorage("coinstreetapp");

  GetPortfolioImpl dummyPortfolio = GetPortfolioImpl();
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

  
    GetPortfolioModel portfolioMap = dummyPortfolio.getPortfolio();

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
                          child: Text("Your Portfolio Snapshot", style: TextStyle(color: Colors.white, fontSize: 22)),
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
                                      portfolioMap.data.forEach((k,v) => {

                                      });
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
                                              child: Text(portfolioMap.data
                                            )
                                          ]
                                        )
                                      );
                                    })
                                  )
                                ]
                              )
                            )
                          )
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