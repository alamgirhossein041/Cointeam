import 'dart:developer';

import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          children: <Widget>[
            Text('Dominance'),
            SizedBox(height: 6),
            _isOpen
                ?

                /// Bloc Coingecko info retrieval
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 100),
                    child: BlocConsumer<GeckoGlobalStatsBloc,
                        GeckoGlobalStatsState>(
                      listener: (context, state) {
                        if (state is GeckoGlobalStatsErrorState) {
                          log("Error in dominance.dart _DominanceWidgetState");
                        }
                      },
                      builder: (context, state) {
                        if (state is GeckoGlobalStatsLoadedState) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'graphics/assets/svg/btc_dominance.svg',
                                          height: 13,
                                        ),
                                        Text(
                                          ' ' +
                                              state.geckoGlobalStats
                                                  .totalMarketCapPct['btc']
                                                  .toStringAsFixed(0) +
                                              '%',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'graphics/assets/svg/eth_dominance.svg',
                                          height: 13,
                                        ),
                                        Text(
                                          ' ' +
                                              state.geckoGlobalStats
                                                  .totalMarketCapPct['eth']
                                                  .toStringAsFixed(0) +
                                              '%',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        } else if (state is GeckoGlobalStatsErrorState) {
                          return Text(
                              "An error has occured, CoinGecko-related.");
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'graphics/assets/svg/btc_dominance.svg',
                                      height: 13,
                                    ),
                                    SizedBox(width: 2),
                                    loadingTemplateWidget(10, 2),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'graphics/assets/svg/eth_dominance.svg',
                                    height: 13,
                                  ),
                                  SizedBox(width: 2),
                                  loadingTemplateWidget(10, 2),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  )
                : AnimatedSwitcher(
                    duration: Duration(milliseconds: 100),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                'graphics/assets/svg/btc_dominance.svg',
                                height: 13,
                              ),
                              Text(
                                ' \$12,435.65',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1),
                                child: SvgPicture.asset(
                                  'graphics/assets/svg/eth_dominance.svg',
                                  height: 13,
                                ),
                              ),
                              Text(
                                ' \$3,519.03',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
