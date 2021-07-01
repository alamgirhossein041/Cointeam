import 'package:coinsnap/features/home/widgets/menu_item_button.dart';
import 'package:flutter/material.dart';

class HomeMenuButton extends StatefulWidget {
  HomeMenuButton({Key key}) : super(key: key);

  @override
  _HomeMenuButtonState createState() => _HomeMenuButtonState();
}

class _HomeMenuButtonState extends State<HomeMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
            MenuItemButton(buttonText: 'MARKET'),
            MenuItemButton(buttonText: 'CHART'),
            MenuItemButton(buttonText: 'BUY'),
          ]),
          Column(
            children: <Widget>[
            MenuItemButton(buttonText: 'MY COINS'),
            MenuItemButton(buttonText: 'SNAPSHOTS'),
            MenuItemButton(buttonText: 'SETTINGS'),
          ]),
        ]),
    );
  }
}
