import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import '../widgets/animated_ticker.dart';

import 'dart:developer';

class CoinTicker extends StatefulWidget {

  @override
  CoinTickerState createState() => CoinTickerState();
}

class CoinTickerState extends State<CoinTicker> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartupBloc, StartupState>(
      listener: (context, state) {
        if (state is StartupErrorState) {
          return errorTemplateWidget("Dashboard Error in GetCoinList Data");
        }
      },
      builder: (context, state) {
        if (state is StartupLoadedState) {
          log("Loaded");
            
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
          return Row(
            children: <Widget> [
              AnimatedTicker(btcSpecial: state.btcSpecial, ethSpecial: state.ethSpecial),
            ]
          );
        } else if (state is StartupInitialState) {
          log("Initial");
          return Container();
        } else if (state is StartupLoadingState) {
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
        } else if (state is StartupErrorState) {
          log("Error");
          return errorTemplateWidget("Error: " + state.errorMessage);
        } else {
          return Text("Else", style: TextStyle(color: Colors.black, fontSize: 32));
        }
      }
    );
  }
}