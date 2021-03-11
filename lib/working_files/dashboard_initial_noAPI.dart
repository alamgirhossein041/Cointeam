/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///
/// ###                                                                                  ### ///
/// ###  Version with NO API linked - list of coins retrieved from Coinmarketcap Top 100 ### ///
/// ###                                                                                  ### ///
/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///

import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/global_library.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/repo/db_repo/test/portfolio_post.dart';
import 'package:coinsnap/v2/ui/core_widgets/price_container/price_container.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/main/home_view.dart';
import 'package:coinsnap/v2/ui/menu_drawer/drawer_widget.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/modal_widgets/modal_popup.dart';
import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:math' as math;
import 'package:coinsnap/v2/asset/icon_custom/icon_custom.dart' as CustomIcon;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:crypto_font_icons/crypto_font_icon_data.dart';

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardNoApiView extends StatefulWidget {
  DashboardNoApiView({Key key}) : super(key: key);

  @override
  DashboardNoApiViewState createState() => DashboardNoApiViewState();
}

class DashboardNoApiViewState extends State<DashboardNoApiView> {

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
    BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
  }


  @override
  Widget build(BuildContext context) {
    // GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
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
      // key: scaffoldState,
      drawer: DrawerMenu(),
      body: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: FutureBuilder(
          future: readStorage(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
              if (!snapshot.hasError) {
                /// ("Return a welcome screen") ??? default comment
                // return snapshot.data != null
                //     ? DashboardWithApi()
                //     : Text("Wallah");
                  return DashboardWithNoApiWorking();
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


class DashboardWithNoApiWorking extends StatelessWidget {
  
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
            TopMenuRow(precontext: context),
            RefreshIndicator(
              onRefresh: () async {
                // BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget> [
                    NoApiPriceContainer(),
                    // SizedBox(height: displayHeight(context) * 0.01),
                    NoApiCategoryList(),
                    NoApiAddCoinWidget(),
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

class NoApiPriceContainer extends StatelessWidget {
  NoApiPriceContainer({Key key}) : super(key: key);

  final DBPortfolioPostTest dbPortfolioPostTest = DBPortfolioPostTest();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: displayHeight(context) * (0.2 + 0.16),
      width: displayWidth(context),
      child: Container(
        padding: EdgeInsets.all(30),
          child: Stack(
            children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.9, -1.3),
                    end: Alignment(1.25, 1.25),
                    colors: [
                      Color(0xFFC21EDB),
                      Color(0xFF0575FF),
                      Color(0xFF0AE6FF),
                    ], stops: [
                      0.0,
                      0.63,
                      1.0
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(2.75),
                  child: Container(
                    height: displayHeight(context) * 0.2,
                    width: displayWidth(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.25, -1.15),
                        end: Alignment(0.85, 1.1),
                        colors: [
                          Color(0xFF240C37),
                          Color(0xFF061330),
                          // Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    /// ### This is where the inner container starts ### ///
                    // child: Center(
                    //   child: Text('Enter further widgets here', style: TextStyle(color: Colors.white)),
                    // ),
                    child: Column(
                      /// ### Start container columns here ### ///
                      children: <Widget> [
                        Flexible(child:
                        Container(
                          padding: EdgeInsets.fromLTRB(0, displayHeight(context) * 0.025, 0, 0),
                          child: Column(
                            children: <Widget> [
                              Text("Total Market Cap", style: TextStyle(fontSize: 22, color: Colors.white)),
                              
                              /// ### Bloc data ### ///
                               
                              BlocListener<GlobalCoinmarketcapStatsBloc, GlobalCoinmarketcapStatsState>(
                                listener: (context, state) {
                                  if (state is GlobalCoinmarketcapStatsErrorState) {
                                    log("error in GlobalCoinmarketcapStatsState in home_view.dart");
                                  }
                                },
                                child: BlocBuilder<GlobalCoinmarketcapStatsBloc, GlobalCoinmarketcapStatsState>( /// Both bloc types to be built (refactor existing controllers)
                                  builder: (context, state) {
                                    if (state is GlobalCoinmarketcapStatsInitialState) {
                                      log("GlobalCoinmarketcapStatsInitialState");
                                      return loadingTemplateWidget();
                                    } else if (state is GlobalCoinmarketcapStatsLoadingState) {
                                      log("GlobalCoinmarketcapStatsLoadingState");
                                      return loadingTemplateWidget();
                                    } else if (state is GlobalCoinmarketcapStatsLoadedState) {
                                      log("GlobalCoinmarketcapStatsLoadedState");
                                      return Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: <Widget> [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text("\$" + state.globalStats.data.quote.uSD.totalMarketCap.toStringAsFixed(2), style: TextStyle(fontSize: 22, color: Colors.white)),
                                            ),
                                            SizedBox(height: 15),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget> [
                                                  Container(
                                                    child: Row(
                                                      children: <Widget> [
                                                        Icon(CryptoFontIcons.BTC, color: Colors.white, size: 14),
                                                        Text(state.globalStats.data.btcDominance.toStringAsFixed(1) + "%", style: TextStyle(color: Colors.blueGrey[100])),
                                                      ]
                                                    ),
                                                  ),
                                                  SizedBox(width: 25),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget> [
                                                        Icon(CryptoFontIcons.ETH, color: Colors.white, size: 14),
                                                        Text(state.globalStats.data.ethDominance.toStringAsFixed(1) + "%", style: TextStyle(color: Colors.blueGrey[100])),
                                                      ]
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ]
                                        )
                                      );
                                      // return Column(
                                //         children: <Widget> [
                                //           Row(
                                // /// TODO: Alignment (padding?)
                                //             children: <Widget> [
                                //               Container(
                                //                 padding: EdgeInsets.fromLTRB(displayWidth(context) * 0.3, 23, 0, 0),
                                //                 child:/// ### Start Bitcoin total value line here ### ///
                                //                     // Icon(CryptoFontIcons.BTC, color: Colors.white, size: 14),
                                //                     Align(
                                //                       alignment: Alignment.center,
                                //                       child: Text("\$" + state.globalStats.data.quote.uSD.totalMarketCap.toStringAsFixed(2), style: TextStyle(fontSize: 18, color: Colors.white)),
                                                   
                                //                 ), /// ### End Bitcoin total value line here ### ///
                                //               )
                                //             ],
                                          // ),
                                          // Text("\$" + (state.totalValue * state.btcSpecial).toStringAsFixed(2), style: TextStyle(fontSize: 28, color: Colors.white)),
                                      //   ],
                                      // );
                                      
                                
                                    } else {
                                      return Text("Placeholder in dashboard_initial_noAPI.dart");
                                    }
                                  }
                                ),
                              ),

                              /// ### Bloc Data ends ### ///
                          
                          
                          
                            ],
                          ),
                        ),

                          
                          // child: Center(
                          //   child: Container(
                          //     height: 31.43,
                          //     width: 36.23,
                          //     child: Column(
                          //       children: <Widget> [
                          //         Expanded(
                          //           // child: Transform.rotate(
                          //           //   angle: -5 * math.pi / 180,
                          //           //   child: FittedBox(
                          //           //     fit: BoxFit.fill,
                          //           //     child: Icon(CustomIcon.IconCustom.wallet_tilt, color: Colors.white, )
                          //           //   ),
                          //           // ),
                          //         ),
                                
                          //       ],
                          //     ),
                          //   ),
                          // )
                        )
                      ]
                    )
                  )
                )
              ),
              Container(
                height: displayHeight(context) * 0.24,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: displayHeight(context) * 0.066,
                    width: displayWidth(context) * 0.45,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            gradient: LinearGradient(
                              begin: Alignment(-1, -0.6),
                              end: Alignment(1, 0.75),
                              colors: [Color(0xFFFFE514), Color(0xFFFFCA1E)]
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFFCA1E),
                                spreadRadius: 4,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Color(0xFFFFCA1E),
                                spreadRadius: -4,
                                blurRadius: 5,
                              )
                            ]
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("ENABLE TRADING", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        onTap: () => {
                          /// TODO: COINTEAM-81
                          Navigator.pushNamed(context, '/hometest'),
                          // dbPortfolioPostTest.dbPortfolioPostTest(),
                        },
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ),
            ]
          )
      )
    );
  }
}

