import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui_root/template/home_old/home_view.dart';
import 'package:coinsnap/ui_root/v2/helper_widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Second extends StatefulWidget {
  const Second({Key key}) : super(key: key);

  @override
  SecondState createState() => SecondState();
}

class SecondState extends State<Second> with TickerProviderStateMixin {
  AnimationController animationControllerOneMoreThing;
  Animation<double> animationOneMoreThing;
  AnimationController animationControllerRewards;
  Animation<double> animationRewards;
  AnimationController animationControllerButtons;
  Animation<double> animationButtons;

  @override 
  void initState() {
    super.initState();
    animationControllerOneMoreThing = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animationOneMoreThing = Tween(begin: 0.0, end: 1.0).animate(animationControllerOneMoreThing);

    animationControllerRewards = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationRewards = Tween(begin: 0.0, end: 1.0).animate(animationControllerRewards);

    animationControllerButtons = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationButtons = Tween(begin: 0.0, end: 1.0).animate(animationControllerButtons);
  }

  @override
  dispose() {
    animationControllerOneMoreThing.dispose();
    animationControllerRewards.dispose();
    animationControllerButtons.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      animationControllerOneMoreThing.forward();
      Future.delayed(Duration(milliseconds: 2500), () {
        animationControllerRewards.forward();
        Future.delayed(Duration(milliseconds: 2000), () {
            animationControllerButtons.forward();
          });
      });
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF4180FF),
        ),
        child: Column(
          children: <Widget> [
            /// ### Top row -> Night mode button START ### ///
            SizedBox(height: displayHeight(context) * 0.065),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                IconButton(
                  icon: Icon(Icons.nights_stay_rounded, color: Colors.white),
                  onPressed: () {}
                ),
                SizedBox(width: displayWidth(context) * 0.065),
              ],
            ),
            /// ### Top row -> Night mode button END ### ///
            
            /// ### Welcome Text -> Middle of screen START ### ///
            SizedBox(height: displayHeight(context) * 0.15),
            FadeTransition(
              opacity: animationOneMoreThing,
              child: Text("One more thing:", style: TextStyle(fontSize: 22, color: Colors.white)),
            ),
            SizedBox(height: displayHeight(context) * 0.05),
            FadeTransition(
              opacity: animationRewards,
              child: Text("You earn rewards\nby using this app", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            SizedBox(height: displayHeight(context) * 0.10),
            FadeTransition(
              opacity: animationButtons,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/authentication');
                },
                child: Text("Cool! Take me to the app"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}