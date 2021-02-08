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
}