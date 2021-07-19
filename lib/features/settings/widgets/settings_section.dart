import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final items;
  
  SettingsSection({
    Key key,
    @required this.title,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Text(title),
          SizedBox(height: 20.0),
          // Padding(
            // padding: EdgeInsets.symmetric(horizontal: 20.0),
            // child: Column(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
            ),
          // ),
        ]
      ),
    );
  }
}