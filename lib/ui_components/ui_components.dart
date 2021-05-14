import 'package:coinsnap/modules/utils/colors_helper.dart';
import 'package:flutter/material.dart';

/// Main card margin style.
EdgeInsets mainCardMargin() => EdgeInsets.only(top: 34, left: 5, right: 5);

/// Main background card decoration style.
/// Light background, rounded top corners
BoxDecoration mainCardDecoration() =>
  BoxDecoration(
    color: primaryLight,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    )
  );
