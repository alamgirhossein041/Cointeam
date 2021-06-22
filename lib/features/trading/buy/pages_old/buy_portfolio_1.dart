import 'package:coinsnap/features/data/total_tradeable_value/total_tradeable_value.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class BuyPortfolioScreen extends StatefulWidget {

  @override
  BuyPortfolioScreenState createState() => BuyPortfolioScreenState();
}

class BuyPortfolioScreenState extends State<BuyPortfolioScreen> {

  String dropdownValue = 'USDT';
  int dropdownIndex = 0;
  double _value = 50.0;
  double totalValueEstimated = 0.0;
  String totalValueEstimatedString = '';
  List<String> baseCoins = ['USDT', 'BTC'];

  @override
  Widget build(BuildContext context) {
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
              /// Copying layout from sell_portfolio.dart
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
                          child: Text("Buying Historical Portfolio", style: TextStyle(color: Colors.white)),
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
                flex: 13,
                fit: FlexFit.tight,
                child: Container(
                  width: displayWidth(context),
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
                                alignment: Alignment.centerRight,
                                child: Text("Cross", style: TextStyle(fontSize: 24, color: Colors.grey[400])),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(" Buy", style: TextStyle(fontSize: 24, color: Colors.green[300])),
                            ),
                          ]
                        )
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text("Buying Target Portfolio", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        )
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget> [
                              /// ### For now we can only use USDT or BTC to buy stuff ### ///
                              Text("Using Base Asset:", style: TextStyle(color: Colors.grey)),
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
                                    dropdownIndex = baseCoins.indexOf(newValue);
                                    // imageIndex = targetCoins.indexOf(newValue);
                                  });
                                  // widget.callback(imageIndex);
                                },
                                items: baseCoins.map<DropdownMenuItem<String>>((String value) {
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
                          child: BlocConsumer<GetTotalValueBloc, GetTotalValueState>(
                            listener: (context, state) {
                              if (state is GetTotalValueErrorState) {
                                debugPrint("An error occurred in sell_portfolio.dart - GetTotalValueErrorState");
                              }
                            },
                            builder: (context, state) {
                              if (state is GetTotalValueLoadedState) {
                                if (dropdownValue == 'USDT') {
                                  totalValueEstimated = state.usdSpecial * _value / 100;
                                  totalValueEstimatedString = "\$" + totalValueEstimated.toStringAsFixed(2);
                                } else if (dropdownValue == 'BTC') {
                                  totalValueEstimated = state.btcQuantity * state.btcSpecial * _value / 100;
                                  totalValueEstimatedString = "B: " + (state.btcQuantity * _value / 100).toString();
                                }
                                return Column(
                                  children: <Widget> [
                                    Text("You are using:"),
                                    SizedBox(height: 20),
                                    Text(totalValueEstimatedString, style: TextStyle(color: Colors.white))
                                  ],
                                );
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
                        child: Text("Minimum trade size per coin is \$10"),
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
                                      child: Text("Review Order", style: TextStyle(color: Colors.black))
                                    ),
                                  ),
                                  onTap: () => {
                                    Navigator.pushNamed(context, '/buyportfolio2', arguments: {'value': totalValueEstimated, 'symbol': dropdownValue}),
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
                              Navigator.pushReplacementNamed(context, '/sellportfolio')
                            },
                            child: Text("Sell Order"),
                          ),
                        )
                      )
                    ]
                  )
                )
              )
            ]
          )
        )
      )
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
      return 'USDT';
    break;
    }
  }
}