import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/test/testjson/test_crypto_json.dart';
import 'package:coinsnap/ui_root/drawer/drawer.dart';
import 'package:coinsnap/ui_root/template/portfolio_list_view.dart';
import 'package:coinsnap/ui_root/template/price_container_no_icon.dart';
import 'package:coinsnap/ui_root/template/small/card/portfolio_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'dart:developer';

class PortfolioBuilderView extends StatefulWidget {
  PortfolioBuilderView({Key key}) : super(key: key);

  @override
  PortfolioBuilderState createState() => PortfolioBuilderState();
  
}

class PortfolioBuilderState extends State<PortfolioBuilderView> {

  Map<String, dynamic> added = {};
  String currentText = "";
  Map<String, dynamic> toFirestore = {};

  // GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final List<GlobalObjectKey<AutoCompleteTextFieldState<String>>> formKeyList = List.generate(10, (index) => GlobalObjectKey<AutoCompleteTextFieldState<String>>(index));
  /// https://stackoverflow.com/questions/49862572/multiple-widgets-used-the-same-globalkey bottom suggestion

  Map<int, dynamic> coinTicker = {};
  List<SimpleAutoCompleteTextField> textField = [];
  bool showWhichErrorText = false;
  int i = 0, k = 0;

  PortfolioBuilderState() {
    textField.add(SimpleAutoCompleteTextField(
      key: formKeyList[i],
      // decoration: InputDecoration(errorText: "Beans"),
      decoration: InputDecoration(helperText: "Insert a coin"),
      controller: TextEditingController(text: currentText),
      suggestions: suggestions,
      textChanged: (text) => currentText = text,
      clearOnSubmit: false,
      textSubmitted: (text) => setState(() {
        if (text != "") {
          added[text] = 10.0;
          coinTicker[k] = text;
          k++;
          }
        }),
      ),
      // textSubmitted: (text) => setState(() {
      // }),
    );
  }

  List<String> suggestions = [
    "Bitcoin",
    "Ethereum",
    "Ripple",
    "Bitcoin Cash",
    "USDT",
    "Binance Coin",
    "Polkadot",
    "Cardano",
    "Litecoin",
    "Chainlink",
    "Stellar",
    "USDC",
    "Dogecoin",
    "Wrapped Bitcoin",
    "Uniswap",
    "Aave",
    "Cosmos",
    "Monero",
    "EOS",
    "Bitcoin SV",
    "TRON",
    "NEM",
    "IOTA",
    "THETA",
    "Tezos",
    "VeChain",
    "Avalanche",
    "Neo",
    "Terra",
    "Huobi Token",
    "Dash",
    "The Graph"
  ];

  // List<Widget> listOfCoins = [Text("Hello")];

  final firestoreInstance = FirebaseFirestore.instance;
  // var firestoreUser = FirebaseFirestore.instance.collection('User');
  var firebaseAuth = FirebaseAuth.instance;

