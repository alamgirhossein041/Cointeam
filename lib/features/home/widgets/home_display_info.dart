import 'dart:developer';

import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/home/widgets/dominance.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDisplayInfo extends StatefulWidget {
  @override
  _HomeDisplayInfoState createState() => _HomeDisplayInfoState();
}

class _HomeDisplayInfoState extends State<HomeDisplayInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Balance'),
          
          /// State bloc info retrieval for total balance
          BlocConsumer<StartupBloc, StartupState>(
            listener: (context, state) {
              if (state is StartupErrorState) {
                log("Error in home_display_info.dart _HomeDisplayInfoState");
              }
            },
            builder: (context, state) {
              if (state is StartupLoadedState) {
                return Text(
                  '\$' + state.totalValue.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headline1
                );
              }
              else if (state is StartupErrorState) {
                return Text(
                  "An error has occurred, Binance-related.",
                  style: Theme.of(context).textTheme.headline1
                );
              } else {
                return Column(
                  children: <Widget> [
                    loadingTemplateWidget(),
                    SizedBox(height: 20),
                  ]
                );
              }
            },
          ),
          /// End bloc
          
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Market Cap'),
                    Text('\$2.1T'),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: DominanceWidget(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
