/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///
/// ###                                                                                  ### ///
/// ###  Version with Binance API linked - list of coins retrieved from Binance Account  ### ///
/// ###                                                                                  ### ///
/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///

import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/core_widgets/price_container/price_container.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/menu_drawer/drawer_widget.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/modal_widgets/modal_popup.dart';
import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:crypto_font_icons/crypto_font_icon_data.dart';

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  // final firestoreInstance = FirebaseFirestore.instance;
  // var firestoreUser = FirebaseFirestore.instance.collection('User');
  // var firebaseAuth = FirebaseAuth.instance;

  final storage = new FlutterSecureStorage();

  /// custom padding in pixels, because Dialog comes attached with a default FAT padding :)
  double modalEdgePadding = 10;

 

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /// make API call here
  }


  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: appBlack,
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Container( /// ### This is the bottomappbar ### ///
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(15),
          //     topLeft: Radius.circular(15),
          //   ),
    //          boxShadow: [                                                               
    //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),       
    // ], 
          // ),
        
        
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomAppBar(
              color: Color(0xFF2E374E),
              child: Column(
                children: <Widget> [
                  SizedBox(height: 5),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        IconButton(icon: Icon(Icons.swap_vert, color: Color(0xFFA9B1D9)), onPressed: () {

                          /// API Call
                          /// 

                        }),
                        // IconButton(icon: Icon(Icons.search), onPressed: () {}),
                        
                          /// /// ApiModalFirst();  /// ///
                          
                        IconButton(icon: Icon(Icons.help_center, color: Color(0xFFA9B1D9)), onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              /// Manual padding override because Dialog's default padding is FAT
                              insetPadding: EdgeInsets.all(modalEdgePadding),
                              // title: Text("Hello"),
                              // insetPadding: EdgeInsets.fromLTRB(0,1000,0,1000),
                              
                              /// Connect API tutorial modal
                              // child: ModalPopup(),
                              child: IntroScreen(),
                            ),
                          );
                        }),

                        IconButton(icon: Icon(Icons.refresh, color: Color(0xFFA9B1D9)), onPressed: () {setState(() {});}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      key: scaffoldState,
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: FutureBuilder(
          future: readStorage(), /// Reads whether or not there is an API key stored in localStorage, then loads two different pages based on result
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
              if (!snapshot.hasError) {
                return snapshot.data != null
                    ? DashboardWithApi()
                    // : DashboardWithoutApi();
                    : Text("Wallah"); /// TODO: Replace with DashboardNoApi()
              } else {
                return errorTemplateWidget(snapshot.error);
              }
            }
          },
        ),
      ),
    );
  }

    Future<String> readStorage() async {
    String value = await storage.read(key: "api");
    if (value == null) {
      return "none";
    } else { /// TODO; Check for api key validity using cryptography
      return value;
    }
  }
}

/// list of pageviewmodels required by intro_views_flutter
/// used for API tutorial thingy


class DashboardWithApi extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: Column(
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.05),
            /// ### Top Row starts here ### ///
            TopMenuRow(),
            RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                BlocProvider.of<CardCoinmarketcapCoinLatestBloc>(context).add(FetchCardCoinmarketcapCoinLatestEvent());
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget> [
                    PriceContainer(context: context,),
                  ],
                ),
              ),
              
            ),
          // create: (context) => FirestoreGetUserDataBloc(firestoreGetUserDataRepository: FirestoreGetUserDataRepositoryImpl())..add(FetchFirestoreGetUserDataEvent()),
            
          ],
        ),
      ),
    );
  }
}





