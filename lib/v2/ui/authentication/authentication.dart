import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  AuthenticationState createState() => AuthenticationState();
}

class AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CheckInternet().checkConnection(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF4180FF),
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
            Container(
              height: displayHeight(context) * 0.8,
              child: SizedBox.expand(
            // decoration: BoxDecoration(
            //   color: Color(0xFF4180FF),
            // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    SizedBox(height: displayHeight(context) * 0.4),
                    Container(
                      alignment: Alignment.center,
                      width: displayWidth(context) * 0.7,
                      child: Column(
                        children: <Widget> [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              filled: true,
                              fillColor: Color(0xFF126FFF),
                              enabledBorder: UnderlineInputBorder(      
                                borderSide: BorderSide(color: Colors.white),   
                              ),  
                            ),
                            // decoration: InputDecoration(
                            //   fillColor: Colors.white,
                            //   border: OutlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.white, width: 2.0),
                            //   ),
                            //   hintText: 'Email', hintStyle: TextStyle(color: Colors.white),
                            //   prefixIcon: Icon(Icons.mail_outline),
                            // ),
                            // style: TextStyle(
                            //   fontFamily: "Poppins", color: Colors.white,
                            // ),
                          ),
                          SizedBox(height: displayHeight(context) * 0.05),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              filled: true,
                              fillColor: Color(0xFF126FFF),
                              enabledBorder: UnderlineInputBorder(      
                                borderSide: BorderSide(color: Colors.white),   
                              ),  
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInternet {

  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentMessage = "Unknown";

  checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          // internetStatus = "Connected to the Internet";
          // contentMessage = "Connected to the Internet";
          // _showDialog(internetStatus, contentMessage, context);
          break;
        case DataConnectionStatus.disconnected:
          internetStatus = "You are not connected to the Internet";
          contentMessage = "Please check your connection to the Internet";
          _showDialog(internetStatus, contentMessage, context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
  void closeStream() {
  listener.cancel();
}
}

void _showDialog(String title, String content, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error"),
        content: Text(content),
        actions: <Widget> [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close")
          )
        ]
      );
    }
  );
}

