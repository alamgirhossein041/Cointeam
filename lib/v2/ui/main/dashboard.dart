import 'package:flutter/material.dart';

import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_event.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/widgets/core_widgets/cards/new_card_list_tile.dart';
import 'package:coinsnap/v2/ui/widgets/core_widgets/charts/syncfusion_chart_cartesian.dart';
import 'package:coinsnap/v2/ui/widgets/core_widgets/coins/coin_add.dart';
import 'package:coinsnap/v2/ui/widgets/helper_widgets/loading_screen.dart';
import 'package:coinsnap/working_files/bottom_nav_bar.dart';
import 'package:coinsnap/working_files/dashboard_initial_noAPI.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/v2/asset/icon_custom/icon_custom.dart';
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;
import 'dart:math' as math;


import 'package:flutter/rendering.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  List coinList;
  bool _chartVisibility = true;
  ScaffoldState scaffold;


  @override
  void initState() { 
    super.initState();
  }

  @override
  void didChangeDependencies() { /// ### Calls everything inside on screen load ### ///
    super.didChangeDependencies();
  }

  void moveToAddCoinPage() async {
    final information = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(name: '/addcoin'),
        fullscreenDialog: true, builder: (context) => AddCoin()),
    );
    setState(() {
      BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
    });
    updateInformation(information);
  }

  updateInformation(BoxedReturns information) {
    if(information != null) {
    SnackBar snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Text("Adding " + information.quantityString + " " + information.coinSymbol + " to portfolio"));
      WidgetsBinding.instance.addPostFrameCallback((_) => 
        scaffold.showSnackBar(snackBar)
      );
    }
  }

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
                  BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
                },
                child: Container(
                  child: Column(
                  children: <Widget> [
                    Container(
                      height: (displayHeight(context) * 0.2) + 35,
                      child: HeaderBox(),
                    ),
                    Expanded(
                      flex: 15,
                      child: BlocBuilder<GetCoinListTotalValueBloc, GetCoinListTotalValueState>(
                        builder: (context, state) {
                          if (state is GetCoinListTotalValueLoadedState) {
                            return CustomScrollView(
                              slivers: <Widget> [
                                SliverToBoxAdapter(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget> [
                                      Builder(
                                        builder: (BuildContext buildContext) {
                                          scaffold = Scaffold.of(buildContext);
                                          return Flexible(
                                            flex: 1,
                                            child: IconButton(
                                            icon: Icon(Icons.add, color: Colors.white),
                                            onPressed: () => {
                                              moveToAddCoinPage(),
                                            },
                                          ),
                                        );
                                      }),
                                      Flexible(
                                        flex: 4,
                                        fit: FlexFit.tight,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                          children: <Widget> [
                                            TextButton(
                                              child: Text("( 24h )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                              onPressed: () {
                                                BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.daily));
                                              }
                                            ),
                                            TextButton(
                                              child: Text("( 7d )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                              onPressed: () {
                                                BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.weekly));
                                              }
                                            ),
                                            TextButton(
                                              child: Text("( 30d )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                              onPressed: () {
                                                BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.monthly));
                                              }
                                            ),
                                            TextButton(
                                              child: Text("( 1y )", style: TextStyle(color: Colors.white, fontSize: 14)),
                                              onPressed: () {
                                                BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: globals.Status.yearly));
                                              }
                                            ),
                                          ],
                                        ),
                                      ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: IconButton(
                                        icon: Icon(Icons.stacked_line_chart, color: Colors.white),
                                        onPressed: () => {
                                          setState(() {_chartVisibility = !_chartVisibility;})
                                        }
                                      ),
                                      ),
                                    ]
                                  ),
                                ),
                                SliverToBoxAdapter(
                                  child: Visibility(
                                    visible: _chartVisibility,
                                    child: ChartOverall(),
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate((context, index) {
                                    // return NewCardListTile(coinListData: state.coinListData, state.coinListData, state.totalValue);
                                    return NewCardListTile(coinListData: state.coinListData, coinBalancesMap: state.coinBalancesMap, totalValue: state.totalValue, index: index);
                                      // child: Text("Hello World", style: TextStyle(color: Colors.white, fontSize: 20)));
                                    },
                                    childCount: state.coinListData.data.length,
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
              ),
              )
            ),
          ]
        )
      ),
    );
  }

  /// ### Callback function for child widget to setState (and refresh) on this widget ### ///
  void _callBackSetState() {
    setState(() {
      debugPrint("Hello World");
      BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
      /// 19th
    });
  }
}

class HeaderBox extends StatefulWidget {
  @override
  HeaderBoxState createState() => HeaderBoxState();
}

class HeaderBoxState extends State<HeaderBox> {
  @override
  Widget build(BuildContext context) {
    double heightContainer = displayHeight(context) * 0.2;
    double heightOffset = 35;
    return Column(
      children: <Widget> [
        Container(
          height: heightContainer + heightOffset,
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
                              debugPrint("GetCoinListErrorState");
                            }
                          },
                          builder: (context, state) {
                            if (state is GetCoinListLoadedState) {
                              if(state.coinList.length > 0) {
                              debugPrint("GetCoinListLoadedState");
                                BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: ''));
                                BlocProvider.of<GetCoinListTotalValueBloc>(context).add(FetchGetCoinListTotalValueEvent(coinList: state.coinList, coinBalancesMap: state.coinBalancesMap));
                              } else {
                                debugPrint("coinList == 0");
                              }
                              
                              return BlocConsumer<GetCoinListTotalValueBloc, GetCoinListTotalValueState>(
                                listener: (context, state) {
                                  if (state is GetCoinListTotalValueErrorState) {
                                    debugPrint("GetCoinListTotalValueErrorState");
                                  }
                                },
                                builder: (context, state) {
                                  if (state is GetCoinListTotalValueLoadedState) {
                                    return Column(
                                      children: <Widget> [
                                        Flexible(
                                          flex: 3,
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
                            } else {
                              debugPrint("GetCoinList(notloaded)State");
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
                        // debugPrint(snapshot.data.toString());
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