import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/ui/modal_widgets/modal_success.dart';
import 'package:flutter/material.dart';

class LinkAPIHelperModal extends StatefulWidget {
  LinkAPIHelperModal({Key key, this.page, this.exch, this.callback}) : super(key: key);

  final int page;
  final int exch;
  final Function callback;

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

    String explainerText = '''some long text about why api linking is cool some long text about why api linking is cool some long text about why api linking is cool

some long text about why api linking is cool

some long text about why api linking is cool some long text about why api linking is cool some long text about why api linking is cool
              ''';

    // page 1 - API linking explainer
    if (page == 1) {
      return Container(
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            ModalTopBar(3), // estimated time indicator
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: ModalHeading("Enable Trading"),
            ),

            // API linking explainer
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Text(explainerText, style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      );
    } else if (page == 2) {
      // page 2 - Connect Exchange page
      return Container(
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            ModalTopBar(3), // estimated time indicator

            // modal title
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("Connect ", style: Theme.of(context).textTheme.bodyText2),
               
                  /// Dropdown selection for API linking tutorial, 
                  /// //select from Binance, FTX etc
                  Container(
                    child: DropdownButton<String>(
                      dropdownColor: uniColor,
                      value: buildDropdownValue(widget.exch),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                      iconSize: 24,
                      elevation: 16,
                      style: Theme.of(context).textTheme.bodyText2,
                      underline: Container(
                        height: 2,
                        // TODO: andrew wants line to be shorter
                        padding: EdgeInsets.only(right: 40),
                        color: Theme.of(context).accentColor,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          imageIndex = exchanges.indexOf(newValue);
                        });
                        widget.callback(imageIndex);
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
              child: ModalGuideText(page, widget.exch),
            ),

            // instructions image line
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Image(
                image: imageList[widget.exch],
              ),
            ),
          ],
        ),
      );
    } else if (page == 3) {
      // page 3 - Select api management guide image
      return Container (
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            ModalTopBar(3), // estimated time indicator

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalHeading("Connect "+ exchanges[widget.exch]),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText(page, widget.exch),
            ),

            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Image(
                image: imageList[widget.exch],
              ),
            ),
          ]
        )
      );
    } else if (page == 4) {
      // page 4
      return Container (
         
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            
            ModalTopBar(3), // estimated time indicator

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalHeading("Connect "+ exchanges[widget.exch]),
            ),

            Flexible(
              flex: 1,
              child: ModalGuideText(page, widget.exch),
            ),

            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Image(
                image: imageList[widget.exch],
              ),
            ),
          ]
        ),
      );
    } else if (page == 5) {
      // page 5 
      return Container (
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            ModalTopBar(2), // estimated time indicator

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalHeading("Connect "+ exchanges[widget.exch]),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText(page, widget.exch),
            ),

            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Image(
                image: imageList[widget.exch],
              ),
            ),
          ]
        ),
      );
    } else if (page == 6) {
      // page 6
      // TODO: this page should be refactored but i'm too scared to touch it :)
      bool _obscureText = true; // password is obscured by default

      return Container (
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            ModalTopBar(1), // estimated time indicator

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalHeading("Connect "+ exchanges[widget.exch]),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ModalGuideText(page, widget.exch),
            ),
            Flexible(
              flex: 3,
              // fit:FlexFit.tight,
              child: SingleChildScrollView(
                child: Center(
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return TextField(
                        obscureText: _obscureText,
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
                        style: Theme.of(context).textTheme.bodyText1
                      );
                    },
                  ),
                ),
              ),
            ),
          ]
        ),
      );
      } else if (page == 7) {
      // page 7
      return Container (
        padding: modalPadding,
        child: ModalSuccess(
          icon: Icon(Icons.done, color: Colors.greenAccent, size: 55),
          title: exchanges[widget.exch] + " Linked",
          body: Center(
            child: Text(
              "Congratulations!\n\nAll features of this app has been unlocked.",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
          actionButton: Center(
            child: TextButton(
              onPressed: () => {Navigator.pop(context)},
              child: Text("Return to Dashboard"),
            ),
          )
        ),
      );
    } else {
      return Container (
        padding: modalPadding,
      );
    }
  }

  // Helper function

  /// Used with the callback function to keep track of 
  /// the [selected] value on the dropdown.
  String buildDropdownValue(int selected) {
    switch (selected) {
    case 0:
      // Binance
      return 'Binance';
    case 1:
      // FTX
      return 'FTX';
    default:
      // default is Binance lel
      return 'Binance';
    break;
    }
  }
}

// Helper classes

/// Top modal bar
/// 
/// Returns a widget containing the text indicating
/// ([time] mins/min).
/// e.g. (3 mins)
class ModalTopBar extends StatelessWidget {
  ModalTopBar(this.time);

  final int time;

  Widget build(BuildContext context) {
    String label;

    // plurals :D
    label = time > 1 ? 'mins' : 'min';

    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text("($time $label)", 
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}


/// Text to guide the user through the process
/// 
/// Builds a text based on [page] number. 
/// [exch] specifies the index of the list of exchanges, where:
/// 0 = Binance,
/// 1 = FTX.
class ModalGuideText extends StatelessWidget {
  ModalGuideText(this.page, this.exch);

  // modal page number
  final int page;

  // index of exchange in list of exchanges
  // 0 - binance
  // 1 - FTX
  final int exch;

  @override
  Widget build(BuildContext context) {

    // build text first
    String text = '';
    text = buildModalGuideText(page, exch);

    // return ui with built text
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center
          )
        )
      ],
    );
  }
}

/// Modal title
///
/// Returns a Row with [text] as a headline.
class ModalHeading extends StatelessWidget {
  ModalHeading(this.text);
  final String text;
  
  Widget build(BuildContext context) {
    return Row (
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Text(text, 
          style: Theme.of(context).textTheme.headline2
        ),
      ],
    );
  }
}

// Helper functions

/// Builds modal guide text based on [page] and [exch].
///
/// [exch] specifies the index of the list of exchanges, where: 
///  0 = Binance
///  1 = FTX.
buildModalGuideText(int page, int exch) {
  String text = '';

  switch (page) {
    // page 1 has introduction text, so no case for that
    // page 2
    case 2:
      switch (exch) {
        case 0:
          text = '1. To enable trading, go to Binance Web';
          break;
        case 1:
          text = '1. To enable trading, go to FTX Web';
          break;
      default:
        text = "Error: Exchange not found ):";
      }
      break;

    // page 3
    case 3:
      switch (exch) {
        case 0:
          text = "2. Select 'API management'";
          break;
        case 1:
          text = "[FTX] 2. Select 'API management'";
          break;
        default:
        text = 'Missing text.. how did you find this?';
      }
      break;

    // page 4
    case 4:
      switch (exch) {
        case 0:
          text = "3. Give API key a name and create";
          break;
        case 1:
          text = "[FTX] 3. Give API key a name and create";
          break;
        default:
        text = 'page 4 text not found';
        break;
      }
      break;

    // page 5
    case 5:
      switch (exch) {
        case 0:
          text = "4. Expand to show Secret Key";
          break;
        case 1:
          text = "[FTX] 4. Expand to show Secret Key";
          break;
        default:
        text = 'page 5 text not found';
        break;
      }
      break;

    // page 6
    case 6:
      switch (exch) {
        case 0:
          text = "5. Paste Secret API Key";
          break;
        case 1:
          text = "[FTX] 5. Paste Secret API Key";
          break;
        default:
        text = 'page 6 text not found';
        break;
      }
      break;
    default:
    text = 'Text not found.. how?';
    break;
  }
  return text;
}