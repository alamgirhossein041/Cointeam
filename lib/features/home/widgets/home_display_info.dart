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
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text('Balance'),
                ),
                Flexible(
                  flex: 1,
                  child:

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
                          style: Theme.of(context).textTheme.headline1,
                        );
                      } else if (state is StartupErrorState) {
                        return Text(
                          "\$12,516.35", // placeholder text because it's not working rn
                          style: Theme.of(context).textTheme.headline1,
                        );
                        // Text("An error has occurred, Binance-related.",
                        // style: Theme.of(context).textTheme.headline1);
                      } else {
                        return Column(
                          children: <Widget>[
                            loadingTemplateWidget(),
                            SizedBox(height: 10),
                          ],
                        );
                      }
                    },
                  ),

                  /// End bloc
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Text('Total Market Cap'),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          '\$2.1T',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: DominanceWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
