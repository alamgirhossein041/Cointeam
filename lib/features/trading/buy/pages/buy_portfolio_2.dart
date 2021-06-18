import 'package:coinsnap/features/data/portfolio/user_data/model/get_portfolio.dart';
import 'package:coinsnap/features/data/portfolio/user_data/repo/get_portfolio.dart';
import 'package:coinsnap/features/trading/buy/bloc/buy_portfolio_bloc/buy_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/buy/bloc/buy_portfolio_bloc/buy_portfolio_event.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
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
  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  GetPortfolioImpl primePortfolio = GetPortfolioImpl();
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments == null) {
      debugPrint("Arguments is null");
    } else {
      symbol = arguments['symbol'];
      totalBuyQuote = arguments['value'];
      debugPrint("Target symbol is " + symbol);
      debugPrint("Total Buy Quote is " + totalBuyQuote.toString());
    }

    GetPortfolioModel portfolioDataMap = primePortfolio.getPortfolio("portfolio");

    int devindex = 0;
    portfolioDataMap.data.forEach((k,v) => {
      debugPrint(devindex.toString()),
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
                                        child: Builder(
                                          builder: (context) {
                                            final condition = portfolioList[index] != 'USDTTOTAL' && portfolioList[index] != 'BTCTOTAL';
                                            return condition ? BuyPortfolio2Row(portfolioList[index], portfolioDataMap.data[portfolioList[index]])
                                              : Container();
                                            }
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
                                            final conditionUsd = portfolioDataMap.data['USDTTOTAL'] != null;
                                            final conditionBtc = portfolioDataMap.data['BTCTOTAL'] != null;
                                            if(conditionUsd) {
                                              return Text("\$" + portfolioDataMap.data['USDTTOTAL'].toStringAsFixed(2));
                                            } else if(conditionBtc) {
                                              return Text("\$" + portfolioDataMap.data['BTCTOTAL'].toStringAsFixed(2));
                                            } else {
                                              return Container();
                                            }
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
                                    debugPrint("Buy Button Pressed"),
                                    BlocProvider.of<BuyPortfolioBloc>(context).add(FetchBuyPortfolioEvent(totalBuyQuote: totalBuyQuote, coinTicker: symbol, portfolioList: portfolioList, portfolioDataMap: portfolioDataMap)),
                                    Navigator.pushNamed(context, '/buyportfolio3')
                                    /// 7th - we need to pass in something - like a list or a map or something
                                  },
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

class BuyPortfolio2Row extends StatelessWidget {
  const BuyPortfolio2Row(this.coinName, this.coinQuantity);
  final String coinName;
  final double coinQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Text(coinName),
          // child: Container(),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
              child: Text("\$" + coinQuantity.toStringAsFixed(2)),
            )
          )
        )
      ]
    );
  }
}