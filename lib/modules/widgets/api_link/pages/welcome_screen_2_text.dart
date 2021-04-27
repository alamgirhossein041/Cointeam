import 'dart:developer';

import 'package:coinsnap/modules/home/pages/home.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';

class LinkAPIText extends StatefulWidget {

  @override
  LinkAPITextState createState() => LinkAPITextState();
}

class LinkAPITextState extends State<LinkAPIText> {
  TextEditingController _secretApiTextController = TextEditingController();
  TextEditingController _publicApiTextController = TextEditingController();
  bool _secretValidate = true;
  bool _publicValidate = true;

  @override
  void dispose() {
    _secretApiTextController.dispose();
    _publicApiTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: displayHeight(context),
          width: displayWidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2B064B), Color(0xFF381AA2)]
            ),
          ),
          child: Column(
            children: <Widget> [
              SizedBox(height: 35),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                    child: Text("Skip"),
                    onPressed: () {
                      writeStorage("welcome", "true");
                      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/second'));
                    },
                  )
                )
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Link Binance API", style: TextStyle(fontSize: 22)),
                )
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30,0,30,0),
                    child: TextFormField(
                      controller: _publicApiTextController,
                      // onChanged: _onChanged,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Theme.of(context).accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).accentColor),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Public API key',
                        helperText: "",
                        helperStyle: TextStyle(color: Colors.white),
                        errorText: _publicValidate ? null : 'This is not a valid API key',
                        errorStyle: TextStyle(color: Colors.red[200]),
                        // toggle visibility on/off
                        // suffixIcon: IconButton(
                        //   icon: _obscureText? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off),
                        //   onPressed: () {
                        //     setState(() => _obscureText = !_obscureText);
                        //   },
                        //   color: Colors.grey,
                        // )
                      ),
                      style: Theme.of(context).textTheme.bodyText1
                    ),
                  )
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30,15,30,0),
                    child: TextFormField(
                      controller: _secretApiTextController,
                      // obscureText: _obscureText,
                      // onChanged: _onChanged,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Theme.of(context).accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).accentColor),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Secret API key',
                        helperText: "",
                        helperStyle: TextStyle(color: Colors.white),
                        errorText: _secretValidate ? null : 'This is not a valid API key',
                        errorStyle: TextStyle(color: Colors.red[200]),
                        // toggle visibility on/off
                        // suffixIcon: IconButton(
                        //   icon: _obscureText? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off),
                        //   onPressed: () {
                        //     setState(() => _obscureText = !_obscureText);
                        //   },
                        //   color: Colors.grey,
                        // )
                      ),
                      style: Theme.of(context).textTheme.bodyText1
                    )
                  ),
                )
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
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
                          child: Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                        ),
                      ),
                      onTap: () => {
                        log("PublicAPI Length: " + _publicApiTextController.text.length.toString()),
                        log("SecretAPI Length: " + _secretApiTextController.text.length.toString()),
                        // if(_publicApiTextController.)
                        if(_publicApiTextController.text.length != 64) {
                          if(_secretApiTextController.text.length != 64) {
                            setState(() {
                              _secretValidate = false;
                              _publicValidate = false;
                            })
                          } else {
                            setState(() {
                              _secretValidate = true;
                              _publicValidate = false;
                            })
                          }
                        } else if(_secretApiTextController.text.length != 64) {
                          setState(() {
                            _secretValidate = false;
                            _publicValidate = true;
                          })
                        } else {
                          _secretValidate = true,
                          _publicValidate = true,
                          Navigator.pushNamed(context, '/checkapi', arguments: {'api': _publicApiTextController.text, 'sapi': _secretApiTextController.text}),
                          setState(() {
                          })
                        }
                      },
                    ),
                  ),
                ),
              ),
            ]
          )
        )
      ),
    );
  }
}