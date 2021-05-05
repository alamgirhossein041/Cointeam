import 'dart:developer';

import 'package:coinsnap/modules/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() { 
    super.initState();
    BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget> [
            SizedBox(height: 60),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: CoinTicker(),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
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
              flex: 2,
              fit: FlexFit.tight,
              child: LivePreviewMode(),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 110, /// this helps align IconButton properly
                  height: 110,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () => {
                      Navigator.pushNamed(context, '/sellportfolio')
                    },
                    icon: Icon(Icons.offline_bolt, size: 110)
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
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
            )
          ]
        )
      )
    );
  }
}

class HomeButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: displayHeight(context) * 0.05,
        width: displayWidth(context) * 0.2,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment(-1, 1),
        //     end: Alignment(1, -1),
        //     colors: [
        //       Color(0xFF701EDB),
        //       Color(0xFF0575FF),
        //       Color(0xFF0AABFF)
        //     ],
        //     stops: [
        //       0.0,
        //       0.77,
        //       1.0
        //     ]
        //   )
        // ),
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text("Hello", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
        ),
      ),
      onTap: () => {
        Navigator.pushNamed(context, '/portfolio'),
      },
    );
  }
}

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
        } else if (state is StartupTotalValueState) {
          log("TotalValueState");
          return Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 28));
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
            
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text("BTC:  \$" + state.btcSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
                  Text("ETH:  \$" + state.ethSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
                ]
              )
            ),
            
          );
        } else if (state is StartupInitialState) {
          log("Initial");
          return Container();
        } else if (state is StartupLoadingState) {
          log("Loading");
          return loadingTemplateWidget();
        } else if (state is StartupTotalValueState) {
          log("TotalValueState");
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text("BTC:  \$" + state.btcSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
                  Text("ETH:  \$" + state.ethSpecial.toStringAsFixed(2), style: TextStyle(color: Colors.black, fontSize: 14)),
                ]
              )
            ),
          );
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

class LivePreviewMode extends StatefulWidget {

  @override
  LivePreviewModeState createState() => LivePreviewModeState();
}

class LivePreviewModeState extends State<LivePreviewMode> {
  bool toggle = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        toggle = !toggle;
      }),
      child: Column(
        children: <Widget> [
          /// State Change - Live Mode / Preview Mode
          if(toggle)...[
            Stack(
              alignment: FractionalOffset.center,
              children: <Widget> [
                Center(
                  child: Container(
                    width: displayWidth(context) * 0.30,
                    child: Center(
                      child: Text("Live mode", style: TextStyle(color: Colors.black))
                    ),
                  ),
                ),
                Positioned(
                  left: displayWidth(context) * 0.65,
                  child: Icon(Icons.online_prediction, color: Colors.green, size: 20)
                ),
              ]
            ),
            Icon(Icons.toggle_on, color: Colors.black, size: 46)
          ] else...[
            Stack(
              alignment: FractionalOffset.center,
              children: <Widget> [
                Center(
                  child: Container(
                    width: displayWidth(context) * 0.30,
                    child: Center(
                      child: Text("Preview mode", style: TextStyle(color: Colors.black))
                    ),
                  ),
                ),
                Positioned(
                  left: displayWidth(context) * 0.65,
                  child: Icon(Icons.online_prediction, color: Colors.orange[300], size: 20)
                ),
              ]
            ),
            Icon(Icons.toggle_off, color: Colors.grey, size: 46)
          ]
        ]
      )
    );
  }
}