import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_bloc.dart';
import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_event.dart';
import 'package:coinsnap/modules/chart/widgets/chart_portfolio.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/portfolio/pages/portfolio_dashboard.dart';
import 'package:coinsnap/modules/portfolio/widgets/coin_tile.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;

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
            SizedBox(height: 65),
            Expanded(
              flex: 10,
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
                                    return NewCardListTile(coinListData: state.coinListData, coinBalancesMap: state.coinBalancesMap, totalValue: state.totalValue, index: index, portfolioMap: state.portfolioMap);
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