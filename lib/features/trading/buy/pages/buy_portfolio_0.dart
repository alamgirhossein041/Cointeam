import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';

class BuyPortfolioScreenOne extends StatefulWidget {
  BuyPortfolioScreenOne({
    Key key
  }) : super(key: key);

  @override
  BuyPortfolioScreenOneState createState() => BuyPortfolioScreenOneState();
}

class BuyPortfolioScreenOneState extends State<BuyPortfolioScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Buy from Snapshot"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPadding(),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    Text("Select a Snapshot to buy from"),
                    Text("Hi")
                  ],
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}