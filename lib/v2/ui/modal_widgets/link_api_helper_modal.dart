import 'package:coinsnap/v2/helpers/colors_helper.dart';
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

  // list of exchanges user can pick from
  List<String> exchanges = ['Binance', 'FTX'];

  // list of images to display depdning on which exchanges were selected
  List<ImageProvider> imageList = [
    AssetImage('graphics/assets/binance_user_screen.jpg'),
    AssetImage('graphics/assets/ftx_user_screen.jpg'),
    AssetImage('graphics/assets/placeholder_modal.jpg'),
  ];

  // used to specify index of imageList to display the corresponding image:
  // Binance or FTX screenshots
  int imageIndex = 0;

  // padding for all modal pages
  var modalPadding = EdgeInsets.all(20.0);

   @override
  Widget build(BuildContext context) {
    int page = widget.page;

    /* page 1 - API linking explainer */
    if (page == 1) {

      return Container(
        padding: modalPadding,
        
        child: Column(
          children: <Widget> [
            
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalTopBar(3),
            ),

            // the "connect binance" line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText("Enable trading features button thingy"),
            ),

            // instructions text line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,

              child: Text('''
some long text about why api linking is cool some long text about why api linking is cool some long text about why api linking is cool

some long text about why api linking is cool

some long text about why api linking is cool some long text about why api linking is cool some long text about why api linking is cool
              ''', style: TextStyle(color: textLight)),
            ),
          ],
        ),
      );
    } else if (page == 2) {
      /* page 2 - Connect Exchange page */
      return Container(

        padding: modalPadding,
        
        child: Column(
          children: <Widget> [
            
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalTopBar(3),
            ),

            // the "connect binance" line
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("Connect ", style: TextStyle(color: textLight)),

                  /// Dropdown selection for API linking tutorial, select from Binance, FTX etc
                  Container(
                    child: DropdownButton<String>(
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
          ],
        ),
      );
    } else if (page == 3) {
      /* page 3 - Select api management guide image */
      return Container (
         
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalTopBar(3),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalHeading("Connect Binance"),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText("2. Select 'API management'"),
            ),

            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Image(
                image: imageList[imageIndex],
              ),
            ),
          ]
        )
      );
    } else if (page == 4) {
      /* page 4 */
      return Container (
         
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalTopBar(3),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText("3. Give API key a name and create"),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Image(
                image: imageList[imageIndex],
              ),
            ),
          ]
        ),
      );
    } else if (page == 5) {
      /* page 5 */
      return Container (
         
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalTopBar(2),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText("4. Expand to show Secret Key"),
            ),

            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Image(
                image: imageList[imageIndex],
              ),
            ),
          ]
        ),
      );
    } else if (page == 6) {
      /* page 6 */
      // Initially password is obscured
      bool _obscureText = true;

      return Container (
         
        padding: modalPadding,
        child: Column(
          children: <Widget> [

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalTopBar(2),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText("5. Paste Secret API Key"),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit:FlexFit.tight,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return TextField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.deepPurpleAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.deepPurpleAccent),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Secret API key',
                          helperText: "(We only need the Secret API Key)",
                          helperStyle: TextStyle(color: Colors.white),
                          // toggle visibility on/off
                          suffixIcon: IconButton(
                            icon: _obscureText? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() => _obscureText = !_obscureText);
                            },
                            color: Colors.grey,
                          )
                        ),
                        style: TextStyle(color: textLight)
                      );
                    },
                  ),
                ) 
              ],
            ),
          ]
        ),
      );
      } else if (page == 7) {
      /* page 7 */
      return Container (
         
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText("Binance Linked"),
            ),

          ]
        ),
      );
    } else {
      return Container (
         
        padding: modalPadding,

      );
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
         //.*
        child: Text("we did something wrong and now you're here. press button to go back :)", style: TextStyle(color: textLight)),
      );
    }
  }
}

// Helper classes

/// the (3 mins) and +50 reward line
/// 
/// {@time estimated time to complete API linking}
class ModalTopBar extends StatelessWidget {
  ModalTopBar(this.time);

  final int time;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Text("($time mins)", style: TextStyle(color: Colors.white)),
      ],
    );
  }
}


/// Text to guide the user through the process
/// 
/// {@text guide text to display}
class ModalGuideText extends StatelessWidget {
  ModalGuideText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Text("$text", style: TextStyle(color: textLight)),
      ],
    );
  }
}

class ModalHeading {
  ModalHeading(this.text);
  String text;
  
  Widget build(BuildContext context) {
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Text("$text", style: TextStyle(color: textLight)),
      ],
    );
  }
}