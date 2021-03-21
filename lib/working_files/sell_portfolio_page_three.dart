import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:flutter/material.dart';

class SellPortfolioPage3 extends StatefulWidget {
  // SellPortfolioPage3({Key key}) : super(key: key);

  @override
  SellPortfolioPage3State createState() => SellPortfolioPage3State();
}

class SellPortfolioPage3State extends State<SellPortfolioPage3> {
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
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Icon(Icons.close, color: Colors.grey[400]),
                        ),
                      )
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(Icons.done, size: 60, color: Colors.white)
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Sell order complete!", style: TextStyle(color: Colors.white, fontSize: 24))
                      )
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("You sold 75% of your portfolio", style: TextStyle(color: Colors.white))
                      )
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("\$235.26 USD", style: TextStyle(color: Colors.white, fontSize: 30))
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text("B 0.0198000", style: TextStyle(color: Colors.white))
                      )
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ColourfulButton(),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("See transaction log", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                    )
                  ],
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}