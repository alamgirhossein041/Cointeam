import 'package:coinsnap/assets/icon_custom/icon_custom.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_bloc.dart';
import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_event.dart';
import 'package:coinsnap/modules/chart/widgets/chart_portfolio.dart';
import 'package:coinsnap/modules/portfolio/widgets/coin_tile.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;
import 'dart:math' as math;

class Portfolio extends StatefulWidget {

  @override
  PortfolioState createState() => PortfolioState();
}

class PortfolioState extends State<Portfolio> {
  bool _chartVisibility = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0D19),
      body: Container(
        height: displayHeight(context),
        child: Column(
          children: <Widget> [
            SizedBox(height: 35),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                          // scaffoldState.currentState.openDrawer();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
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
                      child: BlocBuilder<StartupBloc, StartupState>(
                        builder: (context, state) {
                          if (state is StartupLoadedState) {
                            return CustomScrollView(
                              slivers: <Widget> [
                                SliverToBoxAdapter(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget> [
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
        ),
      ),
    );
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
                        child: BlocConsumer<StartupBloc, StartupState>(
                          listener: (context, state) {
                            if (state is StartupErrorState) {
                              debugPrint("StartupErrorState in dashboard.dart");
                              errorTemplateWidget(state.errorMessage);
                            }
                          },
                          builder: (context, state) {
                            if (state is StartupLoadedState) {
                              if(state.coinList.length > 0) {
                              debugPrint("StartupLoadedState");
                                BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinList, binanceGetPricesMap: state.coinBalancesMap, timeSelection: ''));
                              } else {
                                debugPrint("coinList == 0");
                              }
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
                            }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Container(
              //   height: heightContainer + heightOffset,
              //   child: FutureBuilder( /// ### Panic Action Button ### ///
              //     future: readStorage("trading"), /// ### Dev-Check-1
              //     builder: (context, snapshot) {
              //       switch (snapshot.connectionState) {
              //         case ConnectionState.none:
              //         case ConnectionState.waiting:
              //           return CircularProgressIndicator();
              //         default:
              //         if (!snapshot.hasError) {
              //           // debugPrint(snapshot.data.toString());
              //           /// ("Return a welcome screen") ??? default comment
              //             // return DashboardWithNoApiWorking();
              //           if (snapshot.data == "none") {
              //             return EnableTradingButton();
              //           } else {
              //             return PanicActionButton();
              //           }
              //         } else {
              //           return errorTemplateWidget(snapshot.error);
              //         }
              //       }
              //     },
              //   ),
              // ),
            ],
          )
        )
      ]
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
  )
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