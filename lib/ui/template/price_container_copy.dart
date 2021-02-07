import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui/home_content.dart';
import 'package:flutter/material.dart';

class PriceContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [appPurple, appBlue],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: displayHeight(context) * 0.2,
      width: displayWidth(context) * 0.75,
      child: Container(
        child: Column (
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.03),
            Image(image: AssetImage('graphics/icons/crypto/bitcoin_white_2.png')),  
            SizedBox(height: displayHeight(context) * 0.02),
            InnerHomeView(),
            
          ]
        ),
      ),
      // child: Text("helloWorld"),
    );
  }
}