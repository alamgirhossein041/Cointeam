import 'package:flutter/material.dart';

import 'package:coinsnap/v2/helpers/sizes_helper.dart';
// import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/main/home_view.dart';
import 'package:coinsnap/v2/ui/widgets/helper_widgets/loading_screen.dart';
import 'package:coinsnap/working_files/dashboard_initial_noAPI.dart';
import 'package:coinsnap/working_files/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class First2 extends StatelessWidget {
  const First2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(), /// Getting a local settings cache stored on device
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (!snapshot.hasError) {
              return snapshot.data.getBool("welcome") != null /// getBool("welcome") should be named better - it is a boolean check which is null if it's the user's first time -> which we will load WelcomeView (onboarding screen), and if not null we will load HomeView
                  ? WelcomeView()
                  : InitialPage();
            } else {
              return errorTemplateWidget(snapshot.error);
            }
          }
        },
      ),
    );
  }
}

class WelcomeView extends StatefulWidget {
  WelcomeView({Key key}) : super(key: key);

  @override
  WelcomeViewState createState() => WelcomeViewState();
}

class WelcomeViewState extends State<WelcomeView> with TickerProviderStateMixin {
  AnimationController animationControllerWelcome;
  Animation<double> animationWelcome;
  AnimationController animationControllerQuestion;
  Animation<double> animationQuestion;
  AnimationController animationControllerButtons;
  Animation<double> animationButtons;

  @override 
  void initState() {
    debugPrint("WELCOMEVIEW IN FIRST.DART");
    super.initState();
    animationControllerWelcome = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
    );
    animationWelcome = Tween(begin: 0.0, end: 1.0).animate(animationControllerWelcome);

    animationControllerQuestion = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationQuestion = Tween(begin: 0.0, end: 1.0).animate(animationControllerQuestion);

    animationControllerButtons = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationButtons = Tween(begin: 0.0, end: 1.0).animate(animationControllerButtons);
  }

  @override
  dispose() {
    animationControllerWelcome.dispose();
    animationControllerQuestion.dispose();
    animationControllerButtons.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      // Do something
      animationControllerWelcome.forward();
      Future.delayed(Duration(milliseconds: 1000), () {
      // Do something
        animationControllerWelcome.reverse();
        Future.delayed(Duration(milliseconds: 1500), () {
      // Do something
          animationControllerQuestion.forward();
          Future.delayed(Duration(milliseconds: 1000), () {
            animationControllerButtons.forward();
          });
        });
      });
    });
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // color: Color(0xFF4180FF),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C0751), Color(0xFF381BA1)]
          ),
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
              opacity: animationWelcome,
              child: Text("Welcome", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            SizedBox(height: displayHeight(context) * 0.05),
            // FadeTransition(
            //   opacity: animationQuestion,
            //   child: Text("What is your experience in crypto?", style: TextStyle(fontSize: 22, color: Colors.white)),
            // ),
            // FadeTransition(
            //   opacity: animationButtons,
            //   child: Column(
            //     children: <Widget> [
            //       SizedBox(height: displayHeight(context) * 0.10),
            //       ElevatedButton(
            //         onPressed: () {
            //           Navigator.pushNamed(context, '/second');
            //         },
            //         child: Text("Experienced - I want to import my portfolio"),
            //       ),

                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topRight,
                  //       end: Alignment.bottomLeft,
                  //       colors: [appPink, Colors.blue],
                  //     ),
                  //     borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  //   ),

                    // Material(
                    //   // child: Ink(
                    //   //   decoration: BoxDecoration(
                    //   //     gradient: LinearGradient(
                    //   //       begin: Alignment.topRight,
                    //   //       end: Alignment.bottomLeft,
                    //   //       colors: [appPink, Colors.blue],
                    //   //     ),
                    //   //   ),
                    //     // child: InkWell(
                    //     child: InkWell(
                    //       onTap: () {},
                    //       child: Container(
                            
                    //       ), // other widget
                    //     ),
                    //   ),
                        
                      //   child: Text("Yes - take me to the app"),
                      // ),
                        // child: Container(
                        //   width: displayWidth(context) * 0.6,
                        //   constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                        //   alignment: Alignment.center,
                        //   child: Text(
                        //     'Yes - take me to the app',
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),

                   
                  // SizedBox(height: displayHeight(context) * 0.05),
          //         ElevatedButton(
          //           child: Text("Not experienced - I just want to look around"),
          //           onPressed: () {
          //             Navigator.pushNamed(context, '/second');
          //           }
          //         ),
          //       ],
          //     ),
          //   )
          //   /// ### Welcome Text -> Middle of screen START ### ///
          ],
        ),
      ),
    );
  }
}