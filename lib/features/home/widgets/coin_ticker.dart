import 'package:coinsnap/features/market/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import '../widgets/animated_ticker.dart';

import 'dart:developer';

class CoinTicker extends StatefulWidget {
  @override
  CoinTickerState createState() => CoinTickerState();
}

class CoinTickerState extends State<CoinTicker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoingeckoListTop100Bloc, CoingeckoListTop100State>(
      listener: (context, state) {
        if (state is CoingeckoListTop100ErrorState) {
          return errorTemplateWidget("CoinTicker Error from CoingeckoListTop100Bloc");
        }
      },
      builder: (context, state) {
        if (state is CoingeckoListTop100LoadedState) {
          // return Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: EdgeInsets.only(right: 20),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget> [
          //         Text("BTC:  \$" + state.btcSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
          //         Text("ETH:  \$" + state.ethSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
          //       ]
          //     )
          //   ),

          // );
          return Container(
            margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Row(children: <Widget>[
              Icon(Icons.preview_outlined, color: primaryLight, size: 20),
              SizedBox(width: 8),
              AnimatedTicker(coinTickerMarqueeText: state.coinTickerMarqueeText),
            ]),
          );
        } else if (state is CoingeckoListTop100InitialState) {
          log("Initial");
          return Container();
        } else if (state is CoingeckoListTop100LoadingState) {
          log("Loading");
          return loadingTemplateWidget();
          // } else if (state is StartupTotalValueState) {
          //   log("TotalValueState");
          //   return Align(
          //     alignment: Alignment.topRight,
          //     child: Padding(
          //       padding: EdgeInsets.only(right: 20),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget> [
          //           Text("BTC:  \$" + state.btcSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
          //           Text("ETH:  \$" + state.ethSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
          //         ]
          //       )
          //     ),
          //   );
        } else if (state is CoingeckoListTop100ErrorState) {
          log("Error");
          // return errorTemplateWidget("Error: " + state.errorMessage);

          return Container(
            // margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            // child: Row(
            //   children: <Widget>[
            //     Icon(Icons.preview_outlined, color: primaryLight, size: 20),
            //     SizedBox(width: 8),
            //     AnimatedTicker(btcSpecial: 123456.12, ethSpecial: 2312.0434),
            //   ],
            // ),
          );
        } else {
          return Text(
            "Else",
            style: TextStyle(color: Colors.black, fontSize: 32),
          );
        }
      },
    );
  }
}
