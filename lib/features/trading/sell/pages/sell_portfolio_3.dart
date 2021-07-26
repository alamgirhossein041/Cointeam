import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/sell/bloc/sell_portfolio_bloc/sell_portfolio_state.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellPortfolioPage3 extends StatefulWidget {

  @override
  SellPortfolioPage3State createState() => SellPortfolioPage3State();
}

class SellPortfolioPage3State extends State<SellPortfolioPage3> {

  String symbol = '';
  double percentageValue = 0.0;
  int count = 0;
  bool preview = true;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments == null) {
      debugPrint("Arguments is null in SellPage3");
    } else {
      preview = arguments['preview'];
      symbol = arguments['symbol'];
      percentageValue = arguments['value'];
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
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(),
            ),
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
              flex: 22,
              fit: FlexFit.tight,
              child:  BlocConsumer<SellPortfolioBloc, SellPortfolioState>(
                listener: (context, state) {
                  if (state is SellPortfolioErrorState) {
                    debugPrint("Error in sell_portfolio_page_three.dart - SellPortfolioBloc");
                  }
                },
                builder: (context, state) {
                  if (state is SellPortfolioLoadedState) {
                    debugPrint("SellPortfolioLoadedState");
                    BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: displayWidth(context) * 0.97,
                        decoration: BoxDecoration(
                          color: Color(0xFF25CB9D),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          children: <Widget> [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Text("Order complete!", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 40),
                                    child: Icon(Icons.verified, color: Colors.white, size: 40),
                                  ),
                                ]
                              ),
                            ),
                            Flexible(
                              flex: 15,
                              fit: FlexFit.tight,
                              child: Container(
                                width: displayWidth(context) * 0.97,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Column(
                                  children: <Widget> [
                                    Flexible(
                                      flex: 13,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child: Column(
                                          children: <Widget> [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                // child: Text("You sold 78% of your portfolio", style: TextStyle(color: Colors.black)),
                                                child: Text("You sold " + (percentageValue * 100).toString() + "% of your portfolio", style: TextStyle(color: Colors.black, fontSize: 16)),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text("(Not including " + symbol + ")", style: TextStyle(color: Colors.black, fontSize: 16)),
                                              )
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget> [
                                                    Text("You converted: ", style: TextStyle(color: Colors.black, fontSize: 18)),
                                                    //Text("\$5,124.02", style: TextStyle(color: Colors.black, fontSize: 24)),
                                                    Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 24)),
                                                    SizedBox(height: 10),
                                                    // Text("B\$0.84314307", style: TextStyle(color: Colors.black)),
                                                    SizedBox(height: 10),
                                                    /// 22nd
                                                    /// Text(stuff)
                                                  ]
                                                ),
                                              )
                                            ),
                                            // Flexible(
                                            //   flex: 1,
                                            //   fit: FlexFit.tight,
                                            //   child: Align(
                                            //     alignment: Alignment.center,
                                            //     child: Text("You have received:", style: TextStyle(color: Colors.black)),
                                            //   )
                                            // ),
                                            // Flexible(
                                            //   flex: 1,
                                            //   fit: FlexFit.tight,
                                            //   child: Align(
                                            //     alignment: Alignment.center,
                                            //     child: Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 30))
                                            //   ),
                                            // ),
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: displayHeight(context) * 0.055,
                                                  width: displayWidth(context) * 0.35,
                                                    child: InkWell(
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
                                                        SchedulerBinding.instance.addPostFrameCallback((_) {
                                                          Navigator.popUntil(context, (route) {
                                                              return count++ == 3;
                                                          });
                                                        }),
                                                      },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: TextButton(
                                                  child: Text("See transaction log", style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
                                                  onPressed: () => {
                                                    Navigator.pushReplacementNamed(context, '/selllog', arguments: {'coinDataStructure': state.coinDataStructure, 'preview': preview, 'symbol': symbol}),
                                                  },
                                                ),
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: displayWidth(context) * 0.97,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFC44E),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          children: <Widget> [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Text("Processing Order...", style: TextStyle(fontSize: 24)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 40),
                                    child: Icon(Icons.query_builder, color: Colors.white, size: 40),
                                  ),
                                ]
                              ),
                            ),
                            Flexible(
                              flex: 15,
                              fit: FlexFit.tight,
                              child: Container(
                                width: displayWidth(context) * 0.97,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Column(
                                  children: <Widget> [
                                    Flexible(
                                      flex: 13,
                                      fit: FlexFit.tight,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Column(
                                          children: <Widget> [
                                            SizedBox(height: displayHeight(context) * 0.2),
                                            Text("Placing market orders", style: TextStyle(color: Colors.black, fontSize: 28)),
                                            Text("Do not close the app", style: TextStyle(color: Colors.black, fontSize: 28)),
                                          ]
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ]
                        ),
                      ),
                    );
                  }
                }
              )
            )
          ]
        )
      )
    );
  }
}