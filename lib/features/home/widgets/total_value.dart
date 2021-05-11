import 'package:flutter/material.dart';

import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer';


class TotalValue extends StatefulWidget {
  TotalValue({Key key}) : super(key: key);

  @override
  TotalValueState createState() => TotalValueState();
}

class TotalValueState extends State<TotalValue> {
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
          return Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 28));
        } else if (state is StartupInitialState) {
          log("Initial");
          return Container();
        } else if (state is StartupLoadingState) {
          log("Loading");
          return loadingTemplateWidget();
        // } else if (state is StartupTotalValueState) {
        //   log("TotalValueState");
        //   return Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 28));
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
