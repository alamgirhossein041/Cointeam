import 'package:coinsnap/features/home/widgets/menu_item_button.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter/material.dart';

class HomeMenuButton extends StatefulWidget {
  HomeMenuButton({Key key}) : super(key: key);

  @override
  _HomeMenuButtonState createState() => _HomeMenuButtonState();
}

class _HomeMenuButtonState extends State<HomeMenuButton> {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    Widget _menuItems = Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              MenuItemButton(buttonText: 'MARKET'),
              MenuItemButton(buttonText: 'CHART'),
              MenuItemButton(buttonText: 'BUY'),
            ]),
            Column(children: <Widget>[
              MenuItemButton(buttonText: 'MY COINS'),
              MenuItemButton(buttonText: 'SNAPSHOTS'),
              MenuItemButton(buttonText: 'SETTINGS'),
            ]),
          ]),
    );

    Widget _menuIcon = Column(children: [
      Icon(
        Icons.menu,
        color: primaryDark,
        size: 24.0,
        semanticLabel: 'menu',
      ),
      Text("MENU"),
    ]);

    return GestureDetector(
      onTap: () {
        setState(() => _isOpen = !_isOpen);
      },
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: _isOpen ? _menuItems : _menuIcon,
      ),
    );
  }
}
