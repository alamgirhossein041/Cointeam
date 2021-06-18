/*
Custom theme data for our app.

Light theme by default, with Blue as primary colour.

 */

import 'package:flutter/material.dart';

final ThemeData CompanyThemeData = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: CompanyColors.blue,
  primaryColor: CompanyColors.blue,
  primaryColorBrightness: Brightness.light,
);


class CompanyColors {
  static const blue = const Color(0xFF2197F2);

  // When it's time to implement shades, see:
  // https://gist.github.com/mikemimik/5ac2fa98fe6d132098603c1bd40263d5

}