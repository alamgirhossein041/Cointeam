import 'package:coinsnap/features/services/firebase_analytics.dart';
import 'package:coinsnap/features/utils/localstorage/storage.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class First extends StatefulWidget {
  
  @override
  FirstState createState() => FirstState();
}

class FirstState extends State<First> with TickerProviderStateMixin{
  AnimationController animationControllerWelcome;
  Animation<double> animationWelcome;
  bool _visible = true;

  final storage = FlutterSecureStorage();
  
  @override
  void initState() { 
    super.initState();
    /// ### We call storage.deleteAll() once on first time use,
    /// ### This prevents a host of android specific errors related,
    /// ### To hanging due to old bits of storage
    storage.deleteAll();
    analytics.logEvent(
      name: 'welcome_screen_1'
    );
    
    /// Initialise animationControllers here if needed
    animationControllerWelcome = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
    );
    animationWelcome = Tween(begin: 0.0, end: 1.0).animate(animationControllerWelcome);
  }

  @override
  dispose() {
    animationControllerWelcome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_visible == true) {
      Future.delayed(Duration(milliseconds: 1000), () {
        animationControllerWelcome.forward();
        Future.delayed(Duration(milliseconds: 2000), () {
          animationControllerWelcome.reverse();
        });
      });
    }
    if(_visible == true) {
      Future.delayed(Duration(milliseconds: 5000), () {
        debugPrint("Wat");
          setState(() {
            _visible = !_visible;
          });
      });
    }
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget> [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              /// ### Fades out ### ///
              child: AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF2B064B), Color(0xFF381AA2)]
                    ),
                  ),
                  child: Column(
                    children: <Widget> [
                      SizedBox(height: displayHeight(context) * 0.1),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.nights_stay_rounded, color: Colors.white),
                            onPressed: () {}
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: FadeTransition(
                          opacity: animationWelcome,
                          child: Text("Welcome", style: TextStyle(fontSize: 30, color: Colors.white))
                        ),
                      ),
                    ]
                  )
                ),
              )
              /// ### Fades out ### ///
            ),
            AnimatedOpacity(
              opacity: _visible ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Column(
                children: <Widget> [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      children: <Widget> [
                        Text("You're invited", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)),
                        SizedBox(height: 10),
                        Text("to participate in", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)),
                        SizedBox(height: 10),
                        Text("Coinstreet's beta.", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)),
                      ]
                    )
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      children: <Widget> [
                        Text("Get started", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300)),
                        SizedBox(height: 25),
                        Text("Featuring Binance and FTX", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ]
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Column(
                      children: <Widget> [
                        ///
                        Container(
                          height: displayHeight(context) * 0.075,
                          width: displayWidth(context) * 0.75,
                            child: InkWell(
                              splashColor: Colors.red,
                              highlightColor: Colors.red,
                              hoverColor: Colors.red,
                              focusColor: Colors.red,
                              borderRadius: BorderRadius.circular(40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  gradient: LinearGradient(
                                    begin: Alignment(-1, 1),
                                    end: Alignment(1, -1),
                                    colors: [
                                      Color(0xFF701EDB),
                                      Color(0xFF0575FF),
                                      Color(0xFF0AABFF)
                                    ],
                                    stops: [
                                      0.0,
                                      0.77,
                                      1.0
                                    ]
                                  )
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("LINK API NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                                ),
                              ),
                              onTap: () => {
                                Navigator.pushReplacementNamed(context, '/linkapiselect')
                              },
                            // ),
                            // elevation: 2,
                          ),
                        ),
                        SizedBox(height: displayHeight(context) * 0.05),
                      ///
                        Container(
                          height: displayHeight(context) * 0.075,
                          width: displayWidth(context) * 0.75,
                          child: InkWell(
                            splashColor: Colors.red,
                            highlightColor: Colors.red,
                            hoverColor: Colors.red,
                            focusColor: Colors.red,
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                  begin: Alignment(-1, 1),
                                  end: Alignment(1, -1),
                                  colors: [
                                    Color(0xFF701EDB),
                                    Color(0xFF0575FF),
                                    Color(0xFF0AABFF)
                                  ],
                                  stops: [
                                    0.0,
                                    0.77,
                                    1.0
                                  ]
                                )
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("NO BINANCE / FTX", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                              ),
                            ),
                            onTap: () => {
                              writeStorage("welcome", "true"),
                              Navigator.pushReplacementNamed(context, '/home')
                            },
                          ),
                        ),
                      ///
                      ]
                    ),
                  ),
                ]
              ),
            ),
          ]
        )
      ),
    );
  }
}