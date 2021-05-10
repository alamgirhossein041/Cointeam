import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:coinsnap/modules/app_load/bloc/coingecko_list_250_bloc/coingecko_list_250_bloc.dart';
import 'package:coinsnap/modules/app_load/bloc/coingecko_list_250_bloc/coingecko_list_250_event.dart';
import 'package:coinsnap/modules/app_load/repos/binance_time_sync.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/bloc/gecko_global_stats_bloc.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/bloc/gecko_global_stats_event.dart';
import 'package:coinsnap/modules/data/global_stats/coingecko/bloc/gecko_global_stats_state.dart';
import 'package:coinsnap/modules/data/global_stats/coinmarketcap/bloc/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/modules/data/global_stats/coinmarketcap/bloc/global_coinmarketcap_stats_event.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_bloc.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_event.dart';
import 'package:coinsnap/modules/portfolio/bloc/coinmarketcap_list_data_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/modules/portfolio/bloc/coinmarketcap_list_data_bloc/list_total_value_event.dart';
import 'package:coinsnap/modules/services/firebase_analytics.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';
import 'package:coinsnap/modules/utils/global_library.dart';
import 'package:coinsnap/modules/utils/initial_category_data.dart';
import 'package:coinsnap/modules/utils/number_formatter.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:coinsnap/modules/widgets/menu/drawer.dart';
import 'package:coinsnap/modules/widgets/menu/top_menu_row.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///
/// ###                                                                                  ### ///
/// ###  Version with NO API linked - list of coins retrieved from Coinmarketcap Top 100 ### ///
/// ###                                                                                  ### ///
/// ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###  ### ///
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class DashboardNoApiView extends StatefulWidget {

  @override
  DashboardNoApiViewState createState() => DashboardNoApiViewState();
}

class DashboardNoApiViewState extends State<DashboardNoApiView> {

  /// custom padding in pixels, because Dialog comes attached with a default FAT padding :)
  double modalEdgePadding = 10;

  @override
  void initState() {
    super.initState();
    debugPrint("dashboard_initial_noAPI.dart - DashboardNoApiView() InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("dashboard_initial_noAPI.dart - DashboardNoApiView() DPD");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlack,
      bottomNavigationBar: 
      BottomNavBar(callBack: _callBackSetState),
      drawer: DrawerMenu(),
      body: Container(
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
                  debugPrint(snapshot.data.toString());
                  BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
                  BlocProvider.of<GeckoGlobalStatsBloc>(context).add(GeckoGlobalStatsFetchEvent());
                  BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
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
      debugPrint("Hello World");
      // BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
      BlocProvider.of<GeckoGlobalStatsBloc>(context).add(GeckoGlobalStatsFetchEvent());
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
    debugPrint("dashboard_initial_noAPI.dart - DashboardNoApiWorking() InitState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // debugPrint("CoingeckoList250Bloc in dashboard_initial_noAPI.dart");
    debugPrint("dashboard_initial_noAPI.dart - DashboardWithNoApiWorking() DPD");
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
              BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
              BlocProvider.of<GeckoGlobalStatsBloc>(context).add(GeckoGlobalStatsFetchEvent());
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget> [
                  NoApiPriceContainer(),
                ],
              ),
            ),
          ),          
        ],
      ),
    );
  }
}

class NoApiPriceContainer extends StatefulWidget {

  @override
  NoApiPriceContainerState createState() => NoApiPriceContainerState();
}

class NoApiPriceContainerState extends State<NoApiPriceContainer> with SingleTickerProviderStateMixin {

  double _heightHideContainer;
  double _heightOffset;
  bool _showContainer = false;

