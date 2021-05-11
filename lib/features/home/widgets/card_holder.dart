import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'graphics/assets/svg/card_holder.svg';
final Widget svg =
    SvgPicture.asset(assetName, semanticsLabel: 'Card holder image');

class CardHolderSVG extends StatelessWidget {
  const CardHolderSVG({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        assetName,
        height: 50,
        width: 50,
        allowDrawingOutsideViewBox: true,
      )
    );
  }
}
