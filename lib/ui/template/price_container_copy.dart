import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui/template/home_content.dart';
import 'package:flutter/material.dart';

class PriceContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.blue, appPurple],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: displayHeight(context) * 0.17,
      width: displayWidth(context) * 0.85,
      child: Container(
        child: Column (
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.02),
            Image(image: AssetImage('graphics/icons/crypto/bitcoin_white_2.png')),  
            SizedBox(height: displayHeight(context) * 0.015),
            InnerHomeView(),
          ]
        ),
      ),
      // child: Text("helloWorld"),
    );
  }
  Widget buildGetTotalValue(double totalValue, double btcSpecial) {
    double dollarValue = btcSpecial * totalValue;
    return Column(
      children: <Widget> [
        Text(
          "B: " + totalValue.toStringAsFixed(8),
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          "\$" + dollarValue.toStringAsFixed(2),
          style: TextStyle(fontSize: 25, color: Colors.white,
            fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildTicker(context, double btcSpecial) {
    return Container(
      height: displayHeight(context) * 0.02,
      child: Text("BTC: \$" + btcSpecial.toInt().toString()),
    );
  }

}