class NoApiCategoryList extends StatelessWidget {
  NoApiCategoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context),
      height: displayHeight(context) * 0.25,
      child: ListView(
      /// Need to make this a bloc that gets a pre-defined list of coins
      /// Categories are predefined
        children: <Widget> [
          PlaceholderTile(categoryName: globals.Categories.defi),
          PlaceholderTile(categoryName: globals.Categories.top100),
          PlaceholderTile(categoryName: globals.Categories.cexdex),
        ],
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}


class PlaceholderTile extends StatelessWidget {
  const PlaceholderTile({Key key, this.categoryName}) : super(key: key);
  final Categories categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        /// ### Clickable Card ### ///
        // child: Container(
          // child: Row(
          //   children: <Widget> [
              child: Container(
                decoration: BoxDecoration(
                  color: appBlack, /// ### TODO: Change to Hana's UI Colour ### ///
                ),
                child: GestureDetector( /// ### TODO: Cointeam-81 ### ///
                  onTap: () {
                    log("CategoryName is " + categoryName.toString());
                    // Navigator.pushNamed(context, '/coinview', arguments: {'cryptoData' : widget.coinListMap, 'index' : widget.index});
                    // Navigator.pushNamed(
                    //   context,
                    //   '/dashboardwithcategory',);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                          DashboardWithCategory(categoryName: categoryName)
                      ),
                    );

                    ///  arguments: {'categoryName': categoryName});
                  },
                  child: Container(
                    // padding: EdgeInsets.fromLTRB(0,0,0,0),
                    height: displayHeight(context) * 0.240,
                    width: displayWidth(context) * 0.385,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Container(
                        // padding: EdgetInsets.fromLTRB()
                        decoration: BoxDecoration(
                          color: Color(0xFF191B31),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30,0,0,0),
                          child: Row(
                            children: <Widget> [ /// ### Card Tile Internal UI Starts Here ### ///
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  CryptoFontIcons.BTC,
                                  color: Colors.orange,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget> [
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget> [
                                      Text(
                                        "Top 100",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      // Text("CryptoExchange Name", style:TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ] /// ### Card Tile Internal UI Ends Here ### ///
                          )
                        )
                      )
                    )
                  )
                )
            //   )
            // ]
          // )
        )
      )
  //   Card(
  //     child: Column(
  //       children: <Widget> [
  //         Row(
  //           children: <Widget> [
  //             Icon(CryptoFontIcons.BTC),
  //             Text("Top 100", style: TextStyle(color: Colors.white)),
  //           ]
  //         ),
  //         Row(
  //           children: <Widget> [
  //             Text("128.76", style: TextStyle(fontSize: 22, color: Colors.white)),
  //             Text("BTC", style: TextStyle(fontSize: 18, color: Colors.white)),
  //           ]
  //         )
  //       ],
  //     ),
  //   ),

  //   Card(
  //     child: Column(
  //       children: <Widget> [
  //         Row(
  //           children: <Widget> [
  //             Icon(CryptoFontIcons.BTC),
  //             Text("Top 100", style: TextStyle(color: Colors.white)),
  //           ]
  //         ),
  //         Row(
  //           children: <Widget> [
  //             Text("128.76", style: TextStyle(fontSize: 22, color: Colors.white)),
  //             Text("BTC", style: TextStyle(fontSize: 18, color: Colors.white)),
  //           ]
  //         )
  //       ],
  //     ),
  //   ),

  //   Card(
  //     child: Column(
  //       children: <Widget> [
  //         Row(
  //           children: <Widget> [
  //             Icon(CryptoFontIcons.BTC),
  //             Text("Top 100", style: TextStyle(color: Colors.white)),
  //           ]
  //         ),
  //         Row(
  //           children: <Widget> [
  //             Text("128.76", style: TextStyle(fontSize: 22, color: Colors.white)),
  //             Text("BTC", style: TextStyle(fontSize: 18, color: Colors.white)),
  //           ]
  //         )
  //       ],
  //     ),
  //   ),

  // ],
    );
  }
}

class NoApiAddCoinWidget extends StatelessWidget {
  const NoApiAddCoinWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget> [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
              child: Text("Add Coins", style: TextStyle(color: Colors.white)
              )
            )
          ),
          GestureDetector(
            onTap: () {
              /// TODO: COINTEAM-81
              Navigator.pushNamed(context, '/hometest');
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(25,2,25,2),
              height: displayHeight(context) * 0.11,
              width: displayWidth(context),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Container(
                  // padding: EdgetInsets.fromLTRB()
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.2, 0),
                      end: Alignment(1, 0),
                      colors: [Color(0xFF282136), Color(0xFF0F1D2D)],
                      // colors: [darkRedColor, lightRedColor]
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.add, color: Color(0xFF777984)),
                  )
                )
              )
            )
          )
        ]
      )
    );
  }
}