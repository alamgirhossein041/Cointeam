import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:flutter/material.dart';

class EditCoin extends StatelessWidget {
  const EditCoin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF101010),
        ),
        child: Column(
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                Icon(Icons.menu, color: Colors.white),
                Text("Edit coin", style: TextStyle(color: Colors.white)),
                Icon(Icons.settings, color: Colors.white),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFF8C00),
                    Color(0xFF874800),
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding:  EdgeInsets.all(2.75),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1B20),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: <Widget> [
                            
                      SizedBox(height: displayHeight(context) * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget> [
                          Icon(Icons.access_alarm),
                          Text("Bitcoin", style: TextStyle(fontSize: 26, color: Colors.white)),
                          Container(),
                        ],
                      ),
                      Container(
                        width: displayWidth(context) * 0.8,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: "Holdings",
                            labelStyle: TextStyle(color: Colors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            // filled: true,
                            // fillColor: Color(0xFF126FFF),
                            enabledBorder: UnderlineInputBorder(      
                              borderSide: BorderSide(color: Colors.white),   
                            ),  
                          ),
                        ),
                      ),
                      SizedBox(height: displayHeight(context) * 0.05),
                      Container(
                        width: displayWidth(context) * 0.8,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: "Exchange pair",
                            labelStyle: TextStyle(color: Colors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            // filled: true,
                            // fillColor: Color(0xFF126FFF),
                            enabledBorder: UnderlineInputBorder(      
                              borderSide: BorderSide(color: Colors.white),   
                            ),  
                          ),
                        ),
                      ),
                      SizedBox(height: displayHeight(context) * 0.05),
                      Container(
                        width: displayWidth(context) * 0.8,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: "Exchange",
                            labelStyle: TextStyle(color: Colors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            // filled: true,
                            // fillColor: Color(0xFF126FFF),
                            enabledBorder: UnderlineInputBorder(      
                              borderSide: BorderSide(color: Colors.white),   
                            ),  
                          ),
                        ),
                      ),
                      SizedBox(height: displayHeight(context) * 0.05),
                      Container(
                        width: displayWidth(context) * 0.8,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: "Notes",
                            labelStyle: TextStyle(color: Colors.white),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            // filled: true,
                            // fillColor: Color(0xFF126FFF),
                            enabledBorder: UnderlineInputBorder(      
                              borderSide: BorderSide(color: Colors.white),   
                            ),  
                          ),
                        ),
                      ),
                      SizedBox(height: displayHeight(context) * 0.05),
                      ColourfulButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
