import 'dart:async';

import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_event.dart';
/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///
/// ###                                                                                  ### ///
/// ###  Version with NO API linked - list of coins retrieved from Coinmarketcap Top 100 ### ///
/// ###                                                                                  ### ///
/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///
/// 
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/global_library.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/repo/app_repo/binance_time_sync/binance_time_sync.dart';
import 'package:coinsnap/v2/repo/db_repo/test/portfolio_post.dart';
import 'package:coinsnap/v2/ui/category/dashboard_with_category.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/widgets/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/widgets/helper_widgets/numbers.dart';
import 'package:coinsnap/v2/ui/widgets/modal_widgets/slider_widget.dart';
import 'package:coinsnap/working_files/bottom_nav_bar.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:coinsnap/working_files/initial_category_data.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:crypto_font_icons/crypto_font_icon_data.dart';

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class DashboardNoApiView extends StatefulWidget {
  // DashboardNoApiView({Key key}) : super(key: key);

  @override
  DashboardNoApiViewState createState() => DashboardNoApiViewState();
}

class DashboardNoApiViewState extends State<DashboardNoApiView> {

  // final firestoreInstance = FirebaseFirestore.instance;
  // var firestoreUser = FirebaseFirestore.instance.collection('User');
  // var firebaseAuth = FirebaseAuth.instance;

  /// custom padding in pixels, because Dialog comes attached with a default FAT padding :)
  double modalEdgePadding = 10;

 

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
    log("dashboard_initial_noAPI.dart - DashboardNoApiView() InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log("dashboard_initial_noAPI.dart - DashboardNoApiView() DPD");
  }


  @override
  Widget build(BuildContext context) {
    // GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: appBlack,
      bottomNavigationBar: 
        // height: kBottomNavigationBarHeight,
        BottomNavBar(callBack: _callBackSetState),
 
      // key: scaffoldState,
      drawer: DrawerMenu(),
      body: Container(
        // height: displayHeight(context),
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: FutureBuilder(
          future: readStorage("welcome"),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
              if (!snapshot.hasError) {

                /// 20th - Get Server Time
                /// Direct Repo Call? No need for bloc
                
                BinanceTimeSyncRepositoryImpl helloWorld = BinanceTimeSyncRepositoryImpl();

                helloWorld.getBinanceTimeSyncLatest();
                
                if (snapshot.data != "none") {
                  log(snapshot.data.toString());
                  BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
                  BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
                  BlocProvider.of<CoingeckoList250Bloc>(context).add(FetchCoingeckoList250Event());
                  return DashboardWithNoApiWorking();
                } else {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacementNamed(context, '/first');
                  });
                  return Container();
                }
              } else {
                return errorTemplateWidget(snapshot.error);
              }
            }
          },
        ),
      ),
    );
  }

  
  void _callBackSetState() {
    setState(() {
      log("Hello World");
      BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
      // BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
    });
  }
}

/// list of pageviewmodels required by intro_views_flutter
/// used for API tutorial thingy


class DashboardWithNoApiWorking extends StatefulWidget {
  
  @override
  DashboardWithNoApiWorkingState createState() => DashboardWithNoApiWorkingState();
}

class DashboardWithNoApiWorkingState extends State<DashboardWithNoApiWorking> {

  @override
  void initState() { 
    super.initState();
    log("dashboard_initial_noAPI.dart - DashboardNoApiWorking() InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // log("CoingeckoList250Bloc in dashboard_initial_noAPI.dart");
    log("dashboard_initial_noAPI.dart - DashboardWithNoApiWorking() DPD");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget> [
          SizedBox(height: displayHeight(context) * 0.05),
          /// ### Top Row starts here ### ///
          TopMenuRow(),
          RefreshIndicator(
            onRefresh: () async {
              // BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
              BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
              BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget> [
                  NoApiPriceContainer(),
                  // SizedBox(height: displayHeight(context) * 0.01),
                ],
              ),
            ),
          ),
        // create: (context) => FirestoreGetUserDataBloc(firestoreGetUserDataRepository: FirestoreGetUserDataRepositoryImpl())..add(FetchFirestoreGetUserDataEvent()),
          
        ],
      ),
    );
  }
}

