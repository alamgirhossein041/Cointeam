import 'dart:developer';

import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SettingsThemeToggle extends StatefulWidget {
  SettingsThemeToggle({Key key}) : super(key: key);

  @override
  SettingsThemeToggleState createState() => SettingsThemeToggleState();
}

class SettingsThemeToggleState extends State<SettingsThemeToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: displayWidth(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text("Theme"),
            SettingsThemeIconSection(brightness: MediaQuery.of(context).platformBrightness),
          ]
        )
      ),
      onTap: () => _themeToggleHelper()
    );
  }
  _themeToggleHelper() {    
    //https://dev.to/mightytechno/dynamic-theme-in-flutter-dark-and-light-theme-532f#:~:text=The%20simplest%20way%20of%20changing,%3D%20ThemeData(%20accentColor%3A%20Colors.
    //https://stackoverflow.com/questions/61726708/toggle-between-light-and-dark-theme-flutter-neumorphic-2-0-0
    
    // Basically in main.dart there will be two themes (light and dark, to be added)
    // Here we will check brightness of page as below, then change not "brightness" but the actual value that the theme data relies on in main.dart???
    // yeah

    log("Hello World");
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    log(brightness.toString());
    if(brightness == Brightness.light) {
      brightness = Brightness.dark;
    } else if (brightness == Brightness.dark) {
      brightness = Brightness.light;
    }
    log(brightness.toString());
  }
}

class SettingsThemeIconSection extends StatefulWidget {
  final Brightness brightness;
  SettingsThemeIconSection({
    Key key,
    this.brightness,
    }) : super(key: key);

  @override
  SettingsThemeIconSectionState createState() => SettingsThemeIconSectionState();
}

class SettingsThemeIconSectionState extends State<SettingsThemeIconSection> {
  final Color themeOn = primaryBlue.withOpacity(0.5);
  final Color themeOff = Colors.black.withOpacity(0.2);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        Icon(Icons.wb_sunny, color: themeOn),
        Text(" / "),
        Icon(Icons.brightness_2, color: themeOff)
      ]
    );
  }
}




//       onTap: () => _currencyToggleHelper()
//     );
//   }
//   _currencyToggleHelper() {
//     final storage = LocalStorage("settings");
//     storage.ready.then((_) {currency = storage.getItem("currency") ?? 'USD';});
//     if(currency == 'USD') {
//       storage.setItem("currency", 'AUD');
//       setState(() {
//         currency = 'AUD';
//       });
//     } else if (currency == 'AUD') {
//       storage.setItem("currency", 'USD');
//       setState(() {
//         currency = 'USD';
//       });
//     }
//   }
// }