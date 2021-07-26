import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/trading/buy/bloc/buy_portfolio_bloc/buy_portfolio_bloc.dart';
import 'package:coinsnap/features/trading/buy/bloc/buy_portfolio_bloc/buy_portfolio_state.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyPortfolioScreenFour extends StatefulWidget {
  BuyPortfolioScreenFour({Key key}) : super(key: key);

  @override
  _BuyPortfolioScreenFourState createState() => _BuyPortfolioScreenFourState();
}

class _BuyPortfolioScreenFourState extends State<BuyPortfolioScreenFour> {
  double totalValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          // appBar: AppBar(title: Text('Buy from Snapshot')),
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Buy from Snapshot"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                // padding: mainCardPaddingVertical(),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: BlocConsumer<BuyPortfolioBloc, BuyPortfolioState>(
                        listener: (context, state) {
                          if (state is BuyPortfolioErrorState) {
                            print("Error in buy_portfolio_4.dart");
                          }
                        },
                        builder: (context, state) {
                          if (state is BuyPortfolioLoadedState) { /// variables are: USD spent, BTC value, opening balance(USDT), cost(same as usd spent), estimated fees (0.1%), balance
                            BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
                            totalValue = state.totalValue;
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
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
                                        // width: displayWidth(context) * 0.97,
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
                                                        child: Text("Purchase summary", style: TextStyle(color: Colors.black, fontSize: 16)),
                                                      ),
                                                    ),
                                                    // SizedBox(height: 5),
                                                    // Flexible(
                                                    //   flex: 1,
                                                    //   fit: FlexFit.tight,
                                                    //   child: Align(
                                                    //     alignment: Alignment.topCenter,
                                                    //     child: Text("(Not including " + ")", style: TextStyle(color: Colors.black, fontSize: 16)),
                                                    //   )
                                                    // ),
                                                    Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.tight,
                                                      child: Align(
                                                        alignment: Alignment.topCenter,
                                                        child: Column(
                                                          // mainAxisAlignment: MainAxisAlignment.end,
                                                          children: <Widget> [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget> [
                                                                Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 24)),
                                                                Padding(
                                                                  padding: EdgeInsets.only(top: 7),
                                                                  child: Text(" USD", style: TextStyle(color: Colors.grey[300])),
                                                                ),
                                                              ]
                                                            ),
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
                                                      flex: 4,
                                                      fit: FlexFit.tight,
                                                      child: BlocConsumer<StartupBloc, StartupState>(
                                                        listener: (context, state) {
                                                          if (state is StartupErrorState) {
                                                            return Text("Error");
                                                          }
                                                        },
                                                        builder: (context, state) {
                                                          if (state is StartupLoadedState) {
                                                            return Column(
                                                              children: <Widget> [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget> [
                                                                    Text("Opening USDT balance"),
                                                                    Text("\$" + "USDTargumentcarriedover"),
                                                                  ]
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget> [
                                                                    Text("Cost"),
                                                                    Text("- \$" + totalValue.toStringAsFixed(2)),
                                                                  ]
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget> [
                                                                    Text("Estimated Fees"),
                                                                    Text("- \$" + (totalValue/1000).toStringAsFixed(2)) /// TODO: Round up to $0.01 if evaluating to 0.00 after rounding
                                                                  ]
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget> [
                                                                    Text("Balance"),
                                                                    Text("= \$" + state.totalValue)
                                                                  ]
                                                                )
                                                              ]
                                                            );
                                                          } else if (state is StartupErrorState) {
                                                            return Text("Error");
                                                          } else {
                                                            return loadingTemplateWidget();
                                                          }
                                                        }
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
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
                                                              onTap: () {
                                                                int count = 0;
                                                                SchedulerBinding.instance.addPostFrameCallback((_) {
                                                                  Navigator.popUntil(context, (route) {
                                                                      return count++ == 4;
                                                                  });
                                                                });
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
                                                            // Navigator.pushReplacementNamed(context, '/selllog', arguments: {'coinDataStructure': state.coinDataStructure, 'preview': preview, 'symbol': symbol}),
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
                          } else if (state is BuyPortfolioErrorState) {
                            return Text("Error");
                          } else {
                            return loadingTemplateWidget();
                          }
                        }
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}