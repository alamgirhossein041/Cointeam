import 'dart:developer';

import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_get_chart_bloc.dart/coingecko_get_chart_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_get_chart_bloc.dart/coingecko_get_chart_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_event.dart';
import 'package:coinsnap/v2/helpers/global_library.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/core_widgets/cards/card_list_tile.dart';
import 'package:coinsnap/v2/ui/core_widgets/cards/new_card_list_tile.dart';
import 'package:coinsnap/v2/ui/core_widgets/charts/syncfusion_chart_cartesian.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_add.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
import 'package:coinsnap/working_files/bottom_nav_bar.dart';
import 'package:coinsnap/working_files/dashboard_initial_noAPI.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/v2/asset/icon_custom/icon_custom.dart';
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;
import 'dart:math' as math;


import 'package:flutter/rendering.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardWithCategoryNew extends StatefulWidget {
  DashboardWithCategoryNew({this.categoryName});
  final Categories categoryName;
  
  @override
  DashboardWithCategoryNewState createState() => DashboardWithCategoryNewState();
}

class DashboardWithCategoryNewState extends State<DashboardWithCategoryNew> {

  List coinList;
  // bool _chartVisibility = true;


  @override
  void initState() { 
    super.initState();
    log("dashboard_with_category.dart - DashboardWithCategory() InitState()");
  }

  @override
  void didChangeDependencies() { /// ### Calls everything inside on screen load ### ///
    super.didChangeDependencies();
    log("dashboard_with_category.dart - DashboardWithCategory() DPD");
    // BlocProvider.of<GetPortfolioDataBloc>(context).add(FetchGetPortfolioDataEvent());
    // BlocProvider.of<CardCoinmarketcapCoinLatestBloc>(context).add(FetchCardCoinmarketcapCoinLatestEvent());
  }

  // void moveToAddCoinPage() async {
  //   final information = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       fullscreenDialog: true, builder: (context) => AddCoin()),
  //   );
  //   setState(() {
  //     BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
  //   });
  //   updateInformation(information);
  // }

  // updateInformation(BoxedReturns information) {
  //   if(information != null) {
  //   SnackBar snackBar = SnackBar(
  //     duration: const Duration(seconds: 3),
  //     content: Text("Adding " + information.quantityString + " " + information.coinSymbol + " to portfolio"));
  //     WidgetsBinding.instance.addPostFrameCallback((_) => 
  //       scaffold.showSnackBar(snackBar)
  //   );
  //   }

  /// HELP
    
    // setState(() => _information = information);
  // }

