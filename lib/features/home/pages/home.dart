import 'package:flutter/material.dart';

// Packages
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/app_load/repos/binance_time_sync.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';

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
    return Scaffold(
      backgroundColor: lightPrimary,
      body: Container(
        child: Column(
          children: <Widget> [
            SizedBox(height: 40),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: CoinTicker(),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Stack(
                children: <Widget> [
                  Center(
                    child: Text(
                      "Total Value", style: TextStyle(fontSize: 28, color: Colors.black)
                    )
                  ),
                  Center(
                /// Total Value Bloc
                // child: Text("\$14,141.51", style: TextStyle(fontSize: 34, color: Colors.black))
                    child: TotalValue(),
                  ),
                ]
              )
            ),
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
            CardHolderSVG(),
          ]
        )
      )
    );
  }
}

