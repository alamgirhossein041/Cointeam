import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/data/model/internal/coin_data/chart/crypto_compare.dart';
import 'package:coinsnap/data/repository/internal/coin_data/chart/crypto_compare.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui_root/drawer/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

class TestView extends StatefulWidget {
  TestView({Key key}) : super(key: key);

  @override
  TestState createState() => TestState();
}

class TestState extends State<TestView> {

  final firestoreInstance = FirebaseFirestore.instance;
  var firestoreUser = FirebaseFirestore.instance.collection('User');
  var firebaseAuth = FirebaseAuth.instance;

  CryptoCompareRepositoryImpl cryptoCompareRepository = CryptoCompareRepositoryImpl();

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
    // getTotalValueBloc = BlocProvider.of<GetTotalValueBloc>(context);
    // getTotalValueBloc.add(FetchGetTotalValueEvent());
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
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                IconButton(
                  icon: Icon(Icons.menu,
                    color: Colors.black,
                    size: 35),
                  onPressed: () {
                    scaffoldState.currentState.openDrawer();
                  }
                ),
              ],
            ),
          Text("Portfolio 9", style: TextStyle(fontSize: 20)),
          Text("Not Saved", style: TextStyle(fontSize: 15)),
          // SizedBox(height: displayHeight(context) * 0.1),
          SizedBox(
            height: displayHeight(context) * 0.5,
            child: ListView(
              children: <Widget> [
                ListTile(title: Text("Coin1")),
                ListTile(title: Text("Coin2")),
                ListTile(title: Text("Coin3")),
                ListTile(title: Text("Coin4")),
                ListTile(title: Text("Coin5")),
                ListTile(title: Text("Coin6")),
                ListTile(title: Text("Coin7")),
                ListTile(title: Text("Coin8")),
                ListTile(title: Text("Coin9")),
                ListTile(title: Text("Coin10")),
                ListTile()
              ],
            ),
          ),
          SizedBox(height: displayHeight(context) * 0.1),
          ElevatedButton(
            child: Text("Test Add To Firestore"),
            onPressed: () {
                /// firestoreInstance.collection("User").document('Snapshot-1').add(
                firestoreUser.add({'Something': 'something', 'uid': firebaseAuth.currentUser.uid.toString()})
                  // {
                  //   "coin" : "BTC",
                  //   "age" : 50,
                  //   "email" : "example@example.com",
                  //   "address" : {
                  //     "street" : "street 24",
                  //     "city" : "new york"
                  //   }
                  // })
                  .then((value){
                    log(value.id);
                  });
            }
          ),
          ElevatedButton(
            child: Text("Test Chart Data"),
            onPressed: () {
              cryptoCompareRepository.getHourlyCryptoCompare();
            }
          ),
          ElevatedButton(
            child: Text("Return to main"),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            }
          )
        ],
      ),
      )
    );
  }
}