  double modalEdgePadding = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0D19),
      bottomNavigationBar: BottomNavBar(callBack: _callBackSetState),
      drawer: DrawerMenu(),
      body: Container(
        height: displayHeight(context),
        child: Column(
          children: <Widget> [
            // Text("Hello World", style: TextStyle(color: Colors.white))
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TopMenuRow(),
                ),
              ),
            ),
            Expanded(
              flex: 13,
              child: RefreshIndicator(
                onRefresh: () async {
                  // BlocProvider.of<GetPortfolioDataBloc>(context).add(FetchGetPortfolioDataEvent());
                  // BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
                },
                child: Container(
                  child: Column(
                  children: <Widget> [
                    // Expanded(
                    //   flex: 5,
                    //   child: HeaderBox(),
                    // ),
                    Container(
                      height: (displayHeight(context) * 0.2) + 35,
                      child: HeaderBox(),
                    ),
                    // Expanded(
                    //   flex: 2,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget> [
                    //       IconButton(
                    //         icon: Icon(Icons.add, color: Colors.white),
                    //         onPressed: () => {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(builder: (context) => AddCoin()),
                    //           )
                    //         },
                    //       ),
                    //       IconButton(
                    //         icon: Icon(Icons.stacked_line_chart, color: Colors.white),
                    //         onPressed: () => {},
                    //       ),
                    //     ]
                    //   ),
                    // ),
                    Expanded(
                      flex: 15,
                      child: BlocBuilder<ListTotalValueBloc, ListTotalValueState>(
                        builder: (context, state) {
                          if (state is ListTotalValueLoadedState) {
                            return CustomScrollView(
                              slivers: <Widget> [
                                // SliverToBoxAdapter(
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: <Widget> [
                                //       // Builder(
                                //       //   builder: (BuildContext buildContext) {
                                //       //     scaffold = Scaffold.of(buildContext);
                                //       //     return Flexible(
                                //       //   flex: 1,
                                //       //   child: IconButton(
                                //       //   icon: Icon(Icons.add, color: Colors.white),
                                //       //   onPressed: () => {
                                //       //     // Navigator.push(
                                //       //     //   context,
                                //       //     //   MaterialPageRoute(builder: (context) => AddCoin()),
                                //       //     // )
                                //       //     moveToAddCoinPage(),
                                //       //   },
                                //       //   ),
                                //       // );
                                //       // }),
                                //       // Flexible(
                                //       //   flex: 4,
                                //       //   fit: FlexFit.tight,
                                //       //   child: Align(
                                //       //     alignment: Alignment.center,
                                //       //     child: Row(
                                //       //     children: <Widget> [
                                //       //       // IconButton(
                                //       //       //   icon: Icon(Icons.hourglass_empty, color: Colors.white),
                                //       //       //   onPressed: () {
                                //       //       //     BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.daily));
                                //       //       //   }
                                //       //       // ),
                                //       //       TextButton(
                                //       //         child: Text("( 24h )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                //       //         onPressed: () {
                                //       //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.daily));
                                //       //         }
                                //       //       ),
                                //       //       TextButton(
                                //       //         child: Text("( 7d )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                //       //         onPressed: () {
                                //       //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.weekly));
                                //       //         }
                                //       //       ),
                                //       //       TextButton(
                                //       //         child: Text("( 30d )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                //       //         onPressed: () {
                                //       //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.monthly));
                                //       //         }
                                //       //       ),
                                //       //       TextButton(
                                //       //         child: Text("( 1y )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                //       //         onPressed: () {
                                //       //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.yearly));
                                //       //         }
                                //       //       ),
                                //       //     ],
                                //       //   ),
                                //       // ),
                                //       // ),
                                //       Flexible(
                                //         flex: 1,
                                //         child: IconButton(
                                //         icon: Icon(Icons.stacked_line_chart, color: Colors.white),
                                //         onPressed: () => {
                                //           setState(() {_chartVisibility = !_chartVisibility;})
                                //         }
                                //       ),
                                //       ),
                                //     ]
                                //   ),
                                // ),
                                // SliverToBoxAdapter(
                                //   child: Visibility(
                                //     visible: _chartVisibility,
                                //     child: ChartOverall(),
                                //   ),
                                // ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate((context, index) {
                                    
                                    // return NewCardListTile(coinListData: state.coinListData, coinBalancesMap: state.coinBalancesMap, totalValue: state.totalValue, index: index);
                                    
                                    return CardListTileWithCategory(coinList: state.coinList, index: index, cardCoinmarketcapListModel: state.cardCoinmarketcapListModel);
                                    },
                                    childCount: (state.coinList.length - 1),
                                    // childCount: state.coinListData.data.length,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }
                      ),
                    ),
                  ]
                )
                // HeaderBox(),
              ),)
            ),
          ]
        )
      ),
    );


    /// ### If Bloc hasn't returned yet, display splash screen(?) ### ///
    
    
    // return BlocConsumer<GetCoinListBloc, GetCoinListState>(
    //   listener: (context, state) {
    //     if (state is GetCoinListErrorState) {
    //       log("error in GetCoinListState in home_view.dart");
    //       Navigator.of(context).pushNamed('/errorscreen');
    //     } else if (state is GetCoinListCoinListState) {
    //       coinList = state.coinList;
    //       /// Navigator.of(context).pushNamed('AHHHHHH'); ### Set up splash screen bloc? Or not
    //     }
    //     /// } else if (state is GetPortfolioDispatchChartState) {
    //       /// TODO: dispatch chart bloc
    //   },
    //   builder: (context, state) {
    //     if (state is GetCoinListLoadedState) {   /// ### Comes with state.coinListData -- type CardCoinmarketcapListModel
    //       log("GetCoinListLoadedState");
    //       return 
    //     } else {
    //       log("GetCoinListLoadingState");
    //       return CircularProgressIndicator();
    //     }
    //   }
    // );
  }

  /// ### Callback function for child widget to setState (and refresh) on this widget ### ///
  void _callBackSetState() {
    setState(() {
      log("Hello World");
      BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
      /// 19th
    });
  }
}

class HeaderBox extends StatefulWidget {
  // const HeaderBox({Key key, this.isRefresh}) : super(key: key);

  // final bool isRefresh;
  @override
  HeaderBoxState createState() => HeaderBoxState();
}

