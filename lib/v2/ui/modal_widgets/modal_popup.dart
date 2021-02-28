import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';

class ModalPopup extends StatefulWidget {
  ModalPopup({Key key}) : super(key: key);

  @override
  _ModalPopupState createState() => _ModalPopupState();
}

/// API tutorial modal popup
class _ModalPopupState extends State<ModalPopup> {

  /// Currently selected value of dropdown
  String dropdownValue = 'Binance';

  /// placeholder URL for API linking tutorial process
  String placeHolderImgURL = "http://2.bp.blogspot.com/_ThTvH632hGo/S92-5kncTYI/AAAAAAAAByE/7DAWC0aecC0/s640/2-7.jpg";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.70,
      width: displayWidth(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.08, -1.08),
          end: Alignment(1, 1.06),
          colors: [
            Color(0xFF443E48),
            Color(0xFF1B1F2D),
          ],
        ),
      ),

      child: Column(
        children: <Widget> [
          SizedBox(height: displayHeight(context) * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget> [
              Container(width: 58),
              Text("(3 mins)", style: TextStyle(color: Colors.white)),
              // Container(width: displayWidth(context) * 0.4,
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  Text("+50 ", style: TextStyle(color: Colors.white)),
                  Icon(Icons.av_timer, color: Colors.white),
                ],
              ),
            ],
          ),
          SizedBox(height: displayHeight(context) * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text("Connect ", style: TextStyle(color: textLight)),
              Container(
                // height: displayHeight(context) * 0.07,
                // width: displayWidth(context) * 0.18,
                child: 
                  /// Dropdown selection for API linking tutorial, select from Binance, FTX etc
                  DropdownButton<String>(
                        dropdownColor: uniColor,
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down, color: modalAccentColor),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: textLight),
                        underline: Container(
                          height: 2,
                          // TODO: andrew wants line to be shorter
                          padding: EdgeInsets.only(right: 40),
                          color: modalAccentColor,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Binance', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                //   child: TextField(
                //   textAlign: TextAlign.center,
                //   decoration: InputDecoration(
                //     labelText: 'Binance',
                //     labelStyle: TextStyle(color: Colors.white),
                //     // floatingLabelBehavior: FloatingLabelBehavior.always,
                //     // filled: true,
                //     // fillColor: Color(0xFF126FFF),
                //     enabledBorder: UnderlineInputBorder(      
                //       borderSide: BorderSide(color: Color(0X3BA6D6)),   
                //     ),  
                //   ),
                // ),
              ),
            ],
          ),
          // Image.network(placeHolderImgURL),
          Text('To enable trading, go to Binance Web', style: TextStyle(color: textLight)),
          Padding(
            padding: EdgeInsets.all(30),
            child: Image.network(placeHolderImgURL),
          ),
          
          Row(),
          Row(),
          Row(),
        ],
      ),
    );
  }
}