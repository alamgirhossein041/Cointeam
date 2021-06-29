import 'package:flutter/material.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class PanicButton extends StatefulWidget {

  @override
  PanicButtonState createState() => PanicButtonState();
}

class PanicButtonState extends State<PanicButton> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 110, /// this helps align IconButton properly
              height: 110,
              child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () => {
                  BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
                  Navigator.pushNamed(context, '/sellportfolio'),
                },
                icon: Icon(Icons.offline_bolt, size: 110)
              ),
            ),
          ),
        ),
      ],
    );
  }
}
