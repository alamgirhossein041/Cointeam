import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/v1/bloc/logic/get_price_info_bloc/get_price_info_bloc.dart';
import 'package:coinsnap/v1/bloc/logic/get_price_info_bloc/get_price_info_event.dart';
import 'package:coinsnap/v1/bloc/logic/get_price_info_bloc/get_price_info_state.dart';
import 'package:coinsnap/v1/ui_root/template/coin_content.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CoinView extends StatefulWidget {
  // final dynamic cryptoData;
  // final dynamic index;
  // CoinView({Key key, this.cryptoData, this.index}) : super(key: key);

  CoinView({Key key}) : super(key: key);

  @override
  CoinState createState() => CoinState();
}

class CoinState extends State<CoinView> {

  GetPriceInfoBloc getPriceInfoBloc;
  /// TRY AND MAP ARGUMENTS HERE INSTEAD OF BELOW IN BUILD WIDGET
  /// 
  /// IDK ADD/DISPATCH ISN'T DOING ANYTHING
  /// 
  /// https://stackoverflow.com/questions/57834900/how-to-access-flutter-bloc-in-the-initstate-method

  // final firestoreInstance = FirebaseFirestore.instance;
  // var firestoreUser = FirebaseFirestore.instance.collection('User');
  // var firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    /// TODO: stuff
    // loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
    // getPriceInfoBloc = BlocProvider.of<GetPriceInfoBloc>(context);
    getPriceInfoBloc = BlocProvider.of<GetPriceInfoBloc>(context);
    /// this is not receving bloc from anything
    getPriceInfoBloc.add(FetchGetPriceInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    String coinTicker = '';
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      log("CryptoData: " + arguments['cryptoData'].toString());
      log("Index " + arguments['index'].toString());
      log("The second index of CryptoData is: " + arguments['cryptoData'][arguments['index']].toString());
      coinTicker = arguments['cryptoData'][arguments['index']]['symbol'];
      log("Coin Ticker is: " + coinTicker);

    getPriceInfoBloc.add(FetchGetPriceInfoEvent(coinTicker: coinTicker));
    }

  

    // log("Parent widget.test: " + widget.cryptoData.toString());
    // log("Parent widget index: " + widget.index.toString());
    // log(widget.test.cryptoData[widget.test.index].toString());
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldState,
      // drawer: MyDrawer(),
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
                  icon: Icon(Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 35),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
                Text(
                  // widget.cryptoData[0]['symbol'],
                  "Temporary(?)",
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
            RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<GetPriceInfoBloc>(context).add(FetchGetPriceInfoEvent(coinTicker: coinTicker));
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget> [
                    SizedBox(height: displayHeight(context) * 0.025),
                    // PriceContainer(),

                    /// Below is almost the Same layout as PriceContainer(),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [appPurple, appBlue],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      height: displayHeight(context) * 0.2,
                      width: displayWidth(context) * 0.75,
                      child: Container(
                        child: Column (
                          children: <Widget> [
                            SizedBox(height: displayHeight(context) * 0.03),
                            Image(image: AssetImage('graphics/icons/crypto/bitcoin_white_2.png')),  
                            SizedBox(height: displayHeight(context) * 0.02),
                            /// InnerHomeView(),
                            // InnerCoinView(arguments['cryptoData'][arguments['index']]['symbol']),
                            BlocListener<GetPriceInfoBloc, GetPriceInfoState>(
                              /// InnerCoinView(coinTicker: coinTicker),
                              listener: (context, state) {
                                if (state is GetPriceInfoErrorState) {
                                  log("error at getPriceInfoErrorState in coin_view.dart");
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(content: Text(state.errorMessage)),
                                  // );
                                }
                              },
                              child: BlocBuilder<GetPriceInfoBloc, GetPriceInfoState> (
                                builder: (context, state) {
                                  if (state is GetPriceInfoLoadedState) {
                                    log("GetPriceInfoLoadedState");
                                    return InnerCoinView(coinTicker: coinTicker); /// add something line 72 temp_home_view.dart
                                  } else {
                                    return SizedBox(child: Text("I don't know what's happening line 151 coin_view.dart blocbuilder"));
                                  }
                                }
                              )
                            ),
                          ]
                        ),
                      ),
                      // child: Text("helloWorld"),
                    ),
                    SizedBox(height: displayHeight(context) * 0.025),
                    // SizedBox(height: displayHeight(context) * 0.32),
                    Container(
                      height: displayHeight(context) * 0.32,
                      // child: CustomMeasureTickCount.withSampleData(),
                    ),
                    // PortfolioListView(),
                  ]
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}