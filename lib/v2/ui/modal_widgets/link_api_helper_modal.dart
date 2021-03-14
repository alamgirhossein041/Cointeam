import 'dart:developer';

import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';

class LinkAPIHelperModal extends StatefulWidget {
  LinkAPIHelperModal({Key key, this.page}) : super(key: key);

  final int page;

  @override
  _LinkAPIHelperModalState createState() => _LinkAPIHelperModalState();
}

/// API tutorial modal popup
class _LinkAPIHelperModalState extends State<LinkAPIHelperModal> {

  /// Currently selected value of dropdown
  String dropdownValue = 'Binance';

  /// placeholder URL for API linking tutorial process
  String placeHolderImgURL = "http://2.bp.blogspot.com/_ThTvH632hGo/S92-5kncTYI/AAAAAAAAByE/7DAWC0aecC0/s640/2-7.jpg";

  String userExchValue = '';

  // list of exchanges user can pick from
  List<String> exchanges = ['Binance', 'FTX'];

  // list of images to display depdning on which exchanges were selected
  List<ImageProvider> imageList = [
    AssetImage('graphics/assets/binance_user_screen.jpg'),
    AssetImage('graphics/assets/ftx_user_screen.jpg'),
    AssetImage('graphics/assets/placeholder_modal.jpg'),
  ];

  // used to specify index of imageList to display the corresponding image
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    int page = widget.page;

    /* page 1 - API linking explainer */
    if (page == 1) {
      return Container(
        decoration: bgColor,
        
        child: Column(
          children: <Widget> [

            // the (3 mins) and +50 reward line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
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
            ),

            // the "connect binance" line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("Enable trading feature button thingy here ", style: TextStyle(color: textLight)),
                ],
              ),
            ),

            // instructions text line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Text('''
              some long text about why api linking is cool
              some long text about why api linking is cool
              some long text about why api linking is cool
              some long text about why api linking is cool
              some long text about why api linking is cool
              some long text about why api linking is cool
              ''', style: TextStyle(color: textLight)),
            ),

            // pagination dots line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Align(
                alignment: Alignment.center,
                child: Text("dots go here ", style: TextStyle(color: textLight)),
              ),
            ),
          ],
        ),
      );
    } else if (page == 2) {
      /* page 2 - Connect Exchange page*/
      return Container(
        
        decoration: bgColor,
        
        child: Column(
          children: <Widget> [

            // the (3 mins) and +50 reward line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
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
            ),

            // the "connect binance" line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("Connect ", style: TextStyle(color: textLight)),
                  Container(
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
                            imageIndex = exchanges.indexOf(newValue);
                          });
                        },
                        items: exchanges.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                  ),
                ],
              ),
            ),

            // instructions text line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Text("1. To enable trading, go to Binance Web ", style: TextStyle(color: textLight)),
            ),

            // instructions image line
            Flexible(
              flex: 4,
              fit: FlexFit.tight,

              child: Image(
                image: imageList[imageIndex],
              ),
            ),

            // pagination dots line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Align(
                alignment: Alignment.center,
                child: Text("dots go here ", style: TextStyle(color: textLight)),
              ),
            ),
          ],
        ),
      );
    } else if (page == 3) {
      /* page 3 - Select api management guide image */

      

    } else if (page == 4) {
      /* page 4 */
      
    } else if (page == 5) {
      /* page 5 */
       
    } else {

    }
  } 
}

class ConnectBinanceGuide extends StatelessWidget {
  const ConnectBinanceGuide({Key key, this.exch}) : super(key: key);

  final String exch;

  @override
  Widget build(BuildContext context) {

    if (exch == 'Binance') {
      return Container(
            
        decoration: bgColor,

        // layout
        child: Column(
          children: <Widget> [

            // the (3 mins) and +50 reward line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
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
            ),

            // the "connect binance" line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("Connect Binance", style: TextStyle(color: textLight)),
                ],
              ),
            ),

            // instructions text line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Text("2. Select API Management", style: TextStyle(color: textLight)),
            ),

            // instructions image line
            Flexible(
              flex: 4,
              fit: FlexFit.tight,

              child: Image(
                image: AssetImage(('graphics/assets/placeholder_modal.jpg'))
              ),
            ),

            // pagination dots line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Align(
                alignment: Alignment.center,
                child: Text("dots go here ", style: TextStyle(color: textLight)),
              ),
            ),
          ],
        ),
      );
    } else if (exch == 'FTX') {
      return Container(

        // background gradient
        decoration: bgColor,

        // layout
        child: Column(
          children: <Widget> [

            // the (3 mins) and +50 reward line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
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
            ),

            // the "connect binance" line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("Connect  ", style: TextStyle(color: textLight)),
                ],
              ),
            ),

            // instructions text line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Text("1. To enable trading, go to Binance Web ", style: TextStyle(color: textLight)),
            ),

            // instructions image line
            Flexible(
              flex: 4,
              fit: FlexFit.tight,

              child: Image(
                image: AssetImage(('graphics/assets/placeholder_modal.jpg'))
              ),
            ),

            // pagination dots line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Align(
                alignment: Alignment.center,
                child: Text("dots go here ", style: TextStyle(color: textLight)),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container (
        // background gradient
        decoration: bgColor,
        child: Text("we did something wrong and now you're here. press button to go back :)", style: TextStyle(color: textLight)),
      );
    }
  }
}

// background colour
var bgColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment(-1.08, -1.08),
    end: Alignment(1, 1.06),
    colors: [
      Color(0xFF443E48),
      Color(0xFF1B1F2D),
    ],
  ),
);
