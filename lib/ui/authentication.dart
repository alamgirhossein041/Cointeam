import 'package:coinsnap/firebase/flutterfire.dart';
import 'package:flutter/material.dart';
import '../resource/sizes_helper.dart';
import '../resource/colors_helper.dart';
import 'home_view.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [appPink, Colors.blue]
            /// temp colours
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailField,
              decoration: InputDecoration(
                /// hintText: "Dummy",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.white,
                )
              ),
              /// email address
            ),
            TextFormField(
              /// password
              controller: _passwordField,
              decoration: InputDecoration(
                /// hintText: "No hints",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.white,
                )
              ),
              obscureText: true,
            ),
            SizedBox(
              height: displayHeight(context) * 0.1,
            ),
            Container(
              width: displayWidth(context) / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await register(_emailField.text, _passwordField.text);
                  if(shouldNavigate) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                  } else {
                    print("error");
                  }
                },
                child: Text("Register"),
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.01,
            ),
            Container(
              width: displayWidth(context) / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await signIn(_emailField.text, _passwordField.text);
                  if(shouldNavigate) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
                  } else {
                    print("error");
                  }
                },
                child: Text("Login"),
              ),
            ),
          ],
        )
      ),
    );
  }
}