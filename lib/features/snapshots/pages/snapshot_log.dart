
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

class SnapshotLog extends StatefulWidget {

  @override
  SnapshotLogState createState() => SnapshotLogState();
}

class SnapshotLogState extends State<SnapshotLog> {
  final _scrollController = ScrollController();
  Map<String, dynamic> coinDataStructure = {};
  List<String> key = [];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments == null) {
      log("Arguments is null in snapshot_log.dart");
    } else {
      coinDataStructure = arguments['coinDataStructure'];
    }
    if(coinDataStructure['coins'] != null) {
      key = coinDataStructure['coins'].keys.toList();
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
                          behavior: HitTestBehavior.opaque,
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          onTap: () => {
                            Navigator.pop(context),
                          },
                        )
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Transaction Log", style: TextStyle(color: Colors.white)),
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
              flex: 18,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: displayWidth(context) * 0.97,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Color(0xFF36343E),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: <Widget> [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget> [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(30,0,0,0),
                                child: Text(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(coinDataStructure['timestamp'])), style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(30,10,0,0),
                                child: Text(DateFormat('hh:mm:ss a').format(DateTime.fromMillisecondsSinceEpoch(coinDataStructure['timestamp'])), style: TextStyle(fontSize: 14, color: Color(0x800B2940))),
                              ),
                            ),
                            Container(height: 15),
                          ]
                        )
                      ),
                      Flexible(
                        flex: 14,
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget> [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text("-----------------------------------------------", style: TextStyle(color: Color(0x330B2940)))
                            ),
                            Container(height: 20),
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
                                        padding: EdgeInsets.fromLTRB(0,0,0,30),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: <Widget> [
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: displayWidth(context) * 0.14),
                                                  // child: Text("Symbol", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                                  child: Container(),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  // child: Padding(
                                                  //   padding: EdgeInsets.only(left: 20),
                                                    child: Text("Quantity", style: TextStyle(color: Color(0x800B2940), fontSize: 14)),
                                                  // ),
                                                ),
                                                // child: Container(),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(right: 40),
                                                    child: Text(coinDataStructure['currency'], style: TextStyle(color: Color(0x800B2940), fontSize: 14))
                                                  ),
                                                )
                                              )
                                            ]
                                          )
                                        ),
                                      )
                                    ),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate((context, index) {
                                        Map<String, dynamic> text = coinDataStructure['coins'][key[index]];
                                            return Padding(
                                              padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                              child: Row(
                                                children: <Widget> [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Text(key[index].toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                                                    // child: Container(),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.tight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Align(
                                                      // alignment: Alignment.centerRight,
                                                        alignment: Alignment.centerRight,
                                                        // child: Padding(
                                                          // padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                                                          child: Text(text['quantity'].toStringAsFixed(8), style: TextStyle(fontSize: 14, color: Colors.black)),
                                                          // child: Text(999999999999.toStringAsFixed(8), style: TextStyle(fontSize: 15)),
                                                          // child: Builder(
                                                          //   builder: (context) {
                                                          //     // return Text("\$" + binanceModel[index].totalUsdValue.toStringAsFixed(2));
                                                          //     return Text("\$" + text);
                                                          //     // final condition = state.binanceGetPricesMap[binanceList[index] + symbol] != null;
                                                          //     // return condition ? Text("\$" + 
                                                          //       // (binanceModel.data[binanceList[index]].totalUsdValue * percentageValue).toStringAsFixed(2))
                                                          //       // : Text("No USDT Pair");
                                                          //   }
                                                          // ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 3,
                                                    fit: FlexFit.tight,
                                                    child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(right: displayWidth(context) * 0.1),
                                                        child: Text(text['value'].toStringAsFixed(2), style: TextStyle(fontSize: 15, color: Colors.black)),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                              ),
                                            );
                                      },
                                      childCount: (key.length),
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
                                        child: Text("TOTAL", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                                              child: Text(coinDataStructure['currency'] + " " +  coinDataStructure['total'].toStringAsFixed(2), style: TextStyle(color: Colors.black)),
                                        )
                                      )
                                    )
                                  ]
                                )
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
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.blue[200]),
                                          color: Color(0xFF2B3139),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("Done", style: TextStyle(color: Colors.white))
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
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}