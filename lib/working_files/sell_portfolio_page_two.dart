import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:flutter/material.dart';

class SellPortfolioPage2 extends StatefulWidget {
  // SellPortfolioPage2({Key key}) : super(key: key);

  @override
  SellPortfolioPage2State createState() => SellPortfolioPage2State();
}

class SellPortfolioPage2State extends State<SellPortfolioPage2> {
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
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
              )
            ),
            Flexible(
              flex: 12,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF36343E),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text("Your Portfolio Snapshot", style: TextStyle(color: Colors.white, fontSize: 22)),
                        ),
                      )
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
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
                              child: Text("Number", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Text("Cost", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                ),
                              )
                            )
                          ]
                        )
                      )
                    ),
                    Flexible(
                      flex: 5,
                      fit: FlexFit.tight,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget> [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text("TOTAL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              )
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("15 coins", style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 30),
                                  child: Text("\$12.67", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              )
                            )
                          ]
                        )
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Selling 50% of portfolio into USD", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: ColourfulButton(),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: ColourfulButton(),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(),
                    )
                  ]
                )
              ),
            ),
          ]
        )
      )
    );
  }
}