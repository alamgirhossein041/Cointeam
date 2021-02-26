import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ContainerPanel extends StatefulWidget {
  ContainerPanel({Key key, this.panelVisibility}) : super(key: key);
  bool panelVisibility;

  @override
  _ContainerPanelState createState() => _ContainerPanelState();
}

class _ContainerPanelState extends State<ContainerPanel> {

  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        child: Column(
         children: <Widget> [
           SizedBox(height: displayHeight(context) * 0.035),
           Row(
             /// ### Insert some logic getting value of portfolio divided by slider value ### ///
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget> [
               Padding(
                 padding: EdgeInsets.only(left: 30),
                 child: Text("Price", style: TextStyle(fontSize: 20, color: Colors.white)),
               ),
               Padding(
                 padding: EdgeInsets.only(right: 30),
                 child: Text("\$3,616.62", style: TextStyle(fontSize: 20, color: Colors.white)),
               ),               
             ],
           ),
           Row(
             children: <Widget> [
              Padding(
                padding: EdgeInsets.fromLTRB(20,10,0,0),
                child: Container(
                  width: displayWidth(context) * 0.60,
                  child: SfSliderTheme(
                    data: SfSliderThemeData(
                      tooltipBackgroundColor: Colors.red[500],
                    ),
                    child: SfSlider(
                      min: 0.0,
                      max: 100.0,
                      value: _value,
                      interval: 100,
                      showTicks: false,
                      showLabels: false,
                      enableTooltip: true,
                      // minorTicksPerInterval: 1,
                      onChanged: (dynamic value) {
                        setState(() {
                          _value = value;
                        });
                      }
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,10,10,0),
                child: Container(
                  height: displayHeight(context) * 0.035,
                  width: displayWidth(context) * 0.09,
                  // child: TextFormField(
                  //   /// password
                  //   // controller: _passwordField,
                  //   decoration: InputDecoration(
                  //     /// hintText: "No hints",
                  //     hintStyle: TextStyle(
                  //       color: Colors.white,
                  //     ),
                  //     labelText: "15.5%",
                  //     labelStyle: TextStyle(
                  //       color: Colors.white,
                  //     )
                  //   ),
                  //   obscureText: true,
                  // ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: '15.5%',
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
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Sell All"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Container(
                  // child: MenuButton(
                  //   child: 
                  //   itemBuilder:
                  //   items:
                  // ),
                ),
              ),
            ],
          ),
          SizedBox(),
          ]
        ),
        visible: widget.panelVisibility,
      ),
    );
  }
}