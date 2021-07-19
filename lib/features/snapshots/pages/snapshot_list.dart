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
                                                            snapshot.data[index]
                                                      },
                                                    )
                                                  },
                                                  child: SnapshotListItem(
                                                    id: (index + 1),
                                                    coinData: snapshot.data[index],
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
                                                  //                           'timestamp'])),
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
                                                  //                           'timestamp'])),
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
                            return errorTemplateWidget("An error has occurred in snapshot_list.dart  SnapshotList");
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
    var ready = await localStorage.ready;
    // await localStorage.setItem("portfolio", customVariableHere);
    var value = localStorage.getItem("portfolio");
    log(value.toString());
    return value;
    // return _items;
  }
}