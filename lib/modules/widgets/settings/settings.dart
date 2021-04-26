import 'package:coinsnap/modules/data/global_stats/coinmarketcap/bloc/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/modules/data/global_stats/coinmarketcap/bloc/global_coinmarketcap_stats_event.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/modules/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class Settings extends StatefulWidget {

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  final localStorage = LocalStorage("settings");
  String currency = '';

  @override
  void initState() { 
    super.initState();
    currency = localStorage.getItem("currency");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      decoration: BoxDecoration(
        color: Color(0xFF0E0F18),
      ),
      height: displayHeight(context),
      width: displayWidth(context),
      child: Padding(
        padding: EdgeInsets.only(top: 40),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF36343E),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: <Widget> [
                Container(
                  height: displayHeight(context) * 0.1,
                  decoration: GreyUndersideBorder,
                  child: Row(
                    children: <Widget> [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Settings", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: IconButton(
                              onPressed: () {
                                BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
                                BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
                                Navigator.pop(context);
                                },
                              icon: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ### Convert to a list of cards later on ### ///
                Container(
                  height: displayHeight(context) * 0.07,
                  child: GestureDetector(
                    onTap: () => {
                      // showDiadebugPrint(
                      //   context: context,
                      //   builder: (BuildContext context) => DiadebugPrint(
                      //     /// Manual padding override because Dialog's default padding is FAT
                      //     insetPadding: EdgeInsets.all(10),
                      //     /// Connect API tutorial modal
                      //     child: CarouselDemo(),
                      //   ),
                      // ),
                    },
                    child: Container(
                      decoration: GreyUndersideBorder,
                      child: Row(
                        children: <Widget> [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text("Beta v1.0.32", style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 30),
                                // child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                                child: Container(),
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),

                /// Refactor into Stateful Widget so we don't rebuild the entire screen
                Container(
                  height: displayHeight(context) * 0.07,
                  child: GestureDetector(
                    onTap: () async {
                      // String currency = await widget.localStorage.getItem("currency");
                      // localStorage = LocalStorage("settings");
                      if (currency == "USD") {
                        localStorage.setItem("currency", "AUD");
                        setState(() {
                          currency = "AUD";
                          // currency = "AUD";
                        });
                      } else if (currency == "AUD") {
                        localStorage.setItem("currency", "USD");
                        setState(() {
                          currency = "USD";
                        });
                      }
                    },
                    child: Container(
                      decoration: GreyUndersideBorder,
                      child: Row(
                        children: <Widget> [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text("Default Currency:  " + currency, style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          // Flexible(
                          //   flex: 1,
                          //   fit: FlexFit.tight,
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: Padding(
                          //       padding: EdgeInsets.only(right: 30),
                          //       // child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                          //       child: Container(),
                          //     ),
                          //   ),
                          // )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget> [
                      Container(
                        height: displayHeight(context) * 0.07,
                        child: GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              child: AlertDialog(
                                backgroundColor: appBlack,
                                title: Text("CoinStreet", style: TextStyle(color: Colors.grey[350])),
                                content: Text("Made in Australia\n\n\nCredits to: \n\nAndrew, Hana and Michael\n\n\nBeta Release 1.0.32\n\nwww.coinstreetapp.com", style: TextStyle(color: Colors.grey[350])),
                              )
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey), top: BorderSide(color: Colors.grey)),
                            ),
                            child: Row(
                              children: <Widget> [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text("About Us", style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ]
                            )
                          ),
                        )
                      ),
                      SizedBox(height: 30),
                    ]
                  ),
                ),
              ]
            )
          )
        ),
      ),
    );
  }
}

const BoxDecoration GreyUndersideBorder = BoxDecoration(
  border: Border(
    bottom: BorderSide(width: 1, color: Colors.grey),
  ),
);