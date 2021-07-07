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
  bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() => _isOpen = !_isOpen);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Dominance'),
            SizedBox(height: 10),
            _isOpen
                ?

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Text(
                                'BTC: ' +
                                    state.geckoGlobalStats
                                        .totalMarketCapPct['btc']
                                        .toStringAsFixed(0) +
                                    '%',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                'ETH: ' +
                                    state.geckoGlobalStats
                                        .totalMarketCapPct['eth']
                                        .toStringAsFixed(0) +
                                    '%',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ],
                        );
                      } else if (state is GeckoGlobalStatsErrorState) {
                        return Text("An error has occured, CoinGecko-related.");
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'BTC:  ',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  loadingTemplateWidget(10, 2),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'ETH:  ',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                loadingTemplateWidget(10, 2),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Text(
                          'BTC: \$12,435.65',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Text(
                          'ETH: \$12,435.65',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