class NoApiPriceContainer extends StatefulWidget {
  // NoApiPriceContainer({Key key}) : super(key: key);

  @override
  NoApiPriceContainerState createState() => NoApiPriceContainerState();
}

class NoApiPriceContainerState extends State<NoApiPriceContainer> with SingleTickerProviderStateMixin {
  final DBPortfolioPostTest dbPortfolioPostTest = DBPortfolioPostTest();

  double _heightHideContainer;
  double _heightShowContainer;
  double _heightOffset;
  bool _showContainer = false;
  bool _panelVisibility = false;
  bool _innerPanelVisibility = false;

  double _size = 100;
  bool _large = false;

  // void _updateSize() {
  //   setState(() {
  //     _size = _large ? 250.0 : 100.0;
  //     _large = !_large;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _heightHideContainer = displayHeight(context) * 0.2;
    _heightShowContainer = displayHeight(context) * 0.4;
    _heightOffset = 35;

    // return Container(
    //   // height: displayHeight(context) * (0.2 + 0.16),
    //   // height: displayHeight(context),
    //   width: displayWidth(context),
      // child: Expanded(
        // child: Container(
        
        // padding: EdgeInsets.fromLTRB(0,30,0,0),
        // margin: EdgeInsets.fromLTRB(,, right, bottom)
          return Column(
            children: <Widget> [
              Container(
                height: _heightHideContainer + _heightOffset,
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
                        // borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.fromLTRB(0,2.75,0,2.75),
                        child: Container(
                          // height: displayHeight(context) * 0.2,
                          height: (_heightHideContainer),
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
                            // borderRadius: BorderRadius.circular(5),
                          ),
                          /// ### This is where the inner container starts ### ///
                          // child: Center(
                          //   child: Text('Enter further widgets here', style: TextStyle(color: Colors.white)),
                          // ),
                          child: Column(
                            /// ### Start container columns here ### ///
                            children: <Widget> [
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
                                                    child: Text(numberFormatter(state.globalStats.data.quote.uSD.totalMarketCap), style: TextStyle(fontSize: 22, color: Colors.white)),
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
                                
                                    /// ### Hidden Panel begins here ### ///
                                    
                                    // HiddenPanel(),

                                  ],
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
                      height: _heightHideContainer + _heightOffset,
                      child: FutureBuilder( /// ### Panic Action Button ### ///
                        future: readStorage("trading"), /// ### 16th
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                            if (!snapshot.hasError) {
                              // log(snapshot.data.toString());
                              /// ("Return a welcome screen") ??? default comment
                                // return DashboardWithNoApiWorking();
                              if (snapshot.data == "none") {
                                return EnableTradingButton();
                              } else {
                                return PanicActionButton();
                              }
                            } else {
                              return errorTemplateWidget(snapshot.error);
                            }
                          }
                        },
                      ),
                    ),
                    // EnableTradingButton(),
                    /// or
                    /// PanicActionButton(),
                    
                  
                  ]
                ),
              ),
              NoApiCategoryList(showContainer: _showContainer),
            ],
          );
        // ),
      
    
  }
    // void _callBackVisibilitySetState() async {
    // setState(() {
    //   _showContainer = !_showContainer;
    //   _panelVisibility = !_panelVisibility;
    // });
  // }
}

class NoApiCategoryList extends StatefulWidget {
  NoApiCategoryList({this.showContainer});

  final bool showContainer;

  @override
  NoApiCategoryListState createState() => NoApiCategoryListState();
}

class NoApiCategoryListState extends State<NoApiCategoryList> {
  double _heightHideContainer;
  double _heightShowContainer;
  // double _heightOffset;