  @override
  Widget build(BuildContext context) {
    _heightHideContainer = displayHeight(context) * 0.2;
    _heightOffset = 35;
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
                    height: (_heightHideContainer),
                    width: displayWidth(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.25, -1.15),
                        end: Alignment(0.85, 1.1),
                        colors: [
                          Color(0xFF240C37),
                          Color(0xFF061330),
                        ],
                      ),
                    ),
                    /// ### This is where the inner container starts ### ///
                    child: Column(
                      /// ### Start container columns here ### ///
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, displayHeight(context) * 0.025, 0, 0),
                          child: Column(
                            children: <Widget> [
                              Text("Total Market Cap", style: TextStyle(fontSize: 22, color: Colors.white)),
                              
                              /// ### Bloc data ### ///
                              BlocListener<GeckoGlobalStatsBloc, GeckoGlobalStatsState>(
                                listener: (context, state) {
                                  if (state is GeckoGlobalStatsErrorState) {
                                    debugPrint("error in GeckoGlobalStatsState in home_view.dart");
                                  }
                                },
                                child: BlocBuilder<GeckoGlobalStatsBloc, GeckoGlobalStatsState>( /// Both bloc types to be built (refactor existing controllers)
                                  builder: (context, state) {
                                    if (state is GeckoGlobalStatsInitialState) {
                                      debugPrint("GeckoGlobalStatsInitialState");
                                      return loadingTemplateWidget();
                                    } else if (state is GeckoGlobalStatsLoadingState) {
                                      debugPrint("GeckoGlobalStatsLoadingState");
                                      return loadingTemplateWidget();
                                    } else if (state is GeckoGlobalStatsLoadedState) {
                                      debugPrint("GeckoGlobalStatsLoadedState");
                                      return Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: <Widget> [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(numberFormatter(state.geckoGlobalStats.totalMarketCap[state.currency]), style: TextStyle(fontSize: 22, color: Colors.white)),
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
                                                        Text(state.geckoGlobalStats.totalMarketCapPct['btc'].toStringAsFixed(1) + "%", style: TextStyle(color: Colors.blueGrey[100])),
                                                      ]
                                                    ),
                                                  ),
                                                  SizedBox(width: 25),
                                                  Container(
                                                    child: Row(
                                                      children: <Widget> [
                                                        Icon(CryptoFontIcons.ETH, color: Colors.white, size: 14),
                                                        Text(state.geckoGlobalStats.totalMarketCapPct['eth'].toStringAsFixed(1) + "%", style: TextStyle(color: Colors.blueGrey[100])),
                                                      ]
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ]
                                        )
                                      );
                                    } else {
                                      return Text("Placeholder in dashboard_initial_noAPI.dart");
                                    }
                                  }
                                ),
                              ),
                              /// ### Bloc Data ends ### ///
                            ],
                          ),
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
            ]
          ),
        ),
        NoApiCategoryList(showContainer: _showContainer),
      ],
    );
  }
}

class NoApiCategoryList extends StatefulWidget {
  NoApiCategoryList({this.showContainer});

  final bool showContainer;

  @override
  NoApiCategoryListState createState() => NoApiCategoryListState();
}

