import 'package:flutter/material.dart';

import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/buy_portfolio_bloc/buy_portfolio_state.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyPortfolioPage3 extends StatefulWidget {
  // BuyPortfolioPage3({Key key}) : super(key: key);

  @override
  BuyPortfolioPage3State createState() => BuyPortfolioPage3State();
}

class BuyPortfolioPage3State extends State<BuyPortfolioPage3> {

  String symbol = '';
  double percentageValue = 0.0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    // if (arguments == null) {
    //   debugPrint("Arguments is null in BuyPage3");
    // } else {
    //   symbol = arguments['symbol'];
    //   percentageValue = arguments['value'];
    // }

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
                              // child: Text("You sold " + (percentageValue*100).toString() + "% of your portfolio", style: TextStyle(color: Colors.white))
                              child: Text("You have received:", style: TextStyle(color: Colors.white)),
                            )
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("\$0.00" , style: TextStyle(color: Colors.white, fontSize: 30))
                            ),
                          ),
                          // Flexible(
                          //   flex: 1,
                          //   fit: FlexFit.tight,
                          //   child: Align(
                          //     alignment: Alignment.center,
                          //     child: Text(
                          //   )
                          // )
                          // Flexible(
                          //   flex: 1,
                          //   fit: FlexFit.tight,
                          //   child: Align(
                          //     alignment: Alignment.topCenter,
                          //     child: Text("B 0.0198000", style: TextStyle(color: Colors.white))
                          //   )
                          // ),
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
                                            // BlocProvider.of<BuyPortfolioBloc>(context).add(FetchBuyPortfolioEvent(value: percentageValue, coinTicker: symbol)),
                                            // Navigator.pushNamed(context, '/Buyportfolio3', arguments: {'value': percentageValue, 'symbol': symbol})
                                            // Navigator.pushNamed(context, '/hometest'),
                                            
                                          },
                                        // ),
                                        // elevation: 2,
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
            //     }
            //   },
            // ),
                  
                } else {
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
                }
              }
            )
          ]
        ),
      )
    );
  }
}