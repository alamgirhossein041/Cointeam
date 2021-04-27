import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_bloc.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_event.dart';
import 'package:coinsnap/modules/home/pages/home.dart';
import 'package:coinsnap/modules/services/firebase_analytics.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key key}) : super(key: key);

  @override
  DrawerMenuState createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu> {
  final feedbackTextController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E2330),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: displayHeight(context) * 0.1),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: displayHeight(context) * 0.05,
                child: Container(
                  // height: displayHeight(context) * 0.4,
                  // width: displayWidth(context) * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(0,-1),
                      end: Alignment(0, 1),
                      colors: [
                        Color(0xFFC21EDB),
                        Color(0xFF0575FF),
                        Color(0xFF0AE6FF),
                      ], stops: [
                        0.0,
                        0.63,
                        1.0
                      ],
                    )
                  ),
                ),
              ),
            ),
            ListTile(
              // contentPadding: EdgeInsets.fromLTRB(20,20,0,0),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome',
                  style: TextStyle(color: Colors.white, fontSize:16),
                ),
              ),
            ),
            DottedLine(dashLength: 2, dashColor: Color(0xFF526E8E)),
            SizedBox(height: displayHeight(context) * 0.025),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                'Dashboard',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                'My Portfolio',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                analytics.logEvent(
                  name: "check_portfolio",
                  parameters: {"clickedFrom": "menu"}
                );
                Navigator.pushReplacementNamed(context, '/viewportfolio');
              },  
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Row(
                children: <Widget> [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      "Sell   ",
                      style: TextStyle(color: Colors.white, fontSize:18),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(Icons.bolt, color: Colors.yellowAccent[200]),
                    ),
                  ),
                ],
              ),
              onTap: () {
                BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                Navigator.pushNamed(context, '/sellportfolio');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Row(
                children: <Widget> [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      "Buy   ",
                      style: TextStyle(color: Colors.white, fontSize:18),
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(Icons.bolt, color: Colors.blue[200]),
                    ),
                  ),
                ],
              ),
              onTap: () {
                BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                Navigator.pushNamed(context, '/buyportfolio');
              },
            ),
            FutureBuilder(
              future: readStorage("trading"),
              builder: (context, snapshot) {
                if(snapshot.data != null) {
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
                    title: Text(
                      "Link Api",
                      style: TextStyle(color: Colors.white, fontSize:18),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/second');
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     "Binance API real quick",
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final secureStorage = FlutterSecureStorage();
            //     secureStorage.write(key: "binance", value: "true");
            //   },
            // ),
            SizedBox(height: 200),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            /// ///
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Delete 1st Time Login API *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                final storage = FlutterSecureStorage();
                storage.delete(key: "welcome");
              },
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Log Trading API *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () async {
            //     final storage = FlutterSecureStorage();
            //     String binanceApi = await storage.read(key: "binanceApi");
            //     String binanceSapi = await storage.read(key: "binanceSapi");
            //     if(binanceApi != null) {
            //       debugPrint(binanceApi);
            //       debugPrint(binanceSapi);
            //     } else {
            //       debugPrint("There is no binanceApi");
            //     }
            //   },
            // ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Delete Trading API *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () async {
                final storage = FlutterSecureStorage();
                await storage.delete(key: "trading");
                await storage.delete(key: "binance");
                
              },
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Clear Local Storage *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final storage = LocalStorage("coinstreetapp");
            //     storage.clear();
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Log Local Storage *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final storage = LocalStorage("coinstreetapp");
            //     debugPrint(storage.getItem("prime").toString());
            //     // json.decode(storage.getItem("prime")).forEach((k,v) {
            //     //   debugPrint(k.toString());
            //     //   debugPrint(v.toString());
            //     // });
            //     // debugPrint(storage.getItem("prime").symbol.toString());
            //     /// 19th oh mfer the key value store can't just be called as 
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Log Portfolio Data *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final storage = LocalStorage("coinstreetapp");
            //     debugPrint(storage.getItem("portfolio").toString());
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Delete Portfolio Data *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final storage = LocalStorage("coinstreetapp");
            //     storage.deleteItem("portfolio");
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Buy NEO *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final BinanceBuyCoinRepositoryImpl neo = BinanceBuyCoinRepositoryImpl();
            //     neo.binanceBuyCoin('NEOUSDT', 30);
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Buy XRP *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final BinanceBuyCoinRepositoryImpl xrp = BinanceBuyCoinRepositoryImpl();
            //     xrp.binanceBuyCoin('XRPUSDT', 30);
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Buy LTC *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final BinanceBuyCoinRepositoryImpl ltc = BinanceBuyCoinRepositoryImpl();
            //     ltc.binanceBuyCoin('LTCUSDT', 30);
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Buy BNB *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final BinanceBuyCoinRepositoryImpl bnb = BinanceBuyCoinRepositoryImpl();
            //     bnb.binanceBuyCoin('BNBUSDT', 30);
            //   },
            // ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Buy CAKE *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     final BinanceBuyCoinRepositoryImpl cake = BinanceBuyCoinRepositoryImpl();
            //     cake.binanceBuyCoin('CAKEUSDT', 25);
            //   },
            // ),
            // SizedBox(height: 30),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* LOAD DEV API *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () async {
            //     final secureStorage = FlutterSecureStorage();

            //     await secureStorage.write(key: 'binanceApi', value: 'cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU');
            //     await secureStorage.write(key: 'binanceSapi', value: 'mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD');
            //   },
            // ),
            // SizedBox(height: 30),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     '* Reset Application & State *',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     // Navigator.pushNamed(context, '/hometest');
            //     Phoenix.rebirth(context);
            //   },
            // ),
            // /// Comment up to here ///
            // SizedBox(height: 70),
            //   Center(child: Text("Feedback Box", style: TextStyle(color: Colors.white)),
            // ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(30,30,30,10),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //     ),
            //     child: TextFormField(
            //       controller: feedbackTextController,
            //       keyboardType: TextInputType.multiline,
            //       maxLines: 10,
            //     ),
            //   ),
            // ),
            // ListTile(
            //   title: Center(child: Text(
            //     '(Submit Feedback)',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),),
            //   onTap: () {
            //     // Navigator.pushNamed(context, '/hometest');
            //     /// DB: Change this log into an API call with whatever is in the text field
            //     /// ### https://flutter.dev/docs/cookbook/forms/retrieve-input ### ///
            //     debugPrint(feedbackTextController.text);
            //   },
            // ),
            // SizedBox(height: 500),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    /// DB: Make an API call with whatever is in the text field (lol)
    feedbackTextController.dispose();
    super.dispose();
  }
}