import 'package:coinsnap/features/trading/buy/bloc/buy_portfolio_bloc/buy_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/buy/bloc/buy_portfolio_bloc/buy_portfolio_state.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class BuyPortfolioPage3 extends StatefulWidget {

  @override
  BuyPortfolioPage3State createState() => BuyPortfolioPage3State();
}

class BuyPortfolioPage3State extends State<BuyPortfolioPage3> {

  String symbol = '';
  double percentageValue = 0.0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF36343E),
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
            BlocConsumer<BuyPortfolioBloc, BuyPortfolioState>(
              listener: (context, state) {
                if (state is BuyPortfolioErrorState) {
                  debugPrint("Error in buy_portfolio_page_three.dart - BuyPortfolioBloc");
                }
              },
              builder: (context, state) {
                if (state is BuyPortfolioLoadedState) {
                  log("BuyPortfolioLoadedState");
                  debugPrint("BuyPortfolioLoadedState");
                  return Flexible(
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
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Icon(Icons.close, color: Colors.grey[400]),
                              ),
                            )
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Icon(Icons.done, size: 60, color: Colors.white)
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Buy order complete!", style: TextStyle(color: Colors.white, fontSize: 24))
                            )
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("You have received:", style: TextStyle(color: Colors.white)),
                            )
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("\$" + state.totalValue.toString(), style: TextStyle(color: Colors.white, fontSize: 30))
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Flexible(
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
                                              child: Text("Done", style: TextStyle(color: Colors.black))
                                            ),
                                          ),
                                          onTap: () => {
                                            count = 0,
                                            Navigator.popUntil(context, (route) {
                                                return count++ == 3;
                                            })
                                          },
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("See transaction log", style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
                            )
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is BuyPortfolioErrorState) {
                  return Text(state.errorMessage);
                } else if (state is BuyPortfolioLoadingState) {
                  return Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget> [
                          Text("Placing market orders", style: TextStyle(color: Colors.white, fontSize: 28)),
                          Text("Do not close the app", style: TextStyle(color: Colors.white, fontSize: 28)),
                        ]
                      )
                    ),
                  );
                } else {
                  return loadingTemplateWidget();
                }
              }
            )
          ]
        ),
      )
    );
  }
}