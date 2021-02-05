import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/ui/template/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class InnerHomeView extends StatefulWidget {
  InnerHomeView({Key key}) : super(key: key);

  @override
  _InnerHomeViewState createState() => _InnerHomeViewState();
}

class _InnerHomeViewState extends State<InnerHomeView> {

  GetTotalValueBloc getTotalValueBloc;

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
    getTotalValueBloc = BlocProvider.of<GetTotalValueBloc>(context);
    getTotalValueBloc.add(FetchGetTotalValueEvent());
  }

  @override
  Widget build(BuildContext context) {
    var tmpTotalValue = 0.0;
    var tmpBtcSpecial = 0.0;
    return Container(
      child: BlocListener<GetTotalValueBloc, GetTotalValueState>(
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
              return buildGetTotalValue(tmpTotalValue, tmpBtcSpecial);
            } else if (state is GetTotalValueLoadedState) {
              log("GetTotalValueLoadedState");
              tmpTotalValue = state.totalValue;
              tmpBtcSpecial = state.btcSpecial;
              return buildGetTotalValue(state.totalValue, state.btcSpecial);
            } else if (state is GetTotalValueErrorState) {
              log("GetTotalValueErrorState");
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

  Widget buildGetTotalValue(double totalValue, double btcSpecial){
    double dollarValue = btcSpecial * totalValue;
    return Column(
      children: <Widget> [
        Text(
          "B: " + totalValue.toStringAsFixed(8),
          style: TextStyle(fontSize: 18),
        ),
        Text(
          "\$" + dollarValue.toStringAsFixed(2),
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}