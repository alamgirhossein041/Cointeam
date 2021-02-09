import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui/template/home_content.dart';
import 'package:coinsnap/ui/template/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer';

class PriceContainer extends StatefulWidget {
  PriceContainer({Key key}) : super(key: key);

  @override
  PriceContainerState createState() => PriceContainerState();
}

class PriceContainerState extends State<PriceContainer> {

  GetTotalValueBloc getTotalValueBloc;

  @override
  void initState() {
    super.initState();
    getTotalValueBloc = BlocProvider.of<GetTotalValueBloc>(context);
    getTotalValueBloc.add(FetchGetTotalValueEvent());
  }

  @override
  Widget build(BuildContext context) {
    double tmpBtcSpecial = 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.blue, appPurple],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: displayHeight(context) * 0.17,
      width: displayWidth(context) * 0.85,
      child: Row(
        // mainAxisAlignment = MainAxisAlignment.spaceEvenly,
        children: <Widget> [
          SizedBox(width: displayWidth(context) * 0.3),
          Column (
            children: <Widget> [
              // InnerHomeView(),
              BlocListener<GetTotalValueBloc, GetTotalValueState>(
                listener: (context, state) {
                  if (state is GetTotalValueErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)),
                    );
                  }
                },
                child: BlocBuilder<GetTotalValueBloc, GetTotalValueState>( /// Both bloc types to be built (refactor existing controllers)
                  builder: (context, state) {
                    if (state is GetTotalValueInitialState) {
                      log("GetTotalValueInitialState");
                      return buildLoadingTemplate();
                    } else if (state is GetTotalValueLoadingState) {
                      log("GetTotalValueLoadingState");
                      // return buildLoadingTemplate();
                      // return buildGetTotalValue(tmpTotalValue, tmpBtcSpecial);
                      return buildGetTotalValue(0, 0);
                    } else if (state is GetTotalValueLoadedState) {
                      log("GetTotalValueLoadedState");
                      // tmpTotalValue = state.totalValue;
                      tmpBtcSpecial = state.btcSpecial;
                      return Container(
                        child: buildGetTotalValue(state.totalValue, state.btcSpecial)
                        // child: Row(
                        //   children: <Widget> [
                        //     // SizedBox(width: displayWidth(context) * 0.1),
                        //     buildGetTotalValue(state.totalValue, state.btcSpecial),
                        //     Column( /// refactor into a function like buildGetTotalValue
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       children: <Widget> [
                        //         buildTicker(context, tmpBtcSpecial),
                        //       ]
                        //     ),
                        //   ]
                        // ),
                      );
                    } else if (state is GetTotalValueErrorState) {
                      log("GetTotalValueErrorState");
                      return buildErrorTemplate(state.errorMessage);
                    } else {
                      return null;
                    }
                  }
                ),
              ),
            ]
          ),

          SizedBox(width: displayWidth(context) * 0.22),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: <Widget> [
          //     buildTicker(context, tmpBtcSpecial),
          //   ]
          // ),
        ]
      ),
      // child: Text("helloWorld"),
    );
  }
  Widget buildGetTotalValue(double totalValue, double btcSpecial) {
    double dollarValue = btcSpecial * totalValue;
    return Column(
      children: <Widget> [
        SizedBox(height: displayHeight(context) * 0.02),
        Image(image: AssetImage('graphics/icons/crypto/bitcoin_white_2.png')),  
        SizedBox(height: displayHeight(context) * 0.015),
        Text(
          "B: " + totalValue.toStringAsFixed(8),
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          "\$" + dollarValue.toStringAsFixed(2),
          style: TextStyle(fontSize: 25, color: Colors.white,
            fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildTicker(context, double btcSpecial) { /// refactor into an actual column like buildGetTotalValue()
    bool visibility = true;
    if (btcSpecial != 0.0) {
      visibility = true;
    }
    return Visibility(
      visible: visibility,
      child: Container(
        height: displayHeight(context) * 0.02,
        child: Text("BTC: \$" + btcSpecial.toInt().toString(),
                  style: TextStyle(color: Colors.white)),
      ),
    );
  }

}