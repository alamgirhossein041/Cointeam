import 'dart:developer';

import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:localstorage/localstorage.dart';

class SnapshotList extends StatefulWidget {

  @override
  SnapshotListState createState() => SnapshotListState();
}

class SnapshotListState extends State<SnapshotList> {
  final _scrollController = ScrollController();
  final LocalStorage localStorage = LocalStorage("coinstreetapp");
  // var helloWorld;

  @override
  void initState() { 
    super.initState();
    // helloWorld = getStorage();
  }
  
  @override
  Widget build(BuildContext context) {
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
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          onTap: () => {
                            // SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context),
                              // Navigator.pushNamed(context, '/home'),
                              // setState(() {});
                            // }),
                          },
                        )
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Snapshots", style: TextStyle(color: Colors.white)),
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
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
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
                                          SliverList(
                                            delegate: SliverChildBuilderDelegate((context, index) {
                                              return GestureDetector(
                                                child: Padding(
                                                  padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                                  child: Row(
                                                    children: <Widget> [
                                                      Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Container(),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        fit: FlexFit.tight,
                                                        child: Text("#" + (index + 1).toString(), style: TextStyle(color: Color(0XFF0B2940))),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        fit: FlexFit.tight,
                                                        child: Text("Date: 10 May 2021", style: TextStyle(color: Color(0XFF0B2940), fontSize: 15)),
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
                            return errorTemplateWidget("An error has occured");
                          }
                        } else {
                          log("Something");
                          return errorTemplateWidget("Help");
                        }
                      }
                    }
                  ),
                )
              )
            )
          ]
        )
      )
    );
  }
  Future getStorage() async {
    var ready = await localStorage.ready;
    var value = localStorage.getItem("portfolio");
    log(value.toString());
    return value;
  }
}