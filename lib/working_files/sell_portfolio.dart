import 'dart:developer';

import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:flutter/material.dart';

class SellPortfolio extends StatefulWidget {
  // SellPortfolio({Key key}) : super(key: key);

  @override
  SellPortfolioState createState() => SellPortfolioState();
}

class SellPortfolioState extends State<SellPortfolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0E0F18),
        ),
        height: displayHeight(context),
        width: displayWidth(context),
        child: Column(
          children: <Widget> [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  children: <Widget> [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Icon(Icons.arrow_back, color: Colors.white),
                          onTap: () => {Navigator.pop(context)},
                        )
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Selling Binance Portfolio", style: TextStyle(color: Colors.white)),
                      ),
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
            Flexible(
              flex: 13,
              fit: FlexFit.tight,
              child: Container(
                width: displayWidth(context),
                decoration: BoxDecoration(
                  color: Color(0xFF36343E),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40,20,0,0),
                          child: Text("Market Order", style: TextStyle(color: Colors.white))
                        )
                      )
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.toggle_off, size: 150)
                      )
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Current trading pair", style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("\$14,151.61", style: TextStyle(color: Colors.white)),
                      )
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.signal_cellular_connected_no_internet_4_bar, color: Colors.white),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget> [
                            Text("Estimated Fees", style: TextStyle(color: Colors.grey)),
                            Text("\$3640.70", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ]
                        )
                      )
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Text("This will attempt to sell all your coins in\nthis portfolio.\nYour portfolio will be saved.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: displayHeight(context) * 0.1),
                          child: ColourfulButton(),
                        ),
                      )
                    ),
                  ],
                )
              )
            )
          ]
        )
      ),
    );
  }
}