import 'dart:developer';

import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/modules/app_load/repos/binance_time_sync.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class PanicButton extends StatefulWidget {

  @override
  PanicButtonState createState() => PanicButtonState();
}

class PanicButtonState extends State<PanicButton> {
  bool isLive = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () => setState(() {
              isLive = !isLive;
            }),
            child: Column(
              children: <Widget> [
                /// State Change - Live Mode / isLive Mode
                if(!isLive)...[
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
          ),
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
                  log(isLive.toString()),
                  BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
                  Navigator.pushNamed(context, '/sellportfolio', arguments: {'preview': isLive})
                },
                icon: Icon(Icons.offline_bolt, size: 110)
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedTicker extends StatefulWidget {
  final double btcSpecial;
  final double ethSpecial;
  AnimatedTicker({this.btcSpecial, this.ethSpecial});

  @override
  AnimatedTickerState createState() => AnimatedTickerState();
}

class AnimatedTickerState extends State<AnimatedTicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Text("BTC:  \$" + widget.btcSpecial.toStringAsFixed(0) + "  |  ETH:  \$" + widget.ethSpecial.toStringAsFixed(0), style: TextStyle(color: Colors.black, fontSize: 14))
    );
  }
}