import 'dart:developer';

import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_bloc.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_state.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SellPortfolioScreen extends StatefulWidget {

  @override
  SellPortfolioScreenState createState() => SellPortfolioScreenState();
}

class SellPortfolioScreenState extends State<SellPortfolioScreen> {

  String dropdownValue = 'USDT';
  int dropdownIndex = 0;
  double _value = 50.0;
  double totalValueEstimated = 0.0;
  bool preview = true;

  /// We will add 'ETH' back in when we have worked out
  /// Trade bridging - many coins don't have an ETH pair
  /// FOR EXAMPLE: Cake/usdt OK, Cake/btc OK, Cake/eth NO
  List<String> targetCoins = ['USDT', 'BTC'];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments == null) {
      debugPrint("Arguments is null");
    } else {
      preview = arguments['preview'];
    }
    return WillPopScope(
      /// This Section Prevents User-Swipe from going back
      /// Important for slider - if user swipes all the way to the left, then right,
      /// it counts as a side-swipe-go-back-action
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFF0E0F18),
          ),
          height: displayHeight(context),
          width: displayWidth(context),
          child: Column(
            children: <Widget> [
              if(preview)...[
                Container(
                  height: 50,
                  width: displayWidth(context),
                  decoration: BoxDecoration(
                    color: Color(0xFF36343E),
                    // borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                    ),
                    child: Row(
                      children: <Widget> [
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("PREVIEW MODE", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ]
                    )
                  )
                ),
              ] else...[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
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
                                Navigator.pop(context),
                                setState(() {})
                              },
                            )
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Selling Coins", style: TextStyle(color: Colors.white)),
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
              ],
              Flexible(
                flex: 13,
                fit: FlexFit.tight,
                child: Container(
                  width: displayWidth(context),
                  decoration: BoxDecoration(
                    color: Color(0xFF36343E),
                    // borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    children: <Widget> [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30,20,0,0),
                            child: Text("Market Order", style: TextStyle(color: Colors.white))
                          )
                        )
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Row(
                          children: <Widget> [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Portfolio Sell", style: TextStyle(fontSize: 24, color: Colors.green[300])),
                              ),
                            ),
                            // Flexible(
                            //   flex: 1,
                            //   fit: FlexFit.tight,
                            //   child: Text(" Sell", style: TextStyle(fontSize: 24, color: Colors.green[300])),
                            // ),
                          ]
                        )
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text("Targets all coins in your portfolio", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        )
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget> [
                              Text("You will receive:", style: TextStyle(color: Colors.grey)),
                              DropdownButton<String>(
                                dropdownColor: uniColor,
                                value: buildDropdownValue(dropdownIndex),
                                icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                iconSize: 24,
                                elevation: 16,
                                style: Theme.of(context).textTheme.bodyText2,
                                underline: Container(
                                  height: 2,
                                  padding: EdgeInsets.only(right: 40),
                                  color: Colors.yellow,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                    dropdownIndex = targetCoins.indexOf(newValue);
                                    // imageIndex = targetCoins.indexOf(newValue);
                                  });
                                  // widget.callback(imageIndex);
                                },
                                items: targetCoins.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: BlocConsumer<StartupBloc, StartupState>(
                            listener: (context, state) {
                              if (state is StartupErrorState) {
                                debugPrint("An error occurred in sell_portfolio.dart - StartupErrorState");
                              }
                            },
                            builder: (context, state) {
                              if (state is StartupLoadedState) {
                                totalValueEstimated = state.totalValue * _value / 100;
                                return Column(
                                  children: <Widget> [
                                    Text("You are selling:"),
                                    SizedBox(height: 20),
                                    Text((_value).toStringAsFixed(1) + "% of your portfolio", style: TextStyle(color: Colors.white))
                                  ],
                                );
                              } else if (state is StartupErrorState) {
                                /// 26th
                                return Text(state.errorMessage);
                              } else if (state is StartupLoadingState) {
                                log("Startup Loading");
                                return loadingTemplateWidget();
                              } else {
                                return loadingTemplateWidget();
                              }
                            }
                          )
                        )
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: SfSliderTheme(
                            data: SfSliderThemeData(
                              tooltipBackgroundColor: Colors.red[500],
                            ),
                            child: SfSlider(
                              min: 0.0,
                              max: 100.0,
                              value: _value,
                              interval: 100,
                              showTicks: false,
                              showLabels: false,
                              enableTooltip: true,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _value = value;
                                });
                              }
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget> [
                              SizedBox(height: 20),
                              Text("Estimated Fees", style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 5),
                              Text("\$" + (totalValueEstimated/1000).toStringAsFixed(2), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ]
                          )
                        )
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text("Your portfolio will be saved.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 10),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: displayHeight(context) * 0.03),
                            child: Container( /// ### Review Order button
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
                                      child: Text("Review Order", style: TextStyle(color: Colors.black))
                                    ),
                                  ),
                                  onTap: () => {
                                    Navigator.pushNamed(context, '/sellportfolio2', arguments: {'value': _value, 'symbol': dropdownValue, 'preview': preview}),
                                    // Navigator.pushNamed(context, '/hometest'),
                                    
                                  },
                                // ),
                                // elevation: 2,
                              ),
                            ),
                          ),
                        )
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: displayHeight(context) * 0.015),
                          child: TextButton(
                            onPressed: () => {
                              Navigator.pushReplacementNamed(context, '/buyportfolio', arguments: {'preview': preview})
                            },
                            child: Text("Buy Order"),
                          ),
                        )
                      )
                    ],
                  )
                )
              )
            ]
          )
        ),
      ),
    );
  }
  String buildDropdownValue(int selected) {
    switch (selected) {
    case 0:
      // USDT
      return 'USDT';
    case 1:
      // BTC
      return 'BTC';
    // case 2:
    //   // ETH
    //   return 'ETH';
    default:
      // default is USDT lel
      return 'USDT';
    break;
    }
  }
}