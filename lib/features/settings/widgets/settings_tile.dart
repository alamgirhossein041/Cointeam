import 'package:coinsnap/features/utils/sizes_helper.dart';
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
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: displayWidth(context),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Text(text, style: TextStyle(color: Colors.black)),
      ),
      onTap: onClick
    );
  }
}