  // final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    // _heightHideContainer = displayHeight(context) * 0.51;
    // _heightShowContainer = displayHeight(context) * 0.385;
    // _heightOffset = displayHeight(context) * 0.065;

    return Container(
      width: displayWidth(context),
      // height: widget.showContainer ? displayHeight(context) * 0.36: displayHeight(context) * 0.4,
      height: displayHeight(context) * 0.57,
      // child: Expanded(
        child: Column(
          children: <Widget> [
            Container(
              // height: widget.showContainer ? displayHeight(context) * 0.36 : displayHeight(context) * 0.4,
              // child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: displayHeight(context) * 0.02),
                child: Column(
                  children: <Widget> [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10,10,0,5),
                        child: Text("Curated Lists", style: TextStyle(color: Colors.white, fontSize: 16)),
                      )
                    ),
                    Container(
                      height: displayHeight(context) * 0.225,
                      child: ListView(
            /// Need to make this a bloc that gets a pre-defined list of coins
            /// Categories are predefined
                        children: <Widget> [
                          TileDefi(categoryName: globals.Categories.defi),
                          TileTop100(categoryName: globals.Categories.top100),
                          TileDex(categoryName: globals.Categories.cexdex),
                        ],
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Container(
                      // height: displayHeight(context) * 0.245,
                          // TileAddPortfolio(),
                      child: FutureBuilder(
                        future: readStorage("binance"),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("None");
                            case ConnectionState.waiting:
                              return Container();
                            default:
                            if (!snapshot.hasError) {
                              if (snapshot.data != "none") {
                                log(snapshot.data.toString());
                                // return DashboardWithNoApiWorking();
                                
                                return BinanceTileBlurb(); /// 19th
                              } else {
                                // SchedulerBinding.instance.addPostFrameCallback((_) {
                                  // Navigator.pushNamed(context, '/first');
                                return AddPortfolioBlurb();
                                // return Text("Dev Error - Not enough caffeine", style: TextStyle(color: Colors.white, fontSize: 24));
                              }
                            } else {
                              return errorTemplateWidget(snapshot.error);
                            }
                          }
                        }
                      )
                    )
                    ,

                    // NoApiAddCoinWidget(),
                  ]
                ),
              // ),
              ),
            ),
          ]
        ),
      
    );
  }
}


class TileDefi extends StatelessWidget {
  const TileDefi({this.categoryName});
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
                    BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.defiCategoryData));
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                          DashboardWithCategoryNew(categoryName: categoryName)
                      ),
                    );

                    ///  arguments: {'categoryName': categoryName});
                  },
                  child: Column(
                    children: <Widget> [
                  Expanded(
                    flex: 1,
                    // padding: EdgeInsets.fromLTRB(0,0,0,0),
                    // height: displayHeight(context) * 0.240,
                    // width: displayWidth(context) * 0.385,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Container(
                        height: displayHeight(context) * 0.240,
                        width: displayWidth(context) * 0.385,
                        // padding: EdgetInsets.fromLTRB()
                        decoration: BoxDecoration(
                          color: Color(0xFF191B31),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        /// ### Card content starts here ### ///
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10,0,0,0), /// TODO: padding constant
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Icon(CryptoFontIcons.XRP, color: Colors.blue)
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("DeFi", style: TextStyle(color: Colors.white))
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Text("Top 100", style: TextStyle(color: Colors.white)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget> [
                                  Text("Market Cap:", style: TextStyle(color: Colors.white)),
                                  Text("\$182B (+8%)", style: TextStyle(color: Colors.blue)),
                                  // Text("(+8%)", style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // child: Padding(
                        //   padding: EdgeInsets.fromLTRB(30,0,0,0),
                        //   child: Row(
                        //     children: <Widget> [ /// ### Card Tile Internal UI Starts Here ### ///
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Icon(
                        //           CryptoFontIcons.BTC,
                        //           color: Colors.orange,
                        //         ),
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: <Widget> [
                        //           SizedBox(width: 10),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: <Widget> [
                        //               Text(
                        //                 "Top 100",
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 14,
                        //                 ),
                        //               ),
                        //               // Text("CryptoExchange Name", style:TextStyle(color: Colors.grey, fontSize: 12)),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ] /// ### Card Tile Internal UI Ends Here ### ///
                        //   )
                        // )



                      )
                    )
                  ),
                    ]
                  // )
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
      ),
    );
  }
}

