import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Settings\n\n\n\n\n\nEarn Doge'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Portfolio 1 - Live'),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('Portfolio 2'),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('Create New Portfolio'),
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
                
              },
            ),
          ),
        ],
      ),
    );
  }
}

