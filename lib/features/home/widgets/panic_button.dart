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
  bool isLive = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: GestureDetector(
            onTap: () => setState(() {
              isLive = !isLive;
            }),
            child: Column(
              children: <Widget> [
                /// State Change - Live Mode / isLive Mode
                if(!isLive)...[
                  Stack(
                    alignment: FractionalOffset.center,
                    children: <Widget> [
                      Center(
                        child: Container(
                          width: displayWidth(context) * 0.30,
                          child: Center(
                            child: Text("Live mode", style: TextStyle(color: Colors.black))
                          ),
                        ),
                      ),
                      Positioned(
                        left: displayWidth(context) * 0.65,
                        child: Icon(Icons.online_prediction, color: Colors.green, size: 20)
                      ),
                    ]
                  ),
                  Icon(Icons.toggle_on, color: Colors.black, size: 46)
                ] else...[
                  Stack(
                    alignment: FractionalOffset.center,
                    children: <Widget> [
                      Center(
                        child: Container(
                          width: displayWidth(context) * 0.30,
                          child: Center(
                            child: Text("Preview mode", style: TextStyle(color: Colors.black))
                          ),
                        ),
                      ),
                      Positioned(
                        left: displayWidth(context) * 0.65,
                        child: Icon(Icons.online_prediction, color: Colors.orange[300], size: 20)
                      ),
                    ]
                  ),
                  Icon(Icons.toggle_off, color: Colors.grey, size: 46)
                ]
              ]
            )
          ),
        ),
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
                  log(isLive.toString()),
                  BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent()),
                  Navigator.pushNamed(context, '/sellportfolio', arguments: {'preview': isLive})
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