class TileTop100 extends StatelessWidget {
  const TileTop100({this.categoryName});
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
                    BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.top100CategoryData));
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                          DashboardWithCategoryNew(categoryName: categoryName)
                      ),
                    );

                    ///  arguments: {'categoryName': categoryName});
                  },
                  child: Column(
                    children: <Widget> [
                      Expanded(
                    flex: 1,
                    // padding: EdgeInsets.fromLTRB(0,0,0,0),
                    // height: displayHeight(context) * 0.240,
                    // width: displayWidth(context) * 0.385,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Container(
                        height: displayHeight(context) * 0.240,
                        width: displayWidth(context) * 0.385,
                        // padding: EdgetInsets.fromLTRB()
                        decoration: BoxDecoration(
                          color: Color(0xFF191B31),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        /// ### Card content starts here ### ///
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10,0,0,0), /// TODO: padding constant
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Icon(CryptoFontIcons.BTC, color: Colors.orange)
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Top 100", style: TextStyle(color: Colors.white))
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Text("Top 100", style: TextStyle(color: Colors.white)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget> [
                                  Text("Market Cap:", style: TextStyle(color: Colors.white)),
                                  Text("\$1.43T (+6.3%)", style: TextStyle(color: Colors.blue)),
                                  // Text("(+8%)", style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // child: Padding(
                        //   padding: EdgeInsets.fromLTRB(30,0,0,0),
                        //   child: Row(
                        //     children: <Widget> [ /// ### Card Tile Internal UI Starts Here ### ///
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Icon(
                        //           CryptoFontIcons.BTC,
                        //           color: Colors.orange,
                        //         ),
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: <Widget> [
                        //           SizedBox(width: 10),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: <Widget> [
                        //               Text(
                        //                 "Top 100",
                        //                 style: TextStyle(
                        //                   color: Colors.white,
                        //                   fontSize: 14,
                        //                 ),
                        //               ),
                        //               // Text("CryptoExchange Name", style:TextStyle(color: Colors.grey, fontSize: 12)),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ] /// ### Card Tile Internal UI Ends Here ### ///
                        //   )
                        // )



                      )
                    )
                  ),
                    ]
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

class TileDex extends StatelessWidget {
  const TileDex({this.categoryName});
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
              BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.cexDexCategoryData));
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                    DashboardWithCategoryNew(categoryName: categoryName)
                ),
              );

              ///  arguments: {'categoryName': categoryName});
            },
            child: 
              
              // padding: EdgeInsets.fromLTRB(0,0,0,0),
              // height: displayHeight(context) * 0.240,
              // width: displayWidth(context) * 0.385,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Container(
                  height: displayHeight(context) * 0.240,
                  width: displayWidth(context) * 0.385,
                  // padding: EdgetInsets.fromLTRB()
                  decoration: BoxDecoration(
                    color: Color(0xFF191B31),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  /// ### Card content starts here ### ///
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10,0,0,0), /// TODO: padding constant
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Icon(CryptoFontIcons.ETH, color: Colors.blueGrey)
                              ),
                              Expanded(
                                flex: 7,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Dex", style: TextStyle(color: Colors.white))
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        // child: Text("Top 100", style: TextStyle(color: Colors.white)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget> [
                            Text("Market Cap:", style: TextStyle(color: Colors.white)),
                            Text("\$42B (-16%)", style: TextStyle(color: Colors.blue)),
                            // Text("(+8%)", style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // child: Padding(
                  //   padding: EdgeInsets.fromLTRB(30,0,0,0),
                  //   child: Row(
                  //     children: <Widget> [ /// ### Card Tile Internal UI Starts Here ### ///
                  //       Align(
                  //         alignment: Alignment.centerLeft,
                  //         child: Icon(
                  //           CryptoFontIcons.BTC,
                  //           color: Colors.orange,
                  //         ),
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: <Widget> [
                  //           SizedBox(width: 10),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: <Widget> [
                  //               Text(
                  //                 "Top 100",
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 14,
                  //                 ),
                  //               ),
                  //               // Text("CryptoExchange Name", style:TextStyle(color: Colors.grey, fontSize: 12)),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ] /// ### Card Tile Internal UI Ends Here ### ///
                  //   )
                  // )



                )
              // )
            ),
          )
        )
      )
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
              child: Text("Add Portfolio", style: TextStyle(color: Colors.white)
            )
          ),
          GestureDetector(
            onTap: () {
              /// TODO: COINTEAM-81
              Navigator.pushReplacementNamed(context, '/hometest');
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(25,2,25,0),
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

class EnableTradingButton extends StatelessWidget {
  const EnableTradingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: () {
                /// Dev-5: UNCOMMENT BELOW
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) => Dialog(
                //     /// Manual padding override because Dialog's default padding is FAT
                //     insetPadding: EdgeInsets.all(10),
                //     /// Connect API tutorial modal
                //     child: CarouselDemo(),
                //   ),
                // ),


                /// 17th April Release 1.0.13
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) => Dialog(
                //     /// Manual padding override because Dialog's default padding is FAT
                //     insetPadding: EdgeInsets.all(10),
                //     /// Connect API tutorial modal
                //     child: CarouselDemo(),
                //   ),
                // ),
                // writeStorage("trading", "binance"),
                /// 17th April Release 1.0.13
                
                Navigator.pushReplacementNamed(context, '/second');

              },
            ),
            elevation: 2,
          ),
        ),
      ),
    );
  }
}

