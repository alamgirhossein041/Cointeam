import 'dart:convert';

import 'package:coinsnap/features/snapshots/widgets/snapshot_list_item.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:developer';

class SnapshotList extends StatefulWidget {
  @override
  SnapshotListState createState() => SnapshotListState();
}

class SnapshotListState extends State<SnapshotList> {
  final _scrollController = ScrollController();
  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  List _items = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snapshots'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2197F2),
        ),
        height: displayHeight(context),
        width: displayWidth(context),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 18,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: mainCardMargin(),
                  decoration: mainCardDecoration(),
                  padding: snapshotCardPadding(),
                  child: FutureBuilder(
                    future: getStorage(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          if (!snapshot.hasError) {
                            if (snapshot.data != null) {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                              color: Color(0x800B2940),
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Icon(Icons.swap_vert),
                                          SizedBox(width: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Scrollbar(
                                      controller: _scrollController,
                                      isAlwaysShown: true,
                                      thickness: 5,
                                      radius: Radius.circular(3),
                                      child: CustomScrollView(
                                        controller: _scrollController,
                                        slivers: <Widget>[
                                          SliverList(
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (context, index) {
                                                return GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () => {
                                                          log("Hi"),
                                                          Navigator.pushNamed(
                                                            context,
                                                            '/snapshotlog',
                                                            arguments: {
                                                              'coinDataStructure':
                                                                  snapshot.data[
                                                                      index]
                                                            },
                                                          )
                                                        },
                                                    child: SnapshotListItem(
                                                      id: (index + 1),
                                                      coinData:
                                                          snapshot.data[index],
                                                    )
                                                    // child: Padding(
                                                    //   padding: EdgeInsets.only(
                                                    //       bottom: displayHeight(
                                                    //               context) *
                                                    //           0.035),
                                                    //   child: Row(
                                                    //     children: <Widget>[
                                                    //       Container(width: 40),
                                                    //       Flexible(
                                                    //         flex: 1,
                                                    //         fit: FlexFit.tight,
                                                    //         child: Text(
                                                    //           "#" +
                                                    //               (index + 1)
                                                    //                   .toString(),
                                                    //           style: TextStyle(
                                                    //             color: primaryDark,
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //       Flexible(
                                                    //         flex: 3,
                                                    //         fit: FlexFit.tight,
                                                    //         // child: Text("#" + (index + 1).toString(), style: TextStyle(color: Color(0XFF0B2940))),
                                                    //         child: Container(),
                                                    //       ),
                                                    //       Flexible(
                                                    //         flex: 3,
                                                    //         fit: FlexFit.tight,
                                                    //         child: Padding(
                                                    //           padding:
                                                    //               EdgeInsets.only(
                                                    //                   right: 30),
                                                    //           child: Column(
                                                    //             crossAxisAlignment:
                                                    //                 CrossAxisAlignment
                                                    //                     .end,
                                                    //             children: <
                                                    //                 Widget>[
                                                    //               Text(
                                                    //                   DateFormat(
                                                    //                           "dd MMM yyyy")
                                                    //                       .format(DateTime.fromMillisecondsSinceEpoch(snapshot.data[index][
                                                    //                           'timestamp']')),'
                                                    //                   style: TextStyle(
                                                    //                       color: Color(
                                                    //                           0xFF0B2940),
                                                    //                       fontSize:
                                                    //                           14)),
                                                    //               SizedBox(
                                                    //                   height: 5),
                                                    //               Text(
                                                    //                   DateFormat(
                                                    //                           "h:mm a")
                                                    //                       .format(DateTime.fromMillisecondsSinceEpoch(snapshot.data[index][
                                                    //                           'timestamp']')),'
                                                    //                   style: TextStyle(
                                                    //                       color: Color(
                                                    //                           0x800B2940),
                                                    //                       fontSize:
                                                    //                           13)),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    );
                                              },
                                              childCount:
                                                  (snapshot.data.length),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              log(snapshot.toString());
                              return errorTemplateWidget(
                                  "You have no transaction snapshots.");
                            }
                          } else {
                            log("Something");
                            return errorTemplateWidget(
                                "An error has occurred in snapshot_list.dart  SnapshotList");
                          }
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getStorage() async {
    List<dynamic> dummyMap = [
      {
        "coins": {
          "BNB": {"quantity": 95.2, "value": 12.569256},
          "NEO": {"quantity": 95.2, "value": 12.569256},
          "TRX": {"quantity": 95.2, "value": 12.569256}
        },
        "currency": "USDT",
        "total": 45.651713,
        "timestamp": 1620738580285
      },
      {
        "coins": {
          "USDT": {"quantity": 0.000799, "value": 45.7543355}
        },
        "currency": "BTC",
        "total": 45.7543355,
        "timestamp": 1620798793883
      },
      {
        "coins": {
          "USDT": {"quantity": 0.000406, "value": 23.14507342}
        },
        "currency": "BTC",
        "total": 23.14507342,
        "timestamp": 1620805525045
      },
      {
        "coins": {
          "SHIB": {"quantity": 744937.0, "value": 21.55847678}
        },
        "currency": "USDT",
        "total": 21.55847678,
        "timestamp": 1620813201918
      },
      {
        "coins": {
          "XRP": {"quantity": 662213.0, "value": 19.22404339},
          "SHIB": {"quantity": 662213.0, "value": 19.22404339}
        },
        "currency": "USDT",
        "total": 43.18642339,
        "timestamp": 1620813331191
      },
      {
        "coins": {
          "XRP": {"quantity": 14.48, "value": 21.19872},
          "SHIB": {"quantity": 772092.0, "value": 22.44471444}
        },
        "currency": "USDT",
        "total": 43.64343444,
        "timestamp": 1620814453936
      },
      {
        "coins": {
          "BNB": {"quantity": 0.3683, "value": 136.447784}
        },
        "currency": "USDT",
        "total": 136.447784,
        "timestamp": 1623754999095
      },
      {
        "coins": {
          "BTC": {"quantity": 0.037891, "value": 1127.35841897}
        },
        "currency": "USDT",
        "total": 1127.35841897,
        "timestamp": 1624371972665
      },
      {
        "coins": {},
        "currency": "USDT",
        "total": 0.0,
        "timestamp": 1624934928986
      },
      {
        "coins": {},
        "currency": "USDT",
        "total": 0.0,
        "timestamp": 1624934928986
      },
      {
        "coins": {
          "ETH": {"quantity": 0.24144, "value": 505.1793984},
          "MATIC": {"quantity": 449.0, "value": 505.352027},
          "BTC": {"quantity": 0.014669, "value": 503.78523806},
          "AUD": {"quantity": 659.2, "value": 498.0256},
          "SHIB": {"quantity": 659.2, "value": 498.0256},
          "LIFEMOON": {"quantity": 659.2, "value": 498.0256},
          "DOGE": {"quantity": 659.2, "value": 498.0256},
        },
        "currency": "USDT",
        "total": 2012.34226346,
        "timestamp": 1624935141451
      },
      {
        "coins": {
          "USDT": {"quantity": 141.19140915, "value": 0.004023}
        },
        "currency": "BTC",
        "total": 141.19140915,
        "timestamp": 1624958729880
      },
      {
        "coins": {},
        "currency": "USDT",
        "total": 0.0,
        "timestamp": 1625625851453
      }
    ];

    var ready = await localStorage.ready;
    // await localStorage.setItem("portfolio", customVariableHere);
    var value = localStorage.getItem("portfolio");
    // log(value[0]['coins'].values.elementAt(1).toString());
    // return value;
    return dummyMap;
  }
}
