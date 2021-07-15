import 'dart:developer';

import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

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


class SettingsTileCurrency extends StatefulWidget {
  final String text;
  // final Function onClick;
  SettingsTileCurrency({
    Key key,
    this.text,
    // @required this.onClick,
  }) : super(key: key);

  @override
  SettingsTileCurrencyState createState() => SettingsTileCurrencyState();
}

class SettingsTileCurrencyState extends State<SettingsTileCurrency> {
  String currency = '';

  @override
  void initState() {
    final storage = LocalStorage("settings");
    storage.ready.then((_) {
      setState(() {currency = storage.getItem("currency") ?? 'USD';});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: displayWidth(context),
        // child: Container(
        //   width: double.infinity,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(widget.text),
            Text(currency),
          ]
        // ),
        )
      ),
      onTap: () => _currencyToggleHelper()
    );
  }
  _currencyToggleHelper() {
    final storage = LocalStorage("settings");
    storage.ready.then((_) {currency = storage.getItem("currency") ?? 'USD';});
    if(currency == 'USD') {
      storage.setItem("currency", 'AUD');
      setState(() {
        currency = 'AUD';
      });
    } else if (currency == 'AUD') {
      storage.setItem("currency", 'USD');
      setState(() {
        currency = 'USD';
      });
    }
  }
}