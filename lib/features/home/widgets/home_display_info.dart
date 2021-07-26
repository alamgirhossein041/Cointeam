import 'dart:developer';

import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/home/widgets/dominance.dart';
import 'package:coinsnap/features/utils/number_formatter.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class HomeDisplayInfo extends StatefulWidget {
  @override
  _HomeDisplayInfoState createState() => _HomeDisplayInfoState();
}

class _HomeDisplayInfoState extends State<HomeDisplayInfo> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// State bloc info retrieval for total balance
          BlocConsumer<StartupBloc, StartupState>(
            listener: (context, state) {
              if (state is StartupErrorState) {
                log("Error in home_display_info.dart _HomeDisplayInfoState");
              }
            },
            builder: (context, state) {
              if (state is StartupLoadedState) {
                return Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text('Balance'),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          '\$' + state.totalValue.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is StartupErrorState) {
                return Expanded(
                  flex: 1,
                  child: Text(
                    "Connect your API to get started.", // TODO: A button that takes user to API linking
                    style: Theme.of(context).textTheme.headline2,
                  ),
                );
                // Text("An error has occurred, Binance-related.",
                // style: Theme.of(context).textTheme.headline1);
              } else {
                return Column(
                  children: <Widget>[
                    loadingTemplateWidget(),
                    SizedBox(height: 10),
                  ],
                );
              }
            },
          ),
          Flexible(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Text('Total Market Cap'),
                      ),
                      Flexible(
                        flex: 1,
                        child: BlocConsumer<GeckoGlobalStatsBloc, GeckoGlobalStatsState>(
                          listener: (context, state) {
                            if (state is GeckoGlobalStatsErrorState) {
                              debugPrint("An error occured in market_overview.dart");
                              log("An error occured in market_overview.dart");
                            }
                          },
                          builder: (context, state) {
                            if (state is GeckoGlobalStatsLoadedState) {
                              return Text(numberFormatter(state.geckoGlobalStats.totalMarketCap[state.currency]).toString(),
                                style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.w300));
                            } else if (state is GeckoGlobalStatsErrorState) {
                              return Text("CoinGecko data error");
                            } else {
                              return loadingTemplateWidget();
                            }
                          }
                        )
                        
                        
                        
                        

                        
                        // Text(
                        //   '\$2.1T',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .headline3
                        //       .copyWith(fontWeight: FontWeight.w300),
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: DominanceWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
