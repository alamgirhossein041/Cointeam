import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Settings\n\n\n\n\n\nEarn Doge - Does nothing yet'),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueAccent, appBlue],
                ),
              ),
            ),
            ListTile(
              /// title: Text('Portfolio 1 - Live'),
              title: Text(
                'Go to Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/homeviewreal');
              },
            ),
            ListTile(
              title: Text(
                'Build New Portfolio',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/builder');
              },
            ),
            ListTile(
              title: Text(
                'Something goes here',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/testview');
              },
            ),
            SizedBox(height: displayHeight(context) * 0.45),
            ListTile(
              title: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Logout'),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

