import 'dart:developer';

import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
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
                              onPressed: () => {Navigator.pop(context)},
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
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) => Dialog(
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
                                child: Text("Beta v1.0", style: TextStyle(color: Colors.white)),
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