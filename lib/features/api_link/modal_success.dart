// import 'package:coinsnap/modules/home/pages/home.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// End screen for Modal when action was successful
/// 
/// {@icon Icon to display}
/// {@title Title text}
/// {@body body Widget to display}
/// {@actionButton Next action to take from this end screen, usually "ok" or "return to dash" etc.}
class ModalSuccess extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2B064B), Color(0xFF381AA2)]
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Icon(Icons.done, color: Colors.greenAccent, size: 55),
              ),
              Flexible(
                flex: 1,
                // fit: FlexFit.tight,
                child: Text(
                  "API Linked",
                  style: Theme.of(context).textTheme.headline1
                ),
              ),
              Flexible(
                flex: 2,
                // fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    "Congratulations!\n\nNew features of this app have been unlocked.",
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                // fit: FlexFit.tight,
                child: Center(
                  child: TextButton(
                    onPressed: () => {
                      // writeStorage("welcome", "true"),
                      // future: readStorage("welcome"),
                      Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> route) => false),
                    },
                    child: Text("Dashboard"),
                  ),
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}