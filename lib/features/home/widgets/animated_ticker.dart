import 'package:flutter/material.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';

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
      child: Text(
        "BTC:  \$" + widget.btcSpecial.toStringAsFixed(0) + "  |  ETH:  \$" + widget.ethSpecial.toStringAsFixed(0), 
        style: Theme.of(context).primaryTextTheme.subtitle1)
    );
  }
}