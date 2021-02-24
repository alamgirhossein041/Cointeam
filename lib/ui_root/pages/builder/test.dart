import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_bloc.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_event.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_state.dart';
import 'package:coinsnap/data/model/internal/coin_data/chart/crypto_compare.dart';
import 'package:coinsnap/data/repository/internal/coin_data/chart/crypto_compare.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui_root/drawer/drawer.dart';
import 'package:coinsnap/ui_root/template/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class TestView extends StatefulWidget {
  TestView({Key key}) : super(key: key);

  @override
  TestState createState() => TestState();
}

class TestState extends State<TestView> {
  final firestoreInstance = FirebaseFirestore.instance;
  // var firebaseAuth = FirebaseAuth.instance;

  CryptoCompareRepositoryImpl cryptoCompareRepository =
      CryptoCompareRepositoryImpl();

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
    // getTotalValueBloc = BlocProvider.of<GetTotalValueBloc>(context);
    // getTotalValueBloc.add(FetchGetTotalValueEvent());
  }

  @override
  void didChangeDependencies() {
    log("PRINT ME TWICE");
    BlocProvider.of<FirestoreGetUserDataBloc>(context)
        .add(FetchFirestoreGetUserDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldState,
        drawer: MyDrawer(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [appPink, Colors.blue],
              // colors: [darkRedColor, lightRedColor]
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: displayHeight(context) * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.menu, color: Colors.black, size: 35),
                      onPressed: () {
                        scaffoldState.currentState.openDrawer();
                      }),
                ],
              ),
              Text("Portfolio 9", style: TextStyle(fontSize: 20)),
              Text("Not Saved", style: TextStyle(fontSize: 15)),
              // SizedBox(height: displayHeight(context) * 0.1),
              SizedBox(
                height: displayHeight(context) * 0.4,
                child: ListView(
                  children: <Widget>[
                    ListTile(title: Text("Coin1")),
                    ListTile(title: Text("Coin2")),
                    ListTile(title: Text("Coin3")),
                    ListTile(title: Text("Coin4")),
                    ListTile(title: Text("Coin5")),
                  ],
                ),
              ),
              BlocListener<FirestoreGetUserDataBloc,
                  FirestoreGetUserDataState>(listener: (context, state) {
                if (state is FirestoreGetUserDataErrorState) {
                  log("error in FirestoreGetUserDataErrorState in text.dart");
                }
              }, child: BlocBuilder<FirestoreGetUserDataBloc,
                      FirestoreGetUserDataState>(

                  /// Both bloc types to be built (refactor existing controllers)
                  builder: (context, state) {
                if (state is FirestoreGetUserDataInitialState) {
                  log("FirestoreGetUserDataInitialState");
                  return Text("InitialLoadingState");
                } else if (state is FirestoreGetUserDataLoadingState) {
                  log("FirestoreGetUserDataLoadingState");
                  // return buildLoadingTemplate();
                  // return buildGetTotalValue(tmpTotalValue, tmpBtcSpecial);
                  return Text("Loading State");
                } else if (state is FirestoreGetUserDataLoadedState) {
                  log("FirestoreGetUserDataLoadedState");
                  // tmpTotalValue = state.totalValue;
                  // tmpBtcSpecial = state.btcSpecial;
                  var tmp = state.portfolioMap;
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text(tmp.toString()),
                        // Text(state.btcSpecial),
                      ],
                    ),
                    // child: Row(
                    //   children: <Widget> [
                    //     // SizedBox(width: displayWidth(context) * 0.1),
                    //     buildGetTotalValue(state.totalValue, state.btcSpecial),
                    //     Column( /// refactor into a function like buildGetTotalValue
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       children: <Widget> [
                    //         buildTicker(context, tmpBtcSpecial),
                    //       ]
                    //     ),
                    //   ]
                    // ),
                  );
                } else if (state is FirestoreGetUserDataErrorState) {
                  log("FirestoreGetUserDataErrorState");
                  return buildErrorTemplate(state.errorMessage);
                } else {
                  return null;
                }
              })),
              SizedBox(height: displayHeight(context) * 0.1),
              ElevatedButton(
                  child: Text("Test Add To Firestore"),
                  onPressed: () {
                    var firebaseUser = FirebaseAuth.instance.currentUser;
                    firestoreInstance
                        .collection("Users")
                        .doc(firebaseUser.uid)
                        .set({
                      "ExchangeLink": {
                        "BinanceAPI": {
                          "api":
                              "cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU",
                          "sapi":
                              "mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD",
                        }
                      },
                      "Friends": {
                        "UserID": "Sudo",
                        "UserIDZ": "Max",
                      },
                      "Portfolio": {
                        "Portfolio1Pct": {
                          "BTC": 0.55,
                          "ETH": 0.32,
                          "XRP": 0.13,
                          "SoldUSDT": 10000
                        },
                        "Portfolio1Abs": {
                          "BTC": 5500,
                          "ETH": 3200,
                          "XRP": 1300,
                        }
                      },
                    }).then((_) {
                      print("Success!");
                      log("Success!");
                    });

                    /// firestoreInstance.collection("User").document('Snapshot-1').add(
                    // firestoreUser.add({'Something': 'something', 'uid': firebaseAuth.currentUser.uid.toString()})
                    // {
                    //   "coin" : "BTC",
                    //   "age" : 50,
                    //   "email" : "example@example.com",
                    //   "address" : {
                    //     "street" : "street 24",
                    //     "city" : "new york"
                    //   }
                    // })
                    // .then((value){
                    //   log(value.id);
                    // });
                  }),
              ElevatedButton(
                  child: Text("Test Chart Data"),
                  onPressed: () {
                    cryptoCompareRepository.getHourlyCryptoCompare();
                  }),
              ElevatedButton(child: Text("Test"), onPressed: () {})
            ],
          ),
        ));
  }
}