class HeaderBoxState extends State<HeaderBox> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    log("dashboard.dart -> HeaderBox() DPD");
    // BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    double heightContainer = displayHeight(context) * 0.2;
    double heightOffset = 35;
    return Column(
      children: <Widget> [
        Container(
          height: heightContainer + heightOffset,
          // duration: Duration(seconds: 2),
          // curve: Curves.fastLinearToSlowEaseIn,
          child: Stack(
            children: <Widget> [
              Column(
                children: <Widget> [
                  Container(
                    height: heightContainer,
                    decoration: headerBoxDecoration,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0,2.75,0,2.75),
                      child: Container(
                        decoration: headerBoxInnerDecoration,
                        child: BlocConsumer<GetCoinListBloc, GetCoinListState>(
                          listener: (context, state) {
                            if (state is GetCoinListErrorState) {
                              log("GetCoinListErrorState");
                            }
                          },
                          builder: (context, state) {
                            if (state is GetCoinListLoadedState) {
                              if(state.coinList.length > 0) {

                              log("GetCoinListLoadedState");
                              log("########Double checking dev logs##########");

                              /// 21st
                              
                                // BlocProvider.of<CoingeckoGetChartBloc>(context).add(FetchCoingeckoGetChartEvent(coinList: state.coinList, coinBalancesMap: state.coinBalancesMap));
                                BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: ''));
                                BlocProvider.of<GetCoinListTotalValueBloc>(context).add(FetchGetCoinListTotalValueEvent(coinList: state.coinList, coinBalancesMap: state.coinBalancesMap));
                                
                              } else {
                                log("coinList == 0");
                              }
                              
                              return BlocConsumer<GetCoinListTotalValueBloc, GetCoinListTotalValueState>(
                                listener: (context, state) {
                                  if (state is GetCoinListTotalValueErrorState) {
                                    log("GetCoinListTotalValueErrorState");
                                  }
                                },
                                builder: (context, state) {
                                  if (state is GetCoinListTotalValueLoadedState) {
                                    return Column(
                                      children: <Widget> [
                                        // Flexible(
                                        //   flex: 1,
                                        //   fit: FlexFit.tight,
                                        //   child: Align(
                                        //     alignment: Alignment.topRight,
                                        //     child: Text("BTC: \$" + state.btcSpecial.toStringAsFixed(2))
                                        //   ),
                                        // ),
                                        Flexible(
                                          flex: 3,
                                          // child: Padding(
                                            // padding: EdgeInsets.only(top: 20),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Container(),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: HeaderBoxWalletIcon(),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Padding(
                                                      padding: EdgeInsets.fromLTRB(0,10,10,0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget> [
                                                          Text("BTC: \$" + state.btcSpecial.toStringAsFixed(0), style: TextStyle(fontSize: 14)), /// 25th
                                                          SizedBox(height: 2.5),
                                                          Text("ETH: \$" + state.ethSpecial.toStringAsFixed(0), style: TextStyle(fontSize: 14)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            // ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 4,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              children: <Widget> [
                                                Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(fontSize: 22, color: Colors.white)),
                                                SizedBox(height: 5),
                                                Text("B: " + (state.totalValue / state.btcSpecial).toStringAsFixed(8), style: TextStyle(fontSize: 16, color: Colors.white)),
                                              ]
                                            ),
                                          ),
                                        ),
                                      ]
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                                    // Text("\$26,646.23", style: TextStyle(fontSize: 22, color: Colors.white)),
                                // ]
                              // );
                            } else {
                              log("GetCoinList(notloaded)State");
                              return loadingTemplateWidget();
                            }
                          }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: heightContainer + heightOffset,
                child: FutureBuilder( /// ### Panic Action Button ### ///
                  future: readStorage("trading"), /// ### Dev-Check-1
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
            ],
          )
        )
      ]
    );
  }
}

class HeaderBoxWalletIcon extends StatelessWidget {
  const HeaderBoxWalletIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ### Size of wallet icon ### ///
      height: 31.43,
      width: 36.23,
      child: Column(
        children: <Widget> [
          Expanded(
            child: Transform.rotate(
              angle: -5 * math.pi / 180,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(IconCustom.wallet_tilt, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

var headerBoxDecoration = BoxDecoration(
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
);

var headerBoxInnerDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment(-1.25, -1.15),
    end: Alignment(0.85, 1.1),
    colors: [
      Color(0xFF240C37),
      Color(0xFF061330),
      // Colors.white,
    ],
  ),
);

class BoxedReturns {
  final String coinSymbol;
  final String quantityString;

  BoxedReturns(this.coinSymbol, this.quantityString);
}