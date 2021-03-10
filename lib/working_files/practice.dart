import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        child:Column(
          children: <Widget> [
            Home2(name: "Bitcoin"),
            Home2(name: "Ethereum"),
            Home2(name: "Ripple"),
          ]
        ),
      ),
    );
  }
}



class Home2 extends StatelessWidget {
  Home2({Key key, this.name}) : super(key: key);
  final String name;


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text('first App'),
    //     ),
        return IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// Container 1
              Expanded(
                flex: 2,
                child: Container(
                  color: Color.fromRGBO(37, 37, 52, 1),
                  padding: EdgeInsets.all(0),
                  // padding: EdgeInsets.fromLTRB(0,14,0,14),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                    name,
                    style: TextStyle(color: Colors.white),
                  ),
                  ),
                ),
              ),
              /// Container 2
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Color.fromRGBO(37, 37, 52, 1),
                      padding: EdgeInsets.all(14),
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(37, 37, 52, 1),
                      padding: EdgeInsets.all(14),
                      child: Text(
                        name + '2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              /// Container 3
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(28.0),
                  child: Text('Bitcoin'),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 37, 52, 1),
                    /// The Hex color format is:
                    /// Color(0xFF and then the 6 Hex digits)
                    /// Color(0xFF000000)
                    /// Color(0xFF252534)
                    
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Color.fromRGBO(37, 37, 52, 1).withOpacity(0.2), BlendMode.dstATop),
                      image: AssetImage('Assets/1200px-Bitcoin.svg.png'),
                    ),
                  ),
                  margin: EdgeInsets.all(0),
                ),
              ),
            // ]));
            ]
          ),
        );
        
  }
}