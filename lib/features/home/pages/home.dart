import 'package:flutter/material.dart';

// Packages
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/app_load/repos/binance_time_sync.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';
import '../../../ui_components/ui_components.dart';

// Widgets
import '../widgets/card_holder.dart';
import '../widgets/coin_ticker.dart';
import '../widgets/panic_button.dart';
import '../widgets/home_button.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBlue,
        body: Stack(
          children: <Widget> [
            CoinTicker(),
            Container(
              margin: mainCardMargin(),
              decoration: mainCardDecoration(),
              child: Column(
                children: <Widget> [
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
                //       CardHolderSVG(),
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
                          HomeButton(),
                          HomeButton(),
                        ]
                      ),
                    ]
                  )
                ),
              ]
            )
          ),]
        )
      ),
    );
  }
}

