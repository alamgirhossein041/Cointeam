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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 118.0,
          height: 118.0,
          decoration: new BoxDecoration(
            color: primaryGreen,
            shape: BoxShape.circle,
          ),
        ),
        // Container(
        //   width: 90,
        //   height: 90,
        //   decoration: new BoxDecoration(
        //     color: primaryLight,
        //     shape: BoxShape.circle,
        //   ),
        // ),
        Container(
          width: 90,
          height: 90,
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
        ),
        Container(
          width: 128,
          height: 128,
          child: DottedBorder(
            borderType: BorderType.Circle,
            color: primaryGreen,
            strokeWidth: 2,
            dashPattern: [0, 8.2],
            strokeCap: StrokeCap.round,
            child: Container(
              width: 4,
              height: 4,
            ),
          ),
        ),
      ],
    );
  }
}