class NoApiCategoryListState extends State<NoApiCategoryList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context),
      height: displayHeight(context) * 0.57,
        child: Column(
          children: <Widget> [
            Container(
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10,10,0,0),
                        child: Text("My Portfolios", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ), /// 28th
                    Container(
                      child: FutureBuilder(
                        // future: readStorage("binance"),
                        future: readStorage("portfolio"),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("None", style: TextStyle(color: Colors.white));
                            case ConnectionState.waiting:
                              return Text("Waiting", style: TextStyle(color: Colors.white));
                            default:
                            if (!snapshot.hasError) {
                              if (snapshot.data != "none") {
                                debugPrint(snapshot.data.toString());
                                analytics.logEvent(
                                  name: "check_portfolio",
                                  parameters: {"clickedFrom": "home"}
                                );
                                // log(json.decode(snapshot.data).toString());
                                // log(json.decode(snapshot.data)['ftx'].toString());
                                var data = json.decode(snapshot.data);
                                log(data.toString());
                                
                                return Container(
                                  height: 200,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget> [
                                      if(data['binance'] != null)... [
                                        BinanceTileBlurb(),
                                      ],
                                      if(data['ftx'] != null)... [
                                        PortfolioBlurb(),
                                      ],
                                      if(data['portfolios'] != null)... [
                                        for(int j = 0; data['portfolios'].length > j; j++)
                                        // for(int i = 0; 5 > i; i++)
                                        PortfolioBlurb(),
                                      ]
                                    ]
                                  ),
                                );

                                /// Get storage "portfolio" - map of portfolios
                                // return BinanceTileBlurb();
                              } else {
                                /// 28th
                                Map<String, dynamic> portfolios = {"binance": true, "ftx": false, "portfolio": {"1": true, "2": true}};
                                writeStorage("portfolio", json.encode(portfolios));
                                return AddPortfolioBlurb();
                              }
                            } else {
                              return errorTemplateWidget(snapshot.error);
                            }
                          }
                        }
                      )
                    )
                  ]
                ),
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
      height: displayHeight(context) * 0.240,
      width: displayWidth(context) * 0.4,
      child: InkWell(
        /// ### Clickable Card ### ///
        child: Container(
          decoration: BoxDecoration(
            color: appBlack, /// ### TODO: Change to Hana's UI Colour ### ///
          ),
          child: GestureDetector( /// ### TODO: Cointeam-81 ### ///
            onTap: () {
              // debugPrint("CategoryName is " + categoryName.toString());
              // BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.defiCategoryData));
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) =>
              //       DashboardWithCategoryNew(categoryName: categoryName)
              //   ),
              // );
              ///  arguments: {'categoryName': categoryName});
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
                      width: displayWidth(context) * 0.4,
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
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget> [
                                Text("Market Cap:", style: TextStyle(color: Colors.white)),
                                Text("\$182B (+8%)", style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                ),
              ]
            )
          )
        )
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
      width: displayWidth(context) * 0.4,
      child: InkWell(
        /// ### Clickable Card ### ///
        child: Container(
          decoration: BoxDecoration(
            color: appBlack, /// ### TODO: Change to Hana's UI Colour ### ///
          ),
          child: GestureDetector( /// ### TODO: Cointeam-81 ### ///
            onTap: () {
              // Navigator.pushNamed(context, '/coinview', arguments: {'cryptoData' : widget.coinListMap, 'index' : widget.index});
              // Navigator.pushNamed(
              //   context,
              //   '/dashboardwithcategory',);
              // BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.top100CategoryData));
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) =>
              //       DashboardWithCategoryNew(categoryName: categoryName)
              //   ),
              // );
              ///  arguments: {'categoryName': categoryName});
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
                      width: displayWidth(context) * 0.4,
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
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget> [
                                Text("Market Cap:", style: TextStyle(color: Colors.white)),
                                Text("\$1.43T (+6.3%)", style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  )
                ),
              ]
            )
          )
        )
      )
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
        child: Container(
          decoration: BoxDecoration(
            color: appBlack, /// ### TODO: Change to Hana's UI Colour ### ///
          ),
          child: GestureDetector( /// ### TODO: Cointeam-81 ### ///
            onTap: () {
              debugPrint("CategoryName is " + categoryName.toString());
              BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.cexDexCategoryData));
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) =>
              //       DashboardWithCategoryNew(categoryName: categoryName)
              //   ),
              // );

              ///  arguments: {'categoryName': categoryName});
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(
                height: displayHeight(context) * 0.240,
                width: displayWidth(context) * 0.4,
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
              )
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.2, 0),
                      end: Alignment(1, 0),
                      colors: [Color(0xFF282136), Color(0xFF0F1D2D)],
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
                  child: Text("LINK API", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
              onTap: () {
                /// TODO: Route to API link
                Navigator.pushNamed(context, '/second');
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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
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
              // BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent()),
              // BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
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

  final storage = FlutterSecureStorage();
  
  String value = await storage.read(key: _key);
  if (value == null) {
    log("there is no " + _key + " flutterlocalstorage");
    return "none";
  } else {
  log("there is " + _key + ": " + value + "flutterlocalstorage");
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.225,
      width: displayWidth(context) * 0.4,
      child: Expanded(
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: appBlack,
            ),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
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
                        height: displayHeight(context) * 0.225,
                        width: displayWidth(context) * 0.4,
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
                                  BlocConsumer<StartupBloc, StartupState>(
                                    listener: (context, state) {
                                      if (state is StartupErrorState) {
                                        return errorTemplateWidget("Dashboard Error in GetCoinList Data");
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is StartupLoadedState) {
                                        return Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.blue));
                                      } else if (state is StartupInitialState) {
                                        log("Initial");
                                        return Container();
                                      } else if (state is StartupLoadingState) {
                                        log("Loading");
                                        return loadingTemplateWidget();
                                      } else if (state is StartupErrorState) {
                                        log("Error");
                                        return errorTemplateWidget("Error: " + state.errorMessage);
                                      } else {
                                        log("Else");
                                        return Container();
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
      ),
    );
  }
}

class PortfolioBlurb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.225,
      width: displayWidth(context) * 0.4,
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: appBlack,
          ),
          child: GestureDetector(
            onTap: () {
              // BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
              // Navigator.pushReplacementNamed(context, '/viewportfolio');
              log("Portfolio Blurbl Clicked"); ///28th
            },
            child: Column(
              children: <Widget> [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    height: displayHeight(context) * 0.225,
                    width: displayWidth(context) * 0.4,
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
                                    child: Text("Portfolio 1", style: TextStyle(color: Colors.white))
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
                              // Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.blue)),
                              Text("\$9999.99"),
                            ]
                          )
                        )
                      ]
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


class AddPortfolioBlurb extends StatelessWidget {
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
              debugPrint("User has clicked on Add Portfolio Blurb");
              /// ### TODO: Portfolio Task
              // localStorage.setItem("prime", [].toJSONEncodable()); 
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
                      width: displayWidth(context) * 0.4,
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