class PanicActionButton extends StatelessWidget {
  // const PanicActionButton({});

  // final Function callBack;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // height: displayHeight(context) * 0.065,
          height: 54.86,
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text("BUY / SELL", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              onTap: () => {
                /// TODO: COINTEAM-81
                // callBack(),
                // dbPortfolioPostTest.dbPortfolioPostTest(),
                BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent()),
                Navigator.pushNamed(context, '/sellportfolio')
              },
            ),
            elevation: 2,
          ),
        ), 
    );
  }
}


Future<String> readStorage(String _key) async {

  final storage = new FlutterSecureStorage();

  String value = await storage.read(key: _key);
  if (value == null) {
    return "none";
  } else { /// TODO; Check for api key validity using cryptography
    return value;
  }
}

void deleteStorage(String _key) async {

  final storage = new FlutterSecureStorage();

  await storage.delete(key: _key);
}

void writeStorage(String _key, String _value) async {

  final storage = new FlutterSecureStorage();

  await storage.write(key: _key, value: _value);
}

class BinanceTileBlurb extends StatelessWidget {
  // const BinanceTileBlurb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetCoinListBloc, GetCoinListState>(
      listener: (context, state) {
        if (state is GetCoinListErrorState) {
          return errorTemplateWidget("Dashboard Error in GetCoinList Data");
        }
      },
      builder: (context, state) {
        if (state is GetCoinListLoadedState) {
          BlocProvider.of<GetCoinListTotalValueBloc>(context).add(FetchGetCoinListTotalValueEvent(coinList: state.coinList, coinBalancesMap: state.coinBalancesMap));
          return Container(
            // height: displayHeight(context) * 0.245,
            child: Column(
              children: <Widget> [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10,10,0,0),
                    child: Text("My Portfolios", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                Container(
                  height: displayHeight(context) * 0.225,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget> [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: appBlack,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
                              Navigator.pushReplacementNamed(context, '/viewportfolio');
                            },
                            child: Column(
                              children: <Widget> [
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Container(
                                      height: displayHeight(context) * 0.240,
                                      width: displayWidth(context) * 0.385,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF191B31),
                                        borderRadius: BorderRadius.circular(20),
                                      ),

                                      /// ### Card content starts here ### ///
                                      child: Column(
                                        children: <Widget> [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(10,0,0,0),
                                              child: Row(
                                                children: <Widget> [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Icon(CryptoFontIcons.DASH, color: Colors.orange),
                                                  ),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text("My Binance", style: TextStyle(color: Colors.white))
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: <Widget> [
                                                Text("Total Value:", style: TextStyle(color: Colors.white)),
                                                BlocConsumer<GetCoinListTotalValueBloc, GetCoinListTotalValueState>(
                                                  listener: (context, state) {
                                                    if (state is GetCoinListTotalValueErrorState) {
                                                      log("Error in GetCoinListTotalValue at Binance blurb on market dashboard");
                                                      return Text("An error has occured", style: TextStyle(color: Colors.white));
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    if (state is GetCoinListTotalValueLoadedState) {
                                                      return Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.blue));
                                                    } else {
                                                      return CircularProgressIndicator();
                                                    }
                                                  }
                                                )
                                              ]
                                            )
                                          )
                                        ]
                                      )
                                    )
                                  )
                                )
                              ]
                            )
                          )
                        )
                      ),
                      /// ### KAN-44 : Uncomment below
                      // InkWell(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: appBlack,
                      //     ),
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         log("User has clicked on Add Portfolio Blurb (in BinanceTileBlurb())");
                      //       },
                      //       child: Column(
                      //         children: <Widget> [
                      //           Expanded(
                      //             flex: 1,
                      //             child: Card(
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                      //               ),
                      //               child: Container(
                      //                 height: displayHeight(context) * 0.240,
                      //                 width: displayWidth(context) * 0.385,
                      //                 decoration: BoxDecoration(
                      //                   color: Color(0xFF191B31),
                      //                   borderRadius: BorderRadius.circular(20),
                      //                 ),

                      //                 /// ### Card content starts here ### ///
                      //                 child: Column(
                      //                   children: <Widget> [
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Align(
                      //                         alignment: Alignment.center,
                      //                         child: Text("Add Portfolio", style: TextStyle(color: Colors.white)),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       flex: 1,
                      //                       child: Align(
                      //                         alignment: Alignment.topCenter,
                      //                         child: Icon(Icons.add, color: Colors.white)
                      //                       ),
                      //                     ),
                      //                   ]
                      //                 ),
                      //               )
                      //             )
                      //           )
                      //         ]
                      //       )
                      //     )
                      //   )
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }
}


class AddPortfolioBlurb extends StatelessWidget {
  // AddPortfolioBlurb({Key key}) : super(key: key);

  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        child: Container(
          height: displayHeight(context) * 0.225,
          decoration: BoxDecoration(
            color: appBlack,
          ),
          child: GestureDetector(
            onTap: () {
              log("User has clicked on Add Portfolio Blurb");
              // localStorage.setItem("prime", [].toJSONEncodable()); 
              /// ### We can just set a blank item for now... Right?
              // localStorage.setItem("isPrime", true);
              // localStorage.setItem("prime", []);
              /// Dashboard()
              Navigator.pushReplacementNamed(context, '/viewportfolio');
            },
            child: Column(
              children: <Widget> [
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Container(
                      height: displayHeight(context) * 0.240,
                      width: displayWidth(context) * 0.385,
                      decoration: BoxDecoration(
                        color: Color(0xFF191B31),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      /// ### Card content starts here ### ///
                      child: Column(
                        children: <Widget> [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Add Portfolio", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Icon(Icons.add, color: Colors.white)
                            ),
                          ),
                        ]
                      ),
                    )
                  )
                )
              ]
            )
          )
        )
      ),
    );
  }
}