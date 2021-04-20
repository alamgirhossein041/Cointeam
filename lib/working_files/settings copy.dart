import 'package:flutter/material.dart';

import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  // Settings({Key key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
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
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Container(
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
                                onPressed: () => {Navigator.pop(context)},
                                icon: Icon(Icons.close, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// ### Convert to a list of cards later on ### ///
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Connect Exchange tapped")},
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
                                child: Text("Connect Exchange", style: TextStyle(color: Colors.white)),
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
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Default Currency tapped")},
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
                                child: Text("Default Currency", style: TextStyle(color: Colors.white)),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget> [
                                    Text("AUD", style: TextStyle(color: Colors.grey)),
                                    SizedBox(width: 10),
                                    Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                                  ]
                                ),
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Default Sell to: tapped")},
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
                                child: Text("Default Sell to:", style: TextStyle(color: Colors.white)),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget> [
                                    Text("BTC", style: TextStyle(color: Colors.grey)),
                                    SizedBox(width: 10),
                                    Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                                  ]
                                ),
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Show Balances tapped")},
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
                                child: Text("Show Balances", style: TextStyle(color: Colors.white)),
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
                                child: Icon(Icons.toggle_off, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Enable Fullscreen Charts tapped")},
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
                                child: Text("Enable Fullscreen Charts", style: TextStyle(color: Colors.white)),
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
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Margin Enabled tapped")},
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
                                child: Text("Margin Enabled", style: TextStyle(color: Colors.grey[700])),
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
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Enter Code tapped")},
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
                                child: Text("Enter Code", style: TextStyle(color: Colors.white)),
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
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Rate & Review Tapped")},
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
                                child: Text("Rate & Review", style: TextStyle(color: Colors.white)),
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
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Feedback")},
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
                                child: Text("Feedback", style: TextStyle(color: Colors.white)),
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
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () => {debugPrint("Logout")},
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
                                child: Text("Logout", style: TextStyle(color: Colors.white)),
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
                                child: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
                              ),
                            ),
                          )
                        ]
                      )
                    ),
                  )
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(),
                )
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