import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SellPortfolioScreen extends StatefulWidget {

  @override
  SellPortfolioScreenState createState() => SellPortfolioScreenState();
}

class SellPortfolioScreenState extends State<SellPortfolioScreen> {

  String dropdownValue = 'USDT';
  int dropdownIndex = 0;
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
            color: Color(0xFF2197F2),
          ),
          height: displayHeight(context),
          width: displayWidth(context),
          child: Column(
            children: <Widget> [
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
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(top: 35),
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
                          child: Text("Sell Portfolio", style: TextStyle(color: Colors.white)),
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
              // ],
              ChangeNotifierProvider(
                create: (context) => ValueState(),
                child: Flexible(
                  flex: 18,
                  fit: FlexFit.tight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: displayWidth(context) * 0.97,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Column(
                        children: <Widget> [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container()
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40,0,0,0),
                                child: Text("Sell", style: TextStyle(color: Colors.black))
                              )
                            )
                          ),
                          // ),
                          // Flexible(
                          //   flex: 2,
                          //   fit: FlexFit.tight,
                          //   child: Row(
                          //     children: <Widget> [
                          //       Flexible(
                          //         flex: 1,
                          //         fit: FlexFit.tight,
                          //         child: Align(
                          //           alignment: Alignment.center,
                          //           child: Text("Portfolio Sell", style: TextStyle(fontSize: 24, color: Colors.green[300])),
                          //         ),
                          //       ),
                          //       // Flexible(
                          //       //   flex: 1,
                          //       //   fit: FlexFit.tight,
                          //       //   child: Text(" Sell", style: TextStyle(fontSize: 24, color: Colors.green[300])),
                          //       // ),
                          //     ]
                          //   )
                          // ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: BlocConsumer<StartupBloc, StartupState>(
                                listener: (context, state) {
                                  if (state is StartupErrorState) {
                                    debugPrint("An error occurred in sell_portfolio.dart - StartupErrorState");
                                  }
                                },
                                builder: (context, state) {
                                  if (state is StartupLoadedState) {
                                    return Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget> [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(35,10,0,0),
                                          child: Consumer<ValueState>(
                                            builder: (context, valueState, child) {
                                              if(dropdownValue == 'USDT') {
                                                return Text("\$" + ((state.totalValue - state.usdTotal) * valueState.value / 100).toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 32));
                                              } else if(dropdownValue == 'BTC') {
                                                return Text("\$" + ((state.totalValue - state.btcTotal) * valueState.value / 100).toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 32));
                                              } else {
                                                return Text("ERROR");
                                              }
                                            }
                                          )
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(5,17,0,0),
                                          child: Text("/ \$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Color(0x660B2940), fontSize: 18)),
                                        ),
                                      ]
                                    );
                                  } else if (state is StartupErrorState) {
                                    return Text("An Error has occurred: " + state.errorMessage, style: TextStyle(color: Colors.black));
                                  } else {
                                    return loadingTemplateWidget();
                                  }
                                }
                              )
                            )
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(35,10,0,0),
                                child: Text("To Target Coin", style: TextStyle(color: Colors.black)),
                              )
                            )
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(55,0,0,0),
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.white,
                                  value: buildDropdownValue(dropdownIndex),
                                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                                  iconSize: 24,
                                  elevation: 16,
                                  // style: Theme.of(context).textTheme.bodyText2,
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  underline: Container(
                                    height: 1,
                                    padding: EdgeInsets.only(right: 40),
                                    color: Colors.black,
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
                              )
                            )
                          ),
                          Flexible(
                            flex: 12,
                            fit: FlexFit.tight,
                            child: PercentSelection(preview, dropdownValue),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: displayHeight(context) * 0.04),
                              child: TextButton(
                                onPressed: () => {
                                  Navigator.pushReplacementNamed(context, '/buyportfolio', arguments: {'preview': preview})
                                },
                                child: Text("Buy Order", style: TextStyle(color: Colors.orange)),
                              ),
                            )
                          )
                        ],
                      )
                    )
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

class ValueState extends ChangeNotifier {
  double value = 0.0;
  double totalValueEstimated = 0.0;
  TextEditingController textField = TextEditingController();

  void valueChange(double _value) {
    value = _value;
    notifyListeners();
  }
}

class PercentSelection extends StatefulWidget {
  final bool preview;
  final String dropdownValue;
  PercentSelection(this.preview, this.dropdownValue);

  @override
  PercentSelectionState createState() => PercentSelectionState();
}

class PercentSelectionState extends State<PercentSelection> {
  TextEditingController textField = TextEditingController();
  double _value = 0.0;
  double totalValueEstimated = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(40,0,0,0),
              child: Text("Slide to adjust", style: TextStyle(color: Color(0X800B2940), fontSize: 14)),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20,0,20,0),
              child: SfSliderTheme(
                data: SfSliderThemeData(
                  activeTrackColor: Color(0XFF0B2940),
                  inactiveTrackColor: Color(0XFF0B2940),
                  tooltipBackgroundColor: Color(0XFF0B2940),
                  thumbColor: Color(0XFF0B2940),
                  activeTrackHeight: 3,
                  inactiveTrackHeight: 1,
                ),
                child: SfSlider(
                  min: 0.0,
                  max: 100.0,
                  value: _value,
                  interval: 100,
                  stepSize: 1,
                  showTicks: false,
                  showLabels: false,
                  enableTooltip: true,
                  onChanged: (dynamic value) {
                    Provider.of<ValueState>(context, listen: false).valueChange(value);
                    setState(() {
                      _value = value;
                      textField.text = _value.toStringAsFixed(1);
                    });
                  }
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  Container(
                    height: 20,
                    width: 55,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        )
                      ),
                      controller: textField,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onEditingComplete: () {
                        if (double.parse(textField.text) >= 0 && double.parse(textField.text) <= 100) {
                          Provider.of<ValueState>(context, listen: false).valueChange(double.parse(textField.text));
                          setState(() {
                            _value = double.parse(textField.text);
                          });
                        } else {
                          setState(() {
                            textField.text = _value.toStringAsFixed(1);
                          });
                        }
                      }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("%", style: TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                ]
              ),
            ),
          ),
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget> [
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(35,0,0,0),
              //       child: Text("FTX Total", style: TextStyle(color: Colors.black, fontSize: 14)),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(0,0,35,0),
              //       child: BlocConsumer<StartupBloc, StartupState>(
              //         listener: (context, state) {
              //           if (state is StartupErrorState) {
              //             debugPrint("An error occurred in sell_portfolio.dart - StartupErrorState");
              //           }
              //         },
              //         builder: (context, state) {
              //           if (state is StartupLoadedState) {
              //             return Consumer<ValueState>(
              //               builder: (context, valueState, child) {
              //                 return RichText(
              //                   text: TextSpan(
              //                     style: TextStyle(
              //                       fontSize: 14,
              //                       color: Colors.black,
              //                     ),
                                  
              //                     children: <TextSpan> [
              //                       TextSpan(text: "\$" + (state.totalValue * valueState.value / 100).toStringAsFixed(2)),
              //                       TextSpan(text: "  Usdt", style: TextStyle(color: Color(0X660B2940)))
              //                     ]
              //                   )
              //                 );
              //               }
              //             );
              //           } else if (state is StartupErrorState) {
              //             return Text("An Error occured: " + state.errorMessage);
              //           } else {
              //             return loadingTemplateWidget(20, 2);
              //           }
              //         }
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Padding(
                    padding: EdgeInsets.fromLTRB(35,0,0,0),
                    child: Text("Binance Total", style: TextStyle(color: Colors.black, fontSize: 14)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,35,0),
                    child: BlocConsumer<StartupBloc, StartupState>(
                      listener: (context, state) {
                        if (state is StartupErrorState) {
                          debugPrint("An error occurred in sell_portfolio.dart - StartupErrorState");
                        }
                      },
                      builder: (context, state) {
                        if (state is StartupLoadedState) {
                          return Consumer<ValueState>(
                            builder: (context, valueState, child) {
                              return RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  
                                  children: <TextSpan> [
                                    if(widget.dropdownValue == 'USDT')...[
                                      TextSpan(text: "\$" + ((state.totalValue - state.usdTotal) * valueState.value / 100).toStringAsFixed(2)),
                                    ] else if(widget.dropdownValue == 'BTC')...[
                                      TextSpan(text: "\$" + ((state.totalValue - state.btcTotal) * valueState.value / 100).toStringAsFixed(2)),
                                    ],
                                    TextSpan(text: "  Usdt", style: TextStyle(color: Color(0X660B2940)))
                                  ]
                                )
                              );
                            }
                          );
                        } else if (state is StartupErrorState) {
                          return Text("An Error occured: " + state.errorMessage);
                        } else {
                          return loadingTemplateWidget(20, 2);
                        }
                      }
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Padding(
                    padding: EdgeInsets.fromLTRB(35,0,0,0),
                    child: Text("Estimated Fees", style: TextStyle(color: Colors.black, fontSize: 14)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,35,0),
                    child: BlocConsumer<StartupBloc, StartupState>(
                      listener: (context, state) {
                        if (state is StartupErrorState) {
                          debugPrint("An error occurred in sell_portfolio.dart - StartupErrorState");
                        }
                      },
                      builder: (context, state) {
                        if (state is StartupLoadedState) {
                          return Consumer<ValueState>(
                            builder: (context, valueState, child) {
                              return RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  
                                  children: <TextSpan> [
                                    if(widget.dropdownValue == 'USDT')...[
                                      TextSpan(text: "\$" + ((state.totalValue - state.usdTotal) * valueState.value / 100000).toStringAsFixed(2)),
                                    ] else if(widget.dropdownValue == 'BTC')...[
                                      TextSpan(text: "\$" + ((state.totalValue - state.btcTotal) * valueState.value / 100000).toStringAsFixed(2)),
                                    ],
                                    TextSpan(text: "  Usdt", style: TextStyle(color: Color(0X660B2940)))
                                  ]
                                )
                              );
                            }
                          );
                        } else if (state is StartupErrorState) {
                          return Text("An Error occured: " + state.errorMessage);
                        } else {
                          return loadingTemplateWidget(20, 2);
                        }
                      }
                    ),
                  )
                ],
              ),
              SizedBox(height: 35),
            ]
          )
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: displayHeight(context) * 0.03),
              child: Container( /// ### Review Order button
                height: displayHeight(context) * 0.065,
                width: displayWidth(context) * 0.825,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xFF2197F2),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Review Order", style: TextStyle(color: Colors.white))
                      ),
                    ),
                    onTap: () => {
                      Navigator.pushNamed(context, '/sellportfolio2', arguments: {'value': _value, 'symbol': widget.dropdownValue, 'preview': widget.preview}),
                      // Navigator.pushNamed(context, '/hometest'),
                      
                    },
                  // ),
                  // elevation: 2,
                ),
              ),
            ),
          )
        ),
      ],
    );
  }
}