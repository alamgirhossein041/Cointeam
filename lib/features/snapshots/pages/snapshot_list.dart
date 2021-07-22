import 'dart:convert';

import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/snapshots/widgets/snapshot_list_tile.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/dummy_data.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        margin: mainCardMargin(),
        decoration: mainCardDecoration(),
        padding: scrollCardPadding(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: FutureBuilder(
                  future: getStorage(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return loadingTemplateWidget(1);
                      default:
                        if (!snapshot.hasError) {
                          if (snapshot.data != null) {
                            // log("There are " + snapshot.data.length.toString() + " snapshots");
                            return BlocConsumer<StartupBloc, StartupState>(
                                listener: (context, state) {
                              if (state is StartupErrorState) {
                                log('There is an error');
                              }
                            }, builder: (context, state) {
                              if (state is StartupLoadedState) {
                                log("state coinmap = " + state.coingeckoModelMap.toString());
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        // isAlwaysShown: true,
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
                                                      Navigator.pushNamed(
                                                        context,
                                                        '/snapshotlog',
                                                        arguments: {
                                                          'coinDataStructure':
                                                              snapshot
                                                                  .data[index]
                                                        },
                                                      )
                                                    },
                                                    child: SnapshotListTile(
                                                      id: (index + 1),
                                                      coinData:
                                                          snapshot.data[index],
                                                      coinMap: state.coingeckoModelMap,
                                                    ),
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
                              } else if (state is StartupLoadingState) {
                                return loadingTemplateWidget(1);
                              } else {
                                return Text('Error in snapshotlist.dart');
                              }
                            });
                          } else {
                            log(snapshot.toString());
                            // return errorTemplateWidget(
                            //     "You have no transaction snapshots.");
                            return Container();
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
          ],
        ),
      ),
    );
  }

  Future getStorage() async {
    var ready = await localStorage.ready;
    // await localStorage.setItem("portfolio", customVariableHere);
    var value = localStorage.getItem("portfolio");
    // log(value[0]['coins'].values.elementAt(1).toString());
    // return value;
    return dummyCoinList;
  }
}
