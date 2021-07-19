import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

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
    return Container(
      width: displayWidth(context) - 50,
      height: 22,
      child: Marquee(
        velocity: 17.0,
        blankSpace: 20.0,
        text: "BTC:  \$" +
            widget.btcSpecial.toStringAsFixed(2) +
            "        " +
            "ETH:  \$" +
            widget.ethSpecial.toStringAsFixed(2),
        style:
            Theme.of(context).textTheme.subtitle2.copyWith(color: primaryLight),
      ),
    );
  }
}
