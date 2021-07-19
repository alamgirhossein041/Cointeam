import 'dart:developer';

import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/market/bloc/coingecko_list_top_100_bloc.dart';
import 'package:coinsnap/features/market/bloc/coingecko_list_top_100_state.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/number_formatter.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketOverview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Market'),
          ),
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Market Overview"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPadding(),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: MarketOverviewMarketCap(),
                      /// Widget 1
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: MarketOverviewDominance(),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: MarketOverviewTop100(),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: MarketOverviewTrending(),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      // child: Text("Hi")
                      child: SizedBox(),
                    ),
                  ]
                )
              )
            ]
          )
        )
      ),
    );
  }
}

class MarketOverviewMarketCap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Text("Total Market Cap"),
        BlocConsumer<GeckoGlobalStatsBloc, GeckoGlobalStatsState>(
          listener: (context, state) {
            if (state is GeckoGlobalStatsErrorState) {
              debugPrint("An error occured in market_overview.dart");
              log("An error occured in market_overview.dart");
            }
          },
          builder: (context, state) {
            if (state is GeckoGlobalStatsLoadedState) {
              return Text(numberFormatter(state.geckoGlobalStats.totalMarketCap['usd']).toString());
            } else if (state is GeckoGlobalStatsErrorState) {
              return Text("CoinGecko data error");
            } else {
              return loadingTemplateWidget();
            }
          }
        )
      ]
    );
  }
}

class MarketOverviewDominance extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Text("Dominance"),
        BlocConsumer<GeckoGlobalStatsBloc, GeckoGlobalStatsState>(
          listener: (context, state) {
            if (state is GeckoGlobalStatsErrorState) {
              debugPrint("An error occured in market_overview.dart MarketOverviewDominance");
              log("An error occured in market_overview.dart MarketOverviewDominance");
            }
          },
          builder: (context, state) {
            if (state is GeckoGlobalStatsLoadedState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text('BTC: ' + state.geckoGlobalStats.totalMarketCapPct['btc'].toStringAsFixed(1) + "%"),
                  SizedBox(width: 35),
                  Text('ETH: ' + state.geckoGlobalStats.totalMarketCapPct['eth'].toStringAsFixed(1) + "%")
                ],
              );
            } else if (state is GeckoGlobalStatsErrorState) {
              return Text("CoinGecko data error");
            } else {
              return loadingTemplateWidget();
            }
          }
        )
      ]
    );
  }
}

class MarketOverviewContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Text("Dominance"),
        BlocConsumer<GeckoGlobalStatsBloc, GeckoGlobalStatsState>(
          listener: (context, state) {
            if (state is GeckoGlobalStatsErrorState) {
              debugPrint("An error occured in market_overview.dart MarketOverviewDominance");
              log("An error occured in market_overview.dart MarketOverviewDominance");
            }
          },
          builder: (context, state) {
            if (state is GeckoGlobalStatsLoadedState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget> [
                  Text(state.geckoGlobalStats.totalMarketCapPct['btc'].toStringAsFixed(1) + "%"),
                  SizedBox(width: 35),
                  Text(state.geckoGlobalStats.totalMarketCapPct['eth'].toStringAsFixed(1) + "%")
                ],
              );
            } else if (state is GeckoGlobalStatsErrorState) {
              return Text("CoinGecko data error");
            } else {
              return loadingTemplateWidget();
            }
          }
        )
      ]
    );
  }
}

class MarketOverviewTop100 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Text("Top 100"),
        BlocConsumer<CoingeckoListTop100Bloc, CoingeckoListTop100State>(
          listener: (context, state) {
            if (state is CoingeckoListTop100ErrorState) {
              debugPrint("An error occured in market_overview.dartMarketOverviewTop100");
              log("An error occured in market_overview.dart MarketOverviewTop100");
            }
          },
          builder: (context, state) {
            if (state is CoingeckoListTop100LoadedState) {
              log(state.coingeckoModelList.length.toString());
              // return Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget> [
              //     // Text("This should be a sideways list"),
              //     Text(state.coingeckoModelList[1].id.toString()),
              //   ],
              // );

              return MarketOverviewListView(coingeckoModelList: state.coingeckoModelList);
              // return Container(
              //   height: 100,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: state.coingeckoModelList.length,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text(state.coingeckoModelList[index].id),
              //         body: state.coingeckoModelList[index].
              //       );
              //       // return Text("Hi");
              //     }
              //   )
              // );
            } else if (state is CoingeckoListTop100ErrorState) {
              return Text("CoinGecko data error");
            } else {
              return loadingTemplateWidget();
            }
          }
        )
      ]
    );
  }
}



/// Create a list tile
/// 
/// https://api.flutter.dev/flutter/material/ListTile-class.html
/// 
/// "The ListTile Layout isn't exactly what I want"
/// 
/// Our values are:

// Id
// Image
// Listupdated 
// Marketcap 
// Marketcaprank 
// Name 
// Pricechange24h
// Pricechangepercentage1h/24h/7dincurrency
// Pricechangepercentage24h
// Symbol
// Totasupply

class MarketOverviewListView extends StatelessWidget {
  const MarketOverviewListView({
    Key key,
    @required this.coingeckoModelList,
  }) : super(key: key);

  final List coingeckoModelList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // TODO: FIX?
      child: ListView.builder(
        itemCount: coingeckoModelList.length,
        itemExtent: 80.0, // sets default width
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MarketOverviewCustomTile(coingeckoModel: coingeckoModelList[index]);
        }
      )
    );
  }
}

class MarketOverviewCustomTile extends StatelessWidget {
  const MarketOverviewCustomTile({
    Key key,
    @required this.coingeckoModel,
  }) : super(key: key);

  final coingeckoModel;

  @override
  Widget build(BuildContext context) {
    // log(coingeckoModel.id.toString());
    // log(coingeckoModel.symbol.toString());
    // log(coingeckoModel.name.toString());
    // log(coingeckoModel.image.toString());
    // log(coingeckoModel.currentPrice.toString());
    // log(coingeckoModel.marketCap.toString());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        child: Column(
          children: <Widget> [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.network(coingeckoModel.image),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(coingeckoModel.symbol),
            ),
          ]
        )
      )
    );
  }
}

class MarketOverviewTrending extends StatelessWidget {
  const MarketOverviewTrending({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Text("Trending"),
        BlocConsumer<CoingeckoListTrendingBloc, CoingeckoListTrendingState>(
          listener: (context, state) {
            if (state is CoingeckoListTrendingErrorState) {
              debugPrint("An error occured in market_overview.dart MarketOverviewTrending");
              log("An error occurred in market_overview.dart MarketOverviewTrending");
              log(state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is CoingeckoListTrendingLoadedState) {
              log(state.coingeckoModelList.length.toString());
              return MarketOverviewListView(coingeckoModelList: state.coingeckoModelList);
            } else if (state is CoingeckoListTrendingErrorState) {
              return Text("CoinGecko data error");
            } else {
              return loadingTemplateWidget();
            }
          }
        )
      ]
    );
  }
}