import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String text;
  final Function onClick;

  SettingsTile({
    Key key,
    @required this.text,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text(text),
      ),
      onTap: onClick,
    );
  }
}


class SettingsTileToggle extends StatefulWidget {
  final String text;
  final Function toggle;
  SettingsTileToggle({
    Key key,
    this.text,
    @required this.toggle,
  }) : super(key: key);

  @override
  SettingsTileToggleState createState() => SettingsTileToggleState();
}

class SettingsTileToggleState extends State<SettingsTileToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        // child: Container(
        //   width: double.infinity,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(widget.text),
            Text("USD")
          ]
        // ),
        )
      )
    );
  }
}