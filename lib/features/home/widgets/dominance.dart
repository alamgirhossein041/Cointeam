import 'dart:developer';

import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DominanceWidget extends StatefulWidget {

  @override
  _DominanceWidgetState createState() => _DominanceWidgetState();
}

class _DominanceWidgetState extends State<DominanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text('Dominance'),
          /// Bloc Coingecko info retrieval
          BlocConsumer<GeckoGlobalStatsBloc, GeckoGlobalStatsState>(
            listener: (context, state) {
              if (state is GeckoGlobalStatsErrorState) {
                log("Error in dominance.dart _DominanceWidgetState");
              }
            },
            builder: (context, state) {
              if (state is GeckoGlobalStatsLoadedState) {
                return Row(
                  children: <Widget> [
                    Text('BTC: ' + state.geckoGlobalStats.totalMarketCapPct['btc'].toStringAsFixed(0) + '%'),
                    Text('  ETH: ' + state.geckoGlobalStats.totalMarketCapPct['eth'].toStringAsFixed(0) + '%'),
                  ]
                );
              } else if (state is GeckoGlobalStatsErrorState) {
                return Text("An error has occured, CoinGecko-related.");
              } else {
                return Row(
                  children: <Widget> [
                    Text('BTC: ' ),
                    loadingTemplateWidget(16,2),
                    Text('  '),
                    Text('ETH:  '),
                    loadingTemplateWidget(16,2),
                  ]
                );
              }
            }
          )
          /// End bloc
        ],
      ),
    );
  }
}