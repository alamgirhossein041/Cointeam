import 'dart:developer';

import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget> [
            SizedBox(height: 50),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text("coin price", style: TextStyle(color: Colors.black)),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                /// Total Value Bloc
                child: Text("\$14,141.51", style: TextStyle(fontSize: 34, color: Colors.black))
              )
            ),
            SizedBox(
              height: displayHeight(context) * 0.05
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: GestureDetector(
                child: Column(
                  children: <Widget> [
                    /// State Change - Live Mode / Preview Mode
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
                          left: displayWidth(context) * 0.625,
                          child: Icon(Icons.online_prediction, color: Colors.green, size: 20)
                        ),
                      ]
                    ),
                    Icon(Icons.toggle_on, size: 46)
                  ]
                )
              )
            ),
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.topCenter,
                child: Icon(Icons.offline_bolt, size: 110),
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
        log("Sup"),
      },
    );
  }
}