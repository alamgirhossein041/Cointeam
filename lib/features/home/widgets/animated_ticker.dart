import 'package:flutter/material.dart';

class AnimatedTicker extends StatefulWidget {
  final double btcSpecial;
  final double ethSpecial;
  AnimatedTicker({this.btcSpecial, this.ethSpecial});

  @override
  AnimatedTickerState createState() => AnimatedTickerState();
}

class AnimatedTickerState extends State<AnimatedTicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Text("BTC:  \$" + widget.btcSpecial.toStringAsFixed(0) + "  |  ETH:  \$" + widget.ethSpecial.toStringAsFixed(0), style: TextStyle(color: Colors.black, fontSize: 14))
    );
  }
}