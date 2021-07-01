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
      duration: Duration(
          milliseconds: 500), // how long should the animation take to finish
    );
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _menuSwitch() {
    _isOpen = !_isOpen;
    _isOpen ? _animationController.forward() : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Widget _menuItem(String s, String dir) {
      return TextButton(
        child: Text(s),
        style: TextButton.styleFrom(
          // padding: const EdgeInsets.all(2.0),
          minimumSize: Size(2.0, 2.0),
        ),
        onPressed: () {
          _menuSwitch();
          Navigator.pushNamed(context, dir);
        },
      );
    }

    Widget _menuItems = Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(children: <Widget>[
              Flexible(
                flex: 1,
                child: _menuItem('MARKET', '/marketoverview'),
              ),
              Flexible(
                flex: 1,
                child: _menuItem('CHART', '/chart'),
              ),
              Flexible(
                flex: 1,
                child: _menuItem('BUY', '/buyportfolio'),
              ),
            ]),
            Column(children: <Widget>[
              Flexible(
                flex: 1,
                child: _menuItem('MY COINS', '/mycoins'),
              ),
              Flexible(
                flex: 1,
                child: _menuItem('SNAPSHOTS', '/snapshots'),
              ),
              Flexible(
                flex: 1,
                child: _menuItem('SETTINGS', '/settings'),
              ),
            ]),
          ]),
    );

    Widget _animatedMenu = AnimatedIcon(
      size: 24,
      color: primaryDark,
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
        GestureDetector(
          onPanEnd: (details) {
            setState(() {
              _menuSwitch();
            });
          },
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _menuSwitch();
              });
            },
            child: Column(
              children: [
                _animatedMenu,
                _isOpen
                    ? AnimatedOpacity(
                        opacity: 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Text("MENU"),
                      )
                    : AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Text("MENU"),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
