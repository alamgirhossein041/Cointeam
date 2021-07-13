import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String tileText;
  SettingsTile({
    Key key,
    this.tileText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(tileText),
    );
  }
}


class SettingsTileToggle extends StatefulWidget {
  final String tileText;
  SettingsTileToggle({
    Key key,
    this.tileText
  }) : super(key: key);

  @override
  SettingsTileToggleState createState() => SettingsTileToggleState();
}

class SettingsTileToggleState extends State<SettingsTileToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        // child: Container(
        //   width: double.infinity,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(widget.tileText),
            Text("USD")
          ]
        // ),
        )
      )
    );
  }
}