import 'dart:developer';

import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/ui/core_widgets/price_container/price_container.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/v2/asset/icon_custom/icon_custom.dart';
import 'dart:math' as math;

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  double modalEdgePadding = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlack,
      bottomNavigationBar: BottomNavBar(callBack: _callBackSetState),
      drawer: DrawerMenu(),
      body: Container(
        child: Column(
          children: <Widget> [
            // Text("Hello World", style: TextStyle(color: Colors.white))
            Expanded(
              flex: 1,
              child: TopMenuRow(),
            ),
            Expanded(
              flex: 2,
              child: HeaderBox(),
            ),
            Expanded(
              flex: 4,
              child: Container(),
            )
          ]
        )
      ),
    );
  }
  void _callBackSetState() {
    setState(() {
      log("Hello World");
    });
  }
}

class BottomNavBar extends StatefulWidget {
  BottomNavBar({this.callBack});
  final Function callBack;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Container(
          /// ### This is the bottomappbar ### ///
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomAppBar(
              color: Color(0xFF2E374E),
              child: Column(
                children: <Widget> [
                  SizedBox(height: 5),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        /// ### Bottom left button on bottomnavbar ### ///
                        IconButton(icon: Icon(Icons.swap_vert, color: Color(0xFFA9B1D9)), onPressed: () {
                        }),
                        IconButton(icon: Icon(Icons.help_center, color: Color(0xFFA9B1D9)), onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              /// Manual padding override because Dialog's default padding is FAT
                              insetPadding: EdgeInsets.all(10),
                              /// Connect API tutorial modal
                              // child: ModalPopup(),
                              child: IntroScreen(),
                            ),
                          );
                        }),
                        /// ### Bottom right button on bottomnavbar ### ///
                        IconButton(icon: Icon(Icons.refresh, color: Color(0xFFA9B1D9)), onPressed: () {widget.callBack();}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderBox extends StatelessWidget {
  const HeaderBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Stack(
        children: <Widget> [
          Container(
            decoration: headerBoxDecoration,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0,2.75,0,2.75),
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: headerBoxInnerDecoration,
                child: Column(
                  children: <Widget> [
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: HeaderBoxWalletIcon(),
                      ),
                    )
                  ]
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderBoxWalletIcon extends StatelessWidget {
  const HeaderBoxWalletIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ### Size of wallet icon ### ///
      height: 31.43,
      width: 36.23,
      child: Column(
        children: <Widget> [
          Expanded(
            child: Transform.rotate(
              angle: -5 * math.pi / 180,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(IconCustom.wallet_tilt, color: Colors.white),
              )
            ),
          )
        ]
      )
    );
  }
}

var headerBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment(-0.9, -1.3),
    end: Alignment(1.25, 1.25),
    colors: [
      Color(0xFFC21EDB),
      Color(0xFF0575FF),
      Color(0xFF0AE6FF),
    ], stops: [
      0.0,
      0.63,
      1.0
    ],
  ),
);

var headerBoxInnerDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment(-1.25, -1.15),
    end: Alignment(0.85, 1.1),
    colors: [
      Color(0xFF240C37),
      Color(0xFF061330),
      // Colors.white,
    ],
  ),
);