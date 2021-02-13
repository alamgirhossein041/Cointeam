import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_bloc.dart';
import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_event.dart';
import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_state.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui/template/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class InnerCoinView extends StatefulWidget {
  final String coinTicker;

  InnerCoinView({Key key, this.coinTicker}) : super(key: key);

  @override
  _InnerCoinViewState createState() => _InnerCoinViewState();
}

class _InnerCoinViewState extends State<InnerCoinView> {

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
    
    
  }

  @override
  Widget build(BuildContext context) {
    var tmpCoinPrice = 0.0;
    return Container(
      child: BlocListener<GetPriceInfoBloc, GetPriceInfoState>(
        listener: (context, state) {
          if (state is GetPriceInfoErrorState) {
            log("error in GetPriceInfoErrorState in coin_content.dart");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.errorMessage)),
            // );
          }
        },
        child: BlocBuilder<GetPriceInfoBloc, GetPriceInfoState>( /// Both bloc types to be built (refactor existing controllers)
          builder: (context, state) {
            if (state is GetPriceInfoInitialState) {
              log("GetPriceInfoInitialState");
              return buildLoadingTemplate();
            } else if (state is GetPriceInfoLoadingState) {
              log("GetPriceInfoLoadingState");
              // return buildLoadingTemplate();
              return buildGetPriceInfo(tmpCoinPrice);
            } else if (state is GetPriceInfoLoadedState) {
              log("GetPriceInfoLoadedState");
              // tmpBtcSpecial = state.btcSpecial;
              return buildGetPriceInfo(state.coinPrice);
            } else if (state is GetPriceInfoErrorState) {
              log("GetPriceInfoErrorState");
              return buildErrorTemplate(state.errorMessage);
            } else {
              return null;
            }
          }
        ),
      ),
      /// child: Text("Hello World!"),
    );
  }

  Widget buildGetPriceInfo(double tmpCoinPrice) {
    return Column(
      children: <Widget> [
        // Text(
        //   "B: " + totalValue.toStringAsFixed(8),
        //   style: TextStyle(fontSize: 14, color: Colors.white),
        // ),
        Text(
          "\$" + tmpCoinPrice.toStringAsFixed(2), /// TODO: Potentially add BTC price above
          style: TextStyle(fontSize: 25, color: Colors.white,
            fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}