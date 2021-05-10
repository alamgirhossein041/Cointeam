import 'dart:developer';

import 'package:coinsnap/modules/home/pages/home.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';

class LinkAPISelect extends StatefulWidget {

  @override
  LinkAPISelectState createState() => LinkAPISelectState();
}

class LinkAPISelectState extends State<LinkAPISelect> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2B064B), Color(0xFF381AA2)]
            ),
          ),
          child: Column(
            children: <Widget> [
              SizedBox(height: 35),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                    child: Text("Skip"),
                    onPressed: () {
                      writeStorage("welcome", "true");
                      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/second'));
                    },
                  )
                )
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Select Exchange", style: TextStyle(color: Colors.white, fontSize: 24)),
                )
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: displayHeight(context) * 0.075,
                    width: displayWidth(context) * 0.75,
                    child: InkWell(
                      splashColor: Colors.red,
                      highlightColor: Colors.red,
                      hoverColor: Colors.red,
                      focusColor: Colors.red,
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            begin: Alignment(-1, 1),
                            end: Alignment(1, -1),
                            colors: [
                              Color(0xFF701EDB),
                              Color(0xFF0575FF),
                              Color(0xFF0AABFF)
                            ],
                            stops: [
                              0.0,
                              0.77,
                              1.0
                            ]
                          )
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Link Binance", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                      ),
                      onTap: () => {
                        Navigator.pushNamed(context, '/second')
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: displayHeight(context) * 0.075,
                    width: displayWidth(context) * 0.75,
                    child: InkWell(
                      splashColor: Colors.red,
                      highlightColor: Colors.red,
                      hoverColor: Colors.red,
                      focusColor: Colors.red,
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            begin: Alignment(-1, 1),
                            end: Alignment(1, -1),
                            colors: [
                              Color(0xFF701EDB),
                              Color(0xFF0575FF),
                              Color(0xFF0AABFF)
                            ],
                            stops: [
                              0.0,
                              0.77,
                              1.0
                            ]
                          )
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Link FTX", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                      ),
                      onTap: () => {
                        Navigator.pushNamed(context, '/linkapiftx')
                      },
                    ),
                  ),
                ),
              ),
            ]
          )
        )
      ),
    );
  }
}