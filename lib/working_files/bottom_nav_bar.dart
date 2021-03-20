import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({this.callBack});
  final Function callBack;

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {

  final storage = new FlutterSecureStorage();


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
                          /// ### Dev-5: Delete (and maybe put in its own helper file with dashboard_initial_noAPI class readStorage)
                          storage.delete(key: "trading");
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