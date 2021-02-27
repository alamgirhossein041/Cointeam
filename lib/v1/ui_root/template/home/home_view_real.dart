import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/v1/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_bloc.dart';
import 'package:coinsnap/v1/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_event.dart';
import 'package:coinsnap/v1/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_state.dart';
import 'package:coinsnap/v1/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v1/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v1/ui_root/drawer/drawer.dart';
import 'package:coinsnap/v1/ui_root/template/data/chart/overall/chart_cartesian.dart';
import 'package:coinsnap/v1/ui_root/template/loading.dart';
import 'package:coinsnap/v1/ui_root/template/price_container.dart';
import 'package:coinsnap/v1/ui_root/template/small/card/portfolio_list_tile.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewReal extends StatefulWidget {
  HomeViewReal({Key key}) : super(key: key);

  @override
  HomeStateReal createState() => HomeStateReal();
}

class HomeStateReal extends State<HomeViewReal> {

  final firestoreInstance = FirebaseFirestore.instance;
  var firestoreUser = FirebaseFirestore.instance.collection('User');
  var firebaseAuth = FirebaseAuth.instance;

  CardCryptoDataBloc cardCryptoDataBloc;

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
    // getTotalValueBloc = BlocProvider.of<GetTotalValueBloc>(context);
    // getTotalValueBloc.add(FetchGetTotalValueEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cardCryptoDataBloc = BlocProvider.of<CardCryptoDataBloc>(context);
    cardCryptoDataBloc.add(FetchCardCryptoDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    // var cryptoData = CryptoData.getData;
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldState,
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: Column(
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.03),
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
                  "Welcome Screen",
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
                BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget> [
                    SizedBox(height: displayHeight(context) * 0.025),
                    PriceContainer(),
                    SizedBox(height: displayHeight(context) * 0.025),
                    // SizedBox(height: displayHeight(context) * 0.32),
                    Container(
                      height: displayHeight(context) * 0.62,



                      child: BlocListener<CardCryptoDataBloc, CardCryptoDataState>(
                        listener: (context, state) {
                          if (state is CardCryptoDataErrorState) {
                            log("error in CardCryptoDataErrorState in home_view_real.dart");
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(content: Text(state.errorMessage)),
                            // );
                          }
                        },
                        child: BlocBuilder<CardCryptoDataBloc, CardCryptoDataState>( /// Both bloc types to be built (refactor existing controllers)
                          builder: (context, state) {
                            if (state is CardCryptoDataInitialState) {
                              log("CardCryptoDataInitialState");
                              return buildLoadingTemplate();
                            } else if (state is CardCryptoDataLoadingState) {
                              log("CardCryptoDataLoadingState");
                              // return buildLoadingTemplate();
                              // return buildGetTotalValue(tmpTotalValue, tmpBtcSpecial);
                              return buildLoadingTemplate();
                            } else if (state is CardCryptoDataLoadedState) {
                              log("CardCryptoDataLoadedState");
                              return CustomScrollView(
                                slivers: <Widget> [
                                  SliverToBoxAdapter(
                                    /// Chart
                                    // height: displayHeight(context) * 0.27,
                                    // child: CustomMeasureTickCount.withSampleData(), // we dont need this but andrew wants to keep it so.. RAGE AGAINST THE MACHINE
                                    child: SizedBox(
                                      height: displayHeight(context) * 0.27,
                                      child: ChartOverall(),
                                    ),
                                  ),
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate((context, index) {
                                    // itemCount: cryptoData.length,
                                    // padding: EdgeInsets.fromLTRB(0,4,0,0),
                                    // itemBuilder: (context, index) {
                                        return PortfolioListTile(coinListMap: state.coinListMap, index: index);
                                      },
                                      childCount: state.coinListMap.data.length,
                                    ),
                                  ),
                                ],
                              );
                              // tmpBtcSpecial = state.btcSpecial;
                              // return Container(
                              //   child: buildGetTotalValue(state.totalValue, state.btcSpecial)
                              // );
                            } else if (state is CardCryptoDataErrorState) {
                              log("CardCryptoDataErrorState");
                              return buildErrorTemplate(state.errorMessage);
                            } else {
                              return null;
                            }
                          }
                        ),
                      ),



                      // child: CustomScrollView(
                      //   slivers: <Widget> [
                      //     SliverToBoxAdapter(
                      //       /// Chart
                      //       // height: displayHeight(context) * 0.27,
                      //       // child: CustomMeasureTickCount.withSampleData(), // we dont need this but andrew wants to keep it so.. RAGE AGAINST THE MACHINE
                      //       child: SizedBox(
                      //         height: displayHeight(context) * 0.27,
                      //         child: ChartOverall(),
                      //       ),
                      //     ),
                      //     SliverList(
                      //       delegate: SliverChildBuilderDelegate((context, index) {
                      //       // itemCount: cryptoData.length,
                      //       // padding: EdgeInsets.fromLTRB(0,4,0,0),
                      //       // itemBuilder: (context, index) {
                      //           return PortfolioListTile();
                      //         },
                      //         childCount: cryptoData.length,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ],
                ),
              ),
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