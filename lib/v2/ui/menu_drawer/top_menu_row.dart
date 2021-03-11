import 'dart:developer';

import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';

class TopMenuRow extends StatelessWidget {
  TopMenuRow({Key key, this.precontext}) : super(key: key);
  final BuildContext precontext;

  // GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(precontext).openDrawer();
            log("Hello");
            // scaffoldState.currentState.openDrawer();
          },
        ),
        Container( /// TODO: Add 'Poppins' font ttf or something
          child: Text("Dashboard", style: TextStyle(fontFamily: 'Poppins', fontSize: 22, color: Colors.white)),
        ),
        SizedBox(width: displayWidth(context) * 0.3),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              IconButton(
                onPressed: () {
                  // scaffoldState.currentState.openDrawer();
                },
                icon: Icon(Icons.settings, color: Colors.white),
              )
            ]
          )
        ),
      ] /// ### Top Row ends here ### ///
    );
  }
}