import 'package:flutter/material.dart';

class ApiModalFirst extends StatelessWidget {
  const ApiModalFirst({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Connect Binance'),
      children: [
        SimpleDialogOption(
          child: Text("Hello"),
        )
      ],
    );
  }
}