import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter/material.dart';

/// Main card margin style.
EdgeInsets mainCardMargin() => EdgeInsets.only(left: 5, right: 5);
// Home is a special case as it needs to have room at the top for the coin ticker.
EdgeInsets mainCardMarginHome() => EdgeInsets.only(top: 34, left: 5, right: 5);

/// Main card padding
EdgeInsets mainCardPadding() => EdgeInsets.symmetric(horizontal: 40, vertical: 45);
EdgeInsets mainCardPaddingVertical() => EdgeInsets.symmetric(vertical: 45);
EdgeInsets mainCardPaddingHorizontal() => EdgeInsets.symmetric(horizontal: 40);

// Snapshot log card padding
EdgeInsets snapshotCardPadding() => EdgeInsets.only(left: 20, right: 10, top: 45);


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