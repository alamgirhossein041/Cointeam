import 'package:coinsnap/features/home/widgets/menu_item_button.dart';
import 'package:flutter/material.dart';

class HomeMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
            MenuItemButton(),
            MenuItemButton(),
            MenuItemButton(),
          ]),
          Column(
            children: <Widget>[
            MenuItemButton(),
            MenuItemButton(),
            MenuItemButton(),
          ]),
        ]),
    );
  }
}
