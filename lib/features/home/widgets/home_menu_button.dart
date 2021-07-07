import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      duration: const Duration(
          milliseconds: 500), // how long should the animation take to finish
    );
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Switches menu state between open/closed
  void _menuSwitch() {
    _isOpen = !_isOpen;
    _isOpen ? _animationController.forward() : _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        AnimatedOpacity(
          opacity: _isOpen ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 130),
          child: MenuList(callback: _menuSwitch),
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
                AnimatedIcon(
                  size: 24,
                  color: primaryDark,
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                ),
                _isOpen
                    ? AnimatedOpacity(
                        opacity: 0.0,
                        duration: Duration(milliseconds: 200),
                        child: Text("MENU", style: Theme.of(context).textTheme.bodyText1,),
                      )
                    : AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Text("MENU", style: Theme.of(context).textTheme.bodyText1,),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A single menu item with [label] and route [dir].
/// On tap, runs the callback [onMenuTap] which closes the menu.
class MenuItem extends StatelessWidget {
  const MenuItem({Key key, this.label, this.dir, this.onMenuTap})
      : super(key: key);

  final String label;
  final String dir;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(label),
      style: TextButton.styleFrom(
        primary: primaryDark,
      ),
      onPressed: () {
        onMenuTap(); // close memu whenever a menu item is tapped
        Navigator.pushNamed(context, dir);
      },
    );
  }
}

/// The open view of the menu.
/// [callback] is passed down to each [MenuItem].
class MenuList extends StatelessWidget {
  const MenuList({Key key, this.callback}) : super(key: key);
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: MenuItem(
                  label: 'MARKET',
                  dir: '/marketoverview',
                  onMenuTap: () => {
                    // BlocProvider.of<GeckoGlobalStatsBloc>(context).add(GeckoGlobalStatsFetchEvent()),
                    // BlocProvider.of<CoingeckoListTop100Bloc>(context).add(FetchCoingeckoListTop100Event()),
                    // BlocProvider.of<CoingeckoListTrendingBloc>(context).add(FetchCoingeckoListTrendingEvent()),
                    callback,
                  }
                ),
              ),
              Flexible(
                flex: 1,
                child: MenuItem(
                  label: 'CHART',
                  dir: '/chart',
                  onMenuTap: callback,
                ),
              ),
              Flexible(
                flex: 1,
                child: MenuItem(
                  label: 'BUY',
                  dir: '/buyportfolio1',
                  onMenuTap: callback,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: MenuItem(
                  label: 'MY COINS',
                  dir: '/mycoins',
                  onMenuTap: callback,
                ),
              ),
              Flexible(
                flex: 1,
                child: MenuItem(
                  label: 'SNAPSHOTS',
                  dir: '/snapshots',
                  onMenuTap: callback,
                ),
              ),
              Flexible(
                flex: 1,
                child: MenuItem(
                  label: 'SETTINGS',
                  dir: '/settings',
                  onMenuTap: callback,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
