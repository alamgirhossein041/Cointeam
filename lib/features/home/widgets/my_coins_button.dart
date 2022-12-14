import 'package:flutter/material.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';

class MyCoinsButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: displayHeight(context) * 0.05,
        width: displayWidth(context) * 0.2,
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text("My Coins", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
        ),
      ),
      onTap: () => {
        Navigator.pushNamed(context, '/mycoins'),
      },
    );
  }
}