  var coinWidgets = List<Widget>();

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
    // var cryptoData = CryptoData.getData;

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
                  "Portfolio (New)",
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
            // PriceContainer(),
            /// placeholder for pricecontainer
            Container(
              height: displayHeight(context) * 0.15,
              width: displayWidth(context) * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: appPink,
              ),
              child: Stack(
                children: <Widget> [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget> [
                      Positioned(
                        left: 117,
                        top: 5,
                        child: Column(
                      children: <Widget> [
                        SizedBox(height: displayHeight(context) * 0.02),
                        SizedBox(height: displayHeight(context) * 0.015),
                        Text(
                          "B: 0.00023149",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          "\$179.58",
                          style: TextStyle(fontSize: 25, color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      // Container(
                      //   alignment: Alignment.topCenter,
                      //   child: buildTicker(btcSpecial),
                      // ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: <Widget> [
                      //     buildTicker(btcSpecial),
                      //   ]
                      // ),
                      ]
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: Text("\$51320", style: TextStyle(color: Colors.white)),
                  ),
                ]
              ),
            ),
            /// placeholder for pricecontainer
            // SizedBox(height: displayHeight(context) * 0.32),
            Container(
              child: Column(
                children: <Widget> [
                  SizedBox(height: displayHeight(context) * 0.02),
                  _buildChild(),

                    // if( coinWidgets.length != null) {
                    // ListView.builder(
                    //   itemCount: coinWidgets.length,
                    //   itemBuilder: (context, index) {
                    //     // if (index == 0) {
                    //     //   return SizedBox();
                    //     // } else {
                    //     return coinWidgets[index];
                    //     // }
                    //   }
                    // //   itemBuilder: (context, index) {
                    // //     //return PortfolioListTile(cryptoData, index);
                    //       /// our main place
                    // //   },
                    // ),
                  // }
                  Container(
                    child: SizedBox(
                      // height: displayHeight(context) * 0.35,
                      // width: displayWidth(context),
                      child: FloatingActionButton(
                        onPressed: () {
                          var j = i;
                          coinWidgets.add(
                            Container(
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.all(Radius.circular(20)),
                              // ),
                              padding: EdgeInsets.fromLTRB(30,0,30,0),
                              height: displayHeight(context) * 0.12,
                              // width: displayWidth(context) * 0.1,
                              // height: displayHeight(context) * 0.11,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                color: appPink,
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.all(Radius.circular(20)),
                                  // ),
                                  // child: Column(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: <Widget>[
                                      // ListTile(
                                      //   leading: Icon(Icons.album),
                                      //   title: Text('The Enchanted Nightingale'),
                                      //   // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                                      // ),
                                      // Column(
                                      //   // mainAxisAlignment: MainAxisAlignment.end,
                                      //   children: <Widget>[
                                          // TextButton(
                                          //   child: Text('BUY TICKETS'),
                                          //   onPressed: () {/* ... */},
                                          // ),
                                          // SizedBox(width: 8),
                                          // TextButton(
                                          //   child: Text('LISTEN'),
                                          //   onPressed: () {/* ... */},
                                          // ),
                                          // SizedBox(width: 8),
                                        child: Row(
                                          children: <Widget> [
                                            SizedBox(width: 20),
                                          Icon(Icons.ac_unit, size: 50),
                                          SizedBox(width: 20),
                                          Container(
                                            width: displayWidth(context) * 0.35,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget> [
                                                // Text("BTC/USD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                                Container(
                                                  width: displayWidth(context) * 0.35,
                                                  child: textField[i],
                                                ),
                                                Text("SELL: 10 coins", style: TextStyle(color: Colors.white)),
                                              ],
                                        //     ),)
                                        //   ),
                                        // ],
                                      ),),
                                      SizedBox(width: displayWidth(context) * 0.06),
                                      Container( /// Maybe TODO: We'll make this it's own stateful widget so setState is isolated here, also going to require a callback
                                        width: displayWidth(context) * 0.12,
                                        child: IconButton(
                                          icon: Icon(Icons.lock),
                                          onPressed: () {
                                            log("Hello World");
                                            log("i = " + i.toString());
                                            log("j = " + j.toString());
                                            log("coinTicker[0] = " + coinTicker[0]);
                                            log("coinTicker[j] = " + coinTicker[j]);
                                            // log("coinTicker[i] = " + coinTicker[i]);
                                            // if (added.isEmpty) {
                                              firestoreInstance
                                                .collection("Users")
                                                .doc("Wtf")
                                                .update({"PortfolioMap.BPortfolio1." + coinTicker[j]: added[coinTicker[j]]})
                                                .then((_){});
                                            // }

                                            setState(() {

                                            });
                                          }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          log(coinWidgets.length.toString());
                          setState(() {
                            i++;
                            textField.add(SimpleAutoCompleteTextField(
                              key: formKeyList[i],
                              // decoration: InputDecoration(errorText: "Beans"),
                              decoration: InputDecoration(helperText: "Insert a coin"),
                              controller: TextEditingController(text: ""),
                              suggestions: suggestions,
                              textChanged: (text) => currentText = text,
                              clearOnSubmit: false,
                              // textSubmitted: (text) => {}
                              
                              textSubmitted: (text) => setState(() {
                                  if (text != "") {
                                    log("???");
                                    added[text] = 10.0;
                                    coinTicker[k] = text;
                                    k++;
                                    log("!!!");
                                  }
                                }),
                              ),
                            );
                          });
                          
                      /// child: FloatingActionButton(
                      ///   onPressed: () {
                      /// 
                          // // if(listOfCoins == null) {
                          //   Text("Wattap");
                          //   log("WJHFOIJF");
                          // } else {
                          //   log("HF(!111111");
                          //   log(listOfCoins.toString());
                          //   log(listOfCoins.length.toString());
                          //   Text("What da faq");
                          //   ListView.builder(
                          //     itemCount: listOfCoins.length,
                          //     padding: EdgeInsets.fromLTRB(0,4,0,0),
                          //     itemBuilder: (context, index) {
                          //       return Text("Hello Bentoo", style: TextStyle(fontSize: 26, color: Colors.white));
                          //     },
                          //   );
                          //   log("Heavens F33l");
                            // Widget build(BuildContext context) {
                            //   ListView(children: listOfCoins);
                          // }
                        },
                        child: Icon(Icons.add),
                      ),
                      // child: ListView.builder(
                      //   itemCount: cryptoData.length,
                      //   itemBuilder: (context, index) {
                      //     //return PortfolioListTile(cryptoData, index);
                           /// our main place
                      //   },
                      // )
                      /// Build a bloclistener here and create list view based on state?
                      /// Or simply build a listview based on what's in our portfolio so far
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

  _buildChild() {
    log("In _buildChild, coinWidgets.length is " + coinWidgets.length.toString());
    if (coinWidgets.length != 0) {

      log("WTF");
      return Container(
        height: displayHeight(context) * 0.6,
        child: ListView.builder(
          itemCount: coinWidgets.length,
          itemBuilder: (context, index) =>
            coinWidgets[index],
        ),
      );
    }
    log("return SizedBox");
    return SizedBox(height: displayHeight(context) * 0.6);
  }
//   addDynamic(){
//   // if(listOfCoins.length != 0){

//   //   Product = [];
//   //   Price = [];
//   //   dynamicList = [];
//   // }
//   setState(() {});
//   if (listOfCoins.length >= 10) { /// TODO: we don't really want to cap ours but yea testing purposes
//     return;
//   }
//   listOfCoins.add(Text("Hello World this is me can't u see"));
// }

}