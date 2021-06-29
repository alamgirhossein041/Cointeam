import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/home/widgets/my_coins_button.dart';
import 'package:coinsnap/features/my_coins/pages/my_coins.dart';
import 'package:flutter/material.dart';

// Packages
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/utils/time_sync/repos/binance_time_sync.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import '../../../ui_components/ui_components.dart';

// Widgets
import '../widgets/coin_ticker.dart';
import '../widgets/panic_button.dart';
import '../widgets/home_button.dart';
import '../widgets/market_button.dart';
import '../widgets/total_value.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  BinanceTimeSyncRepositoryImpl helloWorld;
  
  @override
  void initState() { 
    super.initState();
    BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
    helloWorld = BinanceTimeSyncRepositoryImpl();
    helloWorld.getBinanceTimeSyncLatest();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              CoinTicker(),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPadding(),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    // Image(
                    //   image: AssetImage('graphics/assets/svg/bolt_transp.svg'),
                    // ),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 14),
                        child: Text('Balance'),
                      ),
                    ]),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 14),
                        child: Text('\$12,345.67',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                  // Flexible(
                  //   flex: 4,
                  //   fit: FlexFit.tight,
                  //   child: Stack(
                  //     children: <Widget> [
                  //       Center(
                  //         child: Text(
                  //           "Total Value", style: TextStyle(fontSize: 28, color: primaryDark)
                  //         )
                  //       ),
                  //       Center(
                  //         /// Total Value Bloc
                  //         // child: Text("\$14,141.51", style: TextStyle(fontSize: 34, color: Colors.black))
                  //         child: TotalValue(),
                  //       ),
                  //     ]
                  //   )
                  // ),
                  SizedBox(
                    height: displayHeight(context) * 0.05
                  ),
                  Flexible(
                    flex: 10,
                    fit: FlexFit.tight,
                    child: PanicButton(),
                  ),
                  Flexible(
                    flex: 10,
                    fit: FlexFit.tight,
                    child: Column(
                      children: <Widget> [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            HomeButton(),
                            HomeButton(),
                          ]
                        ),
                        SizedBox(height: displayHeight(context) * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            HomeButton(),
                            HomeButton(),
                          ]
                        ),
                        SizedBox(height: displayHeight(context) * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            MyCoinsButton(),
                            MarketButton(),
                          ]
                        ),
                      ]
                    )
                  ),
                ]
              )
            ),
          ]
          )
        )
      ),
    );
  }
}

class AnimatedTicker extends StatefulWidget {
  final double btcSpecial;
  final double ethSpecial;
  AnimatedTicker({this.btcSpecial, this.ethSpecial});

  @override
  AnimatedTickerState createState() => AnimatedTickerState();
}

class AnimatedTickerState extends State<AnimatedTicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Text("BTC  \$" + widget.btcSpecial.toStringAsFixed(0) + "       ETH  \$" + widget.ethSpecial.toStringAsFixed(0), style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))
    );
  }
}
