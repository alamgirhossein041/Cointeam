import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E2330),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader(
            //   child: Text('Settings\n\n\n\n\n\nEarn Doge - Does nothing yet'),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [Colors.blueAccent, appBlue],
            //     ),
            //   ),
            // ),
            SizedBox(height: displayHeight(context) * 0.1),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: displayHeight(context) * 0.05,
                child: Container(
                  // height: displayHeight(context) * 0.4,
                  // width: displayWidth(context) * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(0,-1),
                      end: Alignment(0, 1),
                      colors: [
                        Color(0xFFC21EDB),
                        Color(0xFF0575FF),
                        Color(0xFF0AE6FF),
                      ], stops: [
                        0.0,
                        0.63,
                        1.0
                      ],
                    )
                  ),
                ),
              ),
                  // button color
                  // child: InkWell(
                  //   splashColor: Colors.red, // inkwell color
                  //   child: SizedBox(width: 56, height: 56, child: Icon(Icons.menu)),
                  //   onTap: () {},
                  // ),
            ),
            ListTile(
              // contentPadding: EdgeInsets.fromLTRB(20,20,0,0),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'User Name Placeholderrrrrrrrrrr',
                  style: TextStyle(color: Colors.white, fontSize:16),
                ),
              ),
            ),
            DottedLine(dashLength: 2, dashColor: Color(0xFF526E8E)),
            SizedBox(height: displayHeight(context) * 0.025),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              /// title: Text('Portfolio 1 - Live'),
              title: Text(
                'Top 100',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/homeviewreal');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                'Wallet',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/builder');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                'News',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/testview');
              },
            ),
          ],
        ),
      ),
    );
  }
}