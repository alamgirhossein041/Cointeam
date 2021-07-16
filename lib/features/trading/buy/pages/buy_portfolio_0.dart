import 'dart:developer';

import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class BuyPortfolioScreenOne extends StatefulWidget {
  BuyPortfolioScreenOne({
    Key key
  }) : super(key: key);

  @override
  BuyPortfolioScreenOneState createState() => BuyPortfolioScreenOneState();
}

class BuyPortfolioScreenOneState extends State<BuyPortfolioScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy From Snapshot'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: primaryBlue,
          ),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: primaryBlue,
            body: Stack(
              children: <Widget> [
                TitleBar(title: "Buy from Snapshot"),
                Container(
                  margin: mainCardMargin(),
                  decoration: mainCardDecoration(),
                  padding: mainCardPaddingVertical(),
                  width: displayWidth(context),
                  child: Column(
                    children: <Widget> [
                      Text("Select a Snapshot to buy from"),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BuyFromSnapshotList(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          )
        )
      ),
    );
  }
}

class BuyFromSnapshotList extends StatefulWidget {
  const BuyFromSnapshotList({
    Key key
  }) : super(key: key);

  @override
  BuyFromSnapshotListState createState() => BuyFromSnapshotListState();
}

class BuyFromSnapshotListState extends State<BuyFromSnapshotList> {
  final _scrollController = ScrollController();
  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      child: FutureBuilder(
        future: getStorage(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
            if (!snapshot.hasError) {
              if(snapshot.data != null) {
                return Column(
                  children: <Widget> [
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: EdgeInsets.only(top: displayHeight(context) * 0.035),
                        child: Scrollbar(
                          controller: _scrollController,
                          isAlwaysShown: true,
                          thickness: 5,
                          child: CustomScrollView(
                            controller: _scrollController,
                            slivers: <Widget> [
                              // SliverToBoxAdapter(
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,0,30),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget> [
                                        Text("Date", style: TextStyle(color: Color(0x800B2940), fontSize: 14)),
                                        SizedBox(width: 20),
                                        Icon(Icons.swap_vert),
                                        SizedBox(width: 20),
                                      ]
                                    )
                                  ),
                                )
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate((context, index) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => {
                                      Navigator.pushNamed(context, '/buyportfolio2', arguments: {'coinDataStructure': snapshot.data[index]})
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                      child: Row(
                                        children: <Widget> [
                                          // Flexible(
                                          //   flex: 1,
                                          //   fit: FlexFit.tight,
                                          //   child: Container(),
                                          // ),
                                          Container(width: 40),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Text("#" + (index + 1).toString(), style: TextStyle(color: Color(0XFF0B2940))),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            // child: Text("#" + (index + 1).toString(), style: TextStyle(color: Color(0XFF0B2940))),
                                            child: Container(),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: EdgeInsets.only(right: 30),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget> [
                                                  Text(DateFormat("dd MMM yyyy").format(DateTime.fromMillisecondsSinceEpoch(snapshot.data[index]['timestamp'])), style: TextStyle(color: Color(0xFF0B2940), fontSize: 14)),
                                                  SizedBox(height: 5),
                                                  Text(DateFormat("h:mm a").format(DateTime.fromMillisecondsSinceEpoch(snapshot.data[index]['timestamp'])), style: TextStyle(color: Color(0x800B2940), fontSize: 13)),
                                                ]
                                              )
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                  );
                                },
                                childCount: (snapshot.data.length),
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                  ]
                );
              } else {
                log(snapshot.toString());
                return errorTemplateWidget("You have no transaction snapshots.");
              }
            } else {
              log("Something");
              return errorTemplateWidget("Help");
            }
          }
        }
      ),
    );
  }
  Future getStorage() async {
    var ready = await localStorage.ready;
    var value = localStorage.getItem("portfolio");
    log(value.toString());
    return value;
  }
}