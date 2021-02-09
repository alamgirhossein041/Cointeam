import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/test/testjson/test_crypto_json.dart';
import 'package:coinsnap/ui/drawer/drawer.dart';
import 'package:coinsnap/ui/template/portfolio_list_view.dart';
import 'package:coinsnap/ui/template/price_container.dart';
import 'package:coinsnap/ui/template/small/card/portfolio_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

class PortfolioBuilderView extends StatefulWidget {
  PortfolioBuilderView({Key key}) : super(key: key);

  @override
  PortfolioBuilderState createState() => PortfolioBuilderState();
}

class PortfolioBuilderState extends State<PortfolioBuilderView> {

  final firestoreInstance = FirebaseFirestore.instance;
  var firestoreUser = FirebaseFirestore.instance.collection('User');
  var firebaseAuth = FirebaseAuth.instance;

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
    var cryptoData = CryptoData.getData;
    return Scaffold(
      key: scaffoldState,
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: Column(
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                IconButton(
                  icon: Icon(Icons.menu,
                    color: Colors.white,
                    size: 35),
                  onPressed: () {
                    scaffoldState.currentState.openDrawer();
                  }
                ),
                Text(
                  "Portfolio",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings,
                    color: Colors.white,
                    size: 35),
                  onPressed: () {
                    scaffoldState.currentState.openDrawer();
                  }
                ),
              ]
            ),
            SizedBox(height: displayHeight(context) * 0.025),
            PriceContainer(),
            SizedBox(height: displayHeight(context) * 0.32),
            Container(
              child: Column (
                children: <Widget> [
                  Container(
                    child: SizedBox(
                      height: displayHeight(context) * 0.35,
                      width: displayWidth(context),
                      child: ListView.builder(
                        itemCount: cryptoData.length,
                        itemBuilder: (context, index) {
                          return PortfolioListTile(cryptoData, index);
                        },
                      )
                    )
                  )
                ]
              )
            ),
            // Text("Hello", style: TextStyle(color: Colors.white)),
          ]
        ),
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topRight,
      //       end: Alignment.bottomLeft,
      //       colors: [appPink, Colors.blue],
      //       // colors: [darkRedColor, lightRedColor]
      //     ),
      //   ),
      //   child: Column(
      //     children: <Widget> [
      //       SizedBox(height: displayHeight(context) * 0.05),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: <Widget> [
      //           IconButton(
      //             icon: Icon(Icons.menu,
      //               color: Colors.black,
      //               size: 35),
      //             onPressed: () {
      //               scaffoldState.currentState.openDrawer();
      //             }
      //           ),
      //         ],
      //       ),
      //     Text("Portfolio 1", style: TextStyle(fontSize: 20)),
      //     // SizedBox(height: displayHeight(context) * 0.1),
      //     SizedBox(
      //       height: displayHeight(context) * 0.5,
      //       child: ListView(
      //         children: <Widget> [
      //           ListTile(title: Text("Coin1")),
      //           ListTile(title: Text("Coin2")),
      //           ListTile(title: Text("Coin3")),
      //           ListTile(title: Text("Coin4")),
      //           ListTile(title: Text("Coin5")),
      //           ListTile(title: Text("Coin6")),
      //           ListTile(title: Text("Coin7")),
      //           ListTile(title: Text("Coin8")),
      //           ListTile(title: Text("Coin9")),
      //           ListTile(title: Text("Coin10")),
      //         ],
      //       ),
      //     ),
      //     SizedBox(height: displayHeight(context) * 0.1),
      //     ElevatedButton(
      //       child: Text("Test Add To Firestore"),
      //       onPressed: () {
      //           /// firestoreInstance.collection("User").document('Snapshot-1').add(
      //           firestoreUser.add({'Something': 'something', 'uid': firebaseAuth.currentUser.uid.toString()})
      //             // {
      //             //   "coin" : "BTC",
      //             //   "age" : 50,
      //             //   "email" : "example@example.com",
      //             //   "address" : {
      //             //     "street" : "street 24",
      //             //     "city" : "new york"
      //             //   }
      //             // })
      //             .then((value){
      //               log(value.id);
      //             });
      //       }
      //     ),
      //     ElevatedButton(
      //       child: Text("Return to main"),
      //       onPressed: () {
      //         Navigator.pushNamed(context, '/home');
      //       }
      //     )
      //   ],
      // ),
      )
    );
  }
}