import 'dart:developer';

import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BuyPortfolioScreenTwo extends StatefulWidget {
  BuyPortfolioScreenTwo({Key key}) : super(key: key);

  @override
  BuyPortfolioScreenTwoState createState() => BuyPortfolioScreenTwoState();
}

class BuyPortfolioScreenTwoState extends State<BuyPortfolioScreenTwo> {
  final _scrollController = ScrollController();
  Map<String, dynamic> coinDataStructure = {};
  List<String> coinDataKey = [];
  // TextEditingController textField = TextEditingController(text: "0.00");
  TextEditingController textField = TextEditingController();
  // textField.text = 0.00;
  int pageIndex = 0;
  double usdBalance = 0.0;

  @override
  void initState() { 
    super.initState();
    textField.text = "0.00";
  }

  @override
  Widget build(BuildContext context) {
     log("Textfield is: " + textField.text);
    // log(textField.text.toString());    // textField.text = "0.00";
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments == null) {
      log("Arguments is null in snapshot_log.dart");
    } else {
      coinDataStructure = arguments['coinDataStructure'];
      pageIndex = arguments['index'];
      // log(coinDataStructure.toString());
    }
    if(coinDataStructure['coins'] != null) {
      coinDataKey = coinDataStructure['coins'].keys.toList();
      log("Length is: " + coinDataKey.length.toString());
    }
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(title: Text('Buy from Snapshot')),
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Buy from Snapshot"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                // padding: mainCardPaddingVertical(),
                padding: EdgeInsets.only(top: 25),
                width: displayWidth(context),
                // child: Column(
                //   children: <Widget> [
                //     Flexible(
                //       flex: 18,
                //       fit: FlexFit.tight,
                //       child: Align(
                //         alignment: Alignment.center,
                //         child: Container(
                //           width: displayWidth(context) * 0.97,
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             // color: Color(0xFF36343E),
                //             borderRadius: BorderRadius.all(Radius.circular(20))
                //           ),
                          child: Column(
                            children: <Widget> [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget> [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget> [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(30,0,0,0),
                                          child: Text('#' + pageIndex.toString()),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(30,0,0,0),
                                          // child: Text("12 Coins")
                                          child: Text(coinDataKey.length.toString() + " Coins", style: TextStyle(color: Color(0x800B2940))),
                                        ),
                                      ]
                                    ),
                                    Column(
                                      children: <Widget> [
                                        // Flexible(
                                        //   flex: 2,
                                        //   fit: FlexFit.tight,
                                          // child: Column(
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget> [
                                            // Align(
                                            //   alignment: Alignment.centerLeft,
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,30,0),
                                                // child: Text(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(coinDataStructure['timestamp'])), style: TextStyle(color: Colors.black)),
                                                child: Text(DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(coinDataStructure['timestamp'])), style: TextStyle(color: Colors.black)),
                                              ),
                                            // ),
                                            // Align(
                                            //   alignment: Alignment.centerRight,
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,30,0),
                                                // child: Text(DateFormat('hh:mm:ss a').format(DateTime.fromMillisecondsSinceEpoch(coinDataStructure['timestamp'])), style: TextStyle(fontSize: 14, color: Color(0x800B2940))),
                                                child: Text(DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(coinDataStructure['timestamp'])), style: TextStyle(fontSize: 14, color: Color(0x800B2940))),
                                              // ),
                                            ),
                                            // Container(height: 15),
                                          ]
                                        )
                                        // ),
                                      ]
                                    ),
                                  ]
                                ),
                              ),
                              Flexible(
                                flex: 20,
                                fit: FlexFit.tight,
                                child: Column(
                                  children: <Widget> [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text("-----------------------------------------------", style: TextStyle(color: Color(0x330B2940)))
                                    ),
                                    // Container(height: 20),
                                    Flexible(
                                      flex: 6,
                                      fit: FlexFit.tight,
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        // isAlwaysShown: true,
                                        thickness: 5,
                                        child: CustomScrollView(
                                          controller: _scrollController,
                                          slivers: <Widget> [
                                            // SliverToBoxAdapter(
                                            //   child: Padding(
                                            //     padding: EdgeInsets.fromLTRB(0,0,0,30),
                                            //     child: Align(
                                            //       alignment: Alignment.center,
                                            //       child: Row(
                                            //         children: <Widget> [
                                            //           Flexible(
                                            //             flex: 3,
                                            //             fit: FlexFit.tight,
                                            //             child: Padding(
                                            //               padding: EdgeInsets.only(left: displayWidth(context) * 0.14),
                                            //               // child: Text("Symbol", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                            //               child: Container(),
                                            //             ),
                                            //           ),
                                            //           Flexible(
                                            //             flex: 3,
                                            //             fit: FlexFit.tight,
                                            //             child: Align(
                                            //               alignment: Alignment.centerLeft,
                                            //               // child: Padding(
                                            //               //   padding: EdgeInsets.only(left: 20),
                                            //                 child: Text("Quantity", style: TextStyle(color: Color(0x800B2940), fontSize: 14)),
                                            //               // ),
                                            //             ),
                                            //             // child: Container(),
                                            //           ),
                                            //           Flexible(
                                            //             flex: 3,
                                            //             fit: FlexFit.tight,
                                            //             child: Align(
                                            //               alignment: Alignment.centerRight,
                                            //               child: Padding(
                                            //                 padding: EdgeInsets.only(right: 40),
                                            //                 child: Text(coinDataStructure['currency'], style: TextStyle(color: Color(0x800B2940), fontSize: 14))
                                            //               ),
                                            //             )
                                            //           )
                                            //         ]
                                            //       )
                                            //     ),
                                            //   )
                                            // ),
                                            SliverList(
                                              delegate: SliverChildBuilderDelegate((context, index) {
                                                  return Container(
                                                    height: displayHeight(context) * 0.075,
                                                    // child: Padding(
                                                      // padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                                      child: Row(
                                                        children: <Widget> [
                                                          Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: Container(),
                                                          ),
                                                          Flexible(
                                                            flex: 2,
                                                            fit: FlexFit.tight,
                                                            child: Text(coinDataKey[index].toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                                                            // child: Container(),
                                                          ),
                                                          Flexible(
                                                            flex: 3,
                                                            fit: FlexFit.tight,
                                                            child: Container(),
                                                          ),
                                                          // Flexible(
                                                          //   flex: 3,
                                                          //   fit: FlexFit.tight,
                                                          //   child: Padding(
                                                          //     padding: EdgeInsets.only(left: 10),
                                                          //     child: Align(
                                                          //     // alignment: Alignment.centerRight,
                                                          //       alignment: Alignment.centerLeft,
                                                          //       // child: Padding(
                                                          //         // padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                                                          //         child: Text(coinDataStructure['coins'][coinDataKey[index]]['quantity'].toStringAsFixed(8), style: TextStyle(fontSize: 14, color: Colors.black)),
                                                          //         // child: Text(999999999999.toStringAsFixed(8), style: TextStyle(fontSize: 15)),
                                                          //         // child: Builder(
                                                          //         //   builder: (context) {
                                                          //         //     // return Text("\$" + binanceModel[index].totalUsdValue.toStringAsFixed(2));
                                                          //         //     return Text("\$" + text);
                                                          //         //     // final condition = state.binanceGetPricesMap[binanceList[index] + symbol] != null;
                                                          //         //     // return condition ? Text("\$" + 
                                                          //         //       // (binanceModel.data[binanceList[index]].totalUsdValue * percentageValue).toStringAsFixed(2))
                                                          //         //       // : Text("No USDT Pair");
                                                          //         //   }
                                                          //         // ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          /// 22nd workload
                                                          // Flexible(
                                                          //   flex: 2,
                                                          //   fit: FlexFit.tight,
                                                          //   child: Align(
                                                          //     alignment: Alignment.centerRight,
                                                          //     child: Padding(
                                                          //       padding: EdgeInsets.only(right: 10),
                                                          //       child: Column(
                                                          //         crossAxisAlignment: CrossAxisAlignment.end,
                                                          //         mainAxisAlignment: MainAxisAlignment.center,
                                                          //         children: <Widget> [
                                                          //           // Flexible(
                                                          //           //   fit: FlexFit.tight,
                                                          //           //   flex: 1,
                                                          //             Text("\$" + coinDataStructure['coins'][coinDataKey[index]]['value'].toStringAsFixed(2), style: TextStyle(fontSize: 14, color: Colors.black)),
                                                          //           // ),
                                                          //           // Flexible(
                                                          //             // fit: FlexFit.tight,
                                                          //             // flex: 1,
                                                          //             Text((coinDataStructure['coins'][coinDataKey[index]]['value']/coinDataStructure['total'] * 100).toStringAsFixed(1) + "%", style: TextStyle(fontSize: 14, color: primaryBlue)),
                                                          //           // ),
                                                          //         ],
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          Flexible(
                                                            flex: 2,
                                                            fit: FlexFit.tight,
                                                            child: Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 10),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget> [
                                                                    // Flexible(
                                                                    //   fit: FlexFit.tight,
                                                                    //   flex: 1,
                                                                      Text("\$" + (coinDataStructure['coins'][coinDataKey[index]]['value']/coinDataStructure['total'] * double.parse(textField.text)).toStringAsFixed(2), style: TextStyle(fontSize: 14, color: Colors.black)),
                                                                    // ),
                                                                    // Flexible(
                                                                      // fit: FlexFit.tight,
                                                                      // flex: 1,
                                                                      Text((coinDataStructure['coins'][coinDataKey[index]]['value']/coinDataStructure['total'] * 100).toStringAsFixed(1) + "%", style: TextStyle(fontSize: 14, color: primaryBlue)),
                                                                    // ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          /// 22nd workload
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            flex: 1,
                                                            child: GestureDetector(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(right: 15),
                                                                child: Icon(Icons.close, color: Color(0X660B2940), size: 18),
                                                              ),
                                                              onTap: () => {
                                                                log("Give an error: 'Pro Only'"),
                                                                // setState(() {}),
                                                                /// ### Remove from state.coinListReceived??? Make a new lsit for it, then remove it, then setState refresh ### /// 
                                                              },
                                                            ), /// ### Todo: Icon
                                                          )
                                                        ]
                                                      ),
                                                    // ),
                                                  );
                                                },
                                                childCount: (coinDataKey.length),
                                              ),
                                            ),
                                          ]
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text("-----------------------------------------------", style: TextStyle(color: Color(0x330B2940)))
                                    ),
                                    Flexible(
                                      flex: 3,
                                      fit: FlexFit.tight,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget> [
                                            Flexible(
                                              fit: FlexFit.tight,
                                              flex: 2,
                                              child: Row(
                                                children: <Widget> [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 30),
                                                      child: Text("To Spend", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                                                        child: BlocBuilder<StartupBloc, StartupState>(
                                                          builder: (context, state) {
                                                            if (state is StartupLoadedState) {
                                                              usdBalance = state.usdTotal ?? 0.0;
                                                              // return Text('\$' + state.usdTotal.toStringAsFixed(2));
                                                              return TextFormField(
                                                                style: TextStyle(color: Colors.black, fontSize: 16),
                                                                textAlign: TextAlign.end,
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
                                                                  setState(() {
                                                                    if (double.parse(textField.text) > state.usdTotal) {
                                                                      textField.text = state.usdTotal.toStringAsFixed(2);
                                                                    }
                                                                  });
                                                                  
                                                                  // } else {
                                                                  //   setState(() {
                                                                  //     textField.text = _value.toStringAsFixed(1);
                                                                  //   });
                                                                }
                                                              );
                                                            } else if (state is StartupErrorState) {
                                                              return Text("An Error has occurred in Binance");
                                                            } else {
                                                              return loadingTemplateWidget();
                                                            }
                                                          }
                                                        ),
                                                      ),
                                                    )
                                                  )
                                                ]
                                              ),
                                            ),
                                            Flexible(
                                              fit: FlexFit.tight,
                                              flex: 1,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget> [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 30),
                                                      child: Text("Available:", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                                                      alignment: Alignment.topRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(right: 30),
                                                            // child: Text(coinDataStructure['currency'] + " " +  coinDataStructure['total'].toStringAsFixed(2), style: TextStyle(color: Colors.black)),
                                                        // child: RichText(
                                                        //   text: TextSpan(
                                                        //     text: '\$' + coinDataStructure['total'].toStringAsFixed(2),
                                                        //     style: TextStyle(color: Colors.black),
                                                        //     children: <TextSpan> [
                                                        //       TextSpan(text: '\nstuff', style: TextStyle(color: Colors.black)),
                                                        //     ]
                                                        //   ),
                                                        // ),
                                                        // child: Text('\$' + coinDataStructure['total'].toStringAsFixed(2) +
                                                        //   '\n' + coinDataStructure['currency'])
                                                        child: BlocBuilder<StartupBloc, StartupState>(
                                                          builder: (context, state) {
                                                            if (state is StartupLoadedState) {
                                                              // return Text('\$' + state.usdTotal.toStringAsFixed(2));
                                                              return Text('\$' + state.usdTotal.toStringAsFixed(2));
                                                            } else if (state is StartupErrorState) {
                                                              return Text("An Error has occurred in Binance");
                                                            } else {
                                                              return loadingTemplateWidget();
                                                            }
                                                          }
                                                        ),
                                                        // ),Text('\$' + state.usdTotal //2)
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container( /// ### Edit button
                                          height: displayHeight(context) * 0.055,
                                          width: displayWidth(context) * 0.35,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: Colors.blue[200]),
                                                  color: Color(0xFF2B3139),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Review Order", style: TextStyle(color: Colors.white))
                                                ),
                                              ),
                                              onTap: () => {
                                                Navigator.pushNamed(context, '/buyportfolio3', arguments: {'coinDataStructure': coinDataStructure, 'toSpend': textField.text, 'usdBalance': usdBalance})
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
                                ),
                              ),
                            ]
                          ),
                  //       ),
                  //     ),
                  //   ),
                  // ]
                // )
              )
            ]
          )
        )
      )
    );
  }
}