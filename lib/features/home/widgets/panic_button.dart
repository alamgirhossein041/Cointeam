import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

class PanicButton extends StatefulWidget {
  @override
  PanicButtonState createState() => PanicButtonState();
}

class PanicButtonState extends State<PanicButton> {
  @override
  Widget build(BuildContext context) {
    Widget _horizontalBar = Container(
      width: displayWidth(context),
      height: 4,
      color: primaryGreen,
    );
    // Solid green circle
    Widget _greenCircle = Container(
      width: 118.0,
      height: 118.0,
      decoration: new BoxDecoration(
        color: primaryGreen,
        shape: BoxShape.circle,
      ),
    );
    // The actual button being pressed. Has the bolt icon.
    Widget _boltButton = Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: primaryDark.withOpacity(0.25), blurRadius: 8, spreadRadius: 1)
          ]),
      child: ElevatedButton(
        child: SvgPicture.asset('graphics/assets/svg/bolt_green.svg'),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: primaryLight,
        ),
        onPressed: () => {
          BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
          Navigator.pushNamed(context, '/sellportfolio'),
        },
      ),
    );
    // Here begins the series of dotted circles lol
    Widget _dottedCircle1 = Container(
      width: 128,
      height: 128,
      child: DottedBorder(
        borderType: BorderType.Circle,
        color: primaryGreen.withOpacity(0.9),
        strokeWidth: 2.5,
        dashPattern: [0, 6.8],
        strokeCap: StrokeCap.round,
        child: Container(
          width: 4,
          height: 4,
        ),
      ),
    );
    Widget _dottedCircle2 = Container(
      width: 142,
      height: 142,
      child: DottedBorder(
        borderType: BorderType.Circle,
        color: primaryGreen.withOpacity(0.5),
        strokeWidth: 2.5,
        dashPattern: [0, 9.1],
        strokeCap: StrokeCap.round,
        child: Container(
          width: 4,
          height: 4,
        ),
      ),
    );
    Widget _dottedCircle3 = Container(
      width: 158,
      height: 158,
      child: DottedBorder(
        borderType: BorderType.Circle,
        color: primaryGreen.withOpacity(0.3),
        strokeWidth: 2.5,
        dashPattern: [0, 14.7],
        strokeCap: StrokeCap.round,
        child: Container(
          width: 4,
          height: 4,
        ),
      ),
    );
    Widget _dottedCircle4 = Container(
      width: 178,
      height: 178,
      child: DottedBorder(
        borderType: BorderType.Circle,
        color: primaryGreen.withOpacity(0.2),
        strokeWidth: 2.5,
        dashPattern: [0, 18],
        strokeCap: StrokeCap.round,
        child: Container(
          width: 4,
          height: 4,
        ),
      ),
    );
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _horizontalBar,
        _greenCircle,
        _dottedCircle1,
        _dottedCircle2,
        _dottedCircle3,
        _dottedCircle4,
        _boltButton,
      ],
    );
  }
}
