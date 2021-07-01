import 'package:coinsnap/features/home/widgets/menu_item_button.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter/material.dart';

class HomeMenuButton extends StatefulWidget {
  HomeMenuButton({Key key}) : super(key: key);

  @override
  _HomeMenuButtonState createState() => _HomeMenuButtonState();
}

class _HomeMenuButtonState extends State<HomeMenuButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isOpen = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration:
          Duration(milliseconds: 500), // how long should the animation take to finish
    );
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

    Widget _closeMenuIcon = Column(
      children: [
        Icon(
          Icons.close,
          color: primaryDark,
          size: 24.0,
          semanticLabel: 'menu',
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );

    Widget _animatedMenu = AnimatedIcon(
      size: 24,
      color: Colors.blue,
      icon: AnimatedIcons.menu_close,
      progress: _animationController,
    );

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedOpacity(
          opacity: _isOpen ? 1.0 : 0.0,
          duration: Duration(milliseconds: 130),
          child: _menuItems,
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
                _isOpen
                    ? _animationController.forward()
                    : _animationController.reverse();
              });
            },
            // child: AnimatedSwitcher(
            //   duration: Duration(milliseconds: 130),
            //   child: _isOpen ? _closeMenuIcon : _menuIcon,
            // ),
            child: _animatedMenu,
          ),
        ),
      ],
    );
  }
}
