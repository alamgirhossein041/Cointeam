// import 'dart:convert';
// import 'package:flutter/material.dart';

// import 'package:coinsnap/v2/helpers/colors_helper.dart';
// import 'package:coinsnap/v2/helpers/sizes_helper.dart';
// import 'package:coinsnap/v2/repo/coin_repo/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
// import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
// import 'package:coinsnap/v2/repo/coin_repo/aggregator/cryptocompare/chart/chart_cryptocompare_repo.dart';
// import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_buy_coin_repo.dart';
// import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_chart_repo.dart';
// import 'package:flutter/material.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:localstorage/localstorage.dart';

// class DrawerMenu extends StatefulWidget {
//   DrawerMenu({Key key}) : super(key: key);

//   @override
//   DrawerMenuState createState() => DrawerMenuState();
// }

// class DrawerMenuState extends State<DrawerMenu> {
//   final feedbackTextController = TextEditingController();
//   String testApi = "Test Api";
//   final secureStorage = FlutterSecureStorage();

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFF1E2330),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             SizedBox(height: displayHeight(context) * 0.1),
//             Align(
//               alignment: Alignment.center,
//               child: CircleAvatar(
//                 radius: displayHeight(context) * 0.05,
//                 child: Container(
//                   // height: displayHeight(context) * 0.4,
//                   // width: displayWidth(context) * 0.4,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     // borderRadius: BorderRadius.circular(10),
//                     gradient: LinearGradient(
//                       begin: Alignment(0,-1),
//                       end: Alignment(0, 1),
//                       colors: [
//                         Color(0xFFC21EDB),
//                         Color(0xFF0575FF),
//                         Color(0xFF0AE6FF),
//                       ], stops: [
//                         0.0,
//                         0.63,
//                         1.0
//                       ],
//                     )
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               // contentPadding: EdgeInsets.fromLTRB(20,20,0,0),
//               title: Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'User Name Placeholderrrrrrrrrrr',
//                   style: TextStyle(color: Colors.white, fontSize:16),
//                 ),
//               ),
//             ),
//             DottedLine(dashLength: 2, dashColor: Color(0xFF526E8E)),
//             SizedBox(height: displayHeight(context) * 0.025),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               /// title: Text('Portfolio 1 - Live'),
//               title: Text(
//                 'Test Crypto Compare',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 CryptoCompareRepositoryImpl hello = CryptoCompareRepositoryImpl();
//                 hello.getHourlyCryptoCompare();
//                 // Navigator.pushReplacementNamed(context, '/first');
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               /// title: Text('Portfolio 1 - Live'),
//               title: Text(
//                 'Test Binance',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 BinanceGetChartRepositoryImpl helloBinance = BinanceGetChartRepositoryImpl();
//                 helloBinance.getBinanceChart('btc', '');
//                 // Navigator.pushReplacementNamed(context, '/first');
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               /// title: Text('Portfolio 1 - Live'),
//               title: Text(
//                 testApi,
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () async {
//                 var api = await secureStorage.read(key: "binanceApi");
//                 setState(() {
//                   testApi = api.toString();
//                 });
//                 // Navigator.pushReplacementNamed(context, '/first');
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               /// title: Text('Portfolio 1 - Live'),
//               title: Text(
//                 'Test CoinGecko',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 CoingeckoList250RepositoryImpl helloGecko = CoingeckoList250RepositoryImpl();
//                 helloGecko.getCoinMarketCapCoinLatest('1');
//                 // Navigator.pushReplacementNamed(context, '/first');
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               /// title: Text('Portfolio 1 - Live'),
//               title: Text(
//                 'Test CoinMarketCap',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 CardCoinmarketcapCoinLatestRepositoryImpl helloCmc = CardCoinmarketcapCoinLatestRepositoryImpl();
//                 helloCmc.getCoinMarketCapCoinLatest();
//                 // Navigator.pushReplacementNamed(context, '/first');
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 'Dashboard - No API',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, '/home');
//               },
//             ),
//             // ListTile(
//             //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//             //   title: Text(
//             //     'Home - With API',
//             //     style: TextStyle(color: Colors.white, fontSize:18),
//             //   ),
//             //   onTap: () {
//             //     Navigator.pushNamed(context, '/hometest');
//             //   },
//             // ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 'New Portfolio Screen',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, '/viewportfolio');
//               },  
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Delete 1st Time Login API *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final storage = FlutterSecureStorage();
//                 storage.delete(key: "welcome");
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Log Trading API *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () async {
//                 final storage = FlutterSecureStorage();
//                 String binanceApi = await storage.read(key: "binanceApi");
//                 String binanceSapi = await storage.read(key: "binanceSapi");
//                 if(binanceApi != null) {
//                   debugPrint(binanceApi);
//                   debugPrint(binanceSapi);
//                 } else {
//                   debugPrint("There is no binanceApi");
//                 }
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Delete Trading API *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final storage = FlutterSecureStorage();
//                 storage.delete(key: "trading");
                
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Clear Local Storage *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final storage = LocalStorage("coinstreetapp");
//                 storage.clear();
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Log Local Storage *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final storage = LocalStorage("coinstreetapp");
//                 debugPrint(storage.getItem("prime").toString());
//                 // json.decode(storage.getItem("prime")).forEach((k,v) {
//                 //   debugPrint(k.toString());
//                 //   debugPrint(v.toString());
//                 // });
//                 // debugPrint(storage.getItem("prime").symbol.toString());
//                 /// 19th oh mfer the key value store can't just be called as 
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Log Portfolio Data *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final storage = LocalStorage("coinstreetapp");
//                 debugPrint(storage.getItem("portfolio").toString());
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Delete Portfolio Data *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final storage = LocalStorage("coinstreetapp");
//                 storage.deleteItem("portfolio");
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Buy NEO *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final BinanceBuyCoinRepositoryImpl neo = BinanceBuyCoinRepositoryImpl();
//                 neo.binanceBuyCoin('NEOUSDT', 30);
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Buy XRP *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final BinanceBuyCoinRepositoryImpl xrp = BinanceBuyCoinRepositoryImpl();
//                 xrp.binanceBuyCoin('XRPUSDT', 30);
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Buy LTC *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final BinanceBuyCoinRepositoryImpl ltc = BinanceBuyCoinRepositoryImpl();
//                 ltc.binanceBuyCoin('LTCUSDT', 30);
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Buy BNB *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final BinanceBuyCoinRepositoryImpl bnb = BinanceBuyCoinRepositoryImpl();
//                 bnb.binanceBuyCoin('BNBUSDT', 30);
//               },
//             ),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Buy CAKE *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 final BinanceBuyCoinRepositoryImpl cake = BinanceBuyCoinRepositoryImpl();
//                 cake.binanceBuyCoin('CAKEUSDT', 25);
//               },
//             ),
//             SizedBox(height: 30),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* LOAD DEV API *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () async {
//                 final secureStorage = FlutterSecureStorage();

//                 await secureStorage.write(key: 'binanceApi', value: 'cqtoVuNi7dgrkz2w66ClFLupoBEtVvWqK53KwmT1HZohkDVbsi9lmRSo4BpjpHSU');
//                 await secureStorage.write(key: 'binanceSapi', value: 'mdRxuJLmpPgDPPfrAXMh2idVzMFeCU6lDwoxQXpBSQ2Iq8zxOdNjFdofUZT1yIgD');
//               },
//             ),
//             SizedBox(height: 30),
//             ListTile(
//               contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
//               title: Text(
//                 '* Reset Application & State *',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),
//               onTap: () {
//                 // Navigator.pushNamed(context, '/hometest');
//                 Phoenix.rebirth(context);
//               },
//             ),
//             SizedBox(height: 70),
//               Center(child: Text("Feedback Box", style: TextStyle(color: Colors.white)),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(30,30,30,10),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: TextFormField(
//                   controller: feedbackTextController,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: 10,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Center(child: Text(
//                 '(Submit Feedback)',
//                 style: TextStyle(color: Colors.white, fontSize:18),
//               ),),
//               onTap: () {
//                 // Navigator.pushNamed(context, '/hometest');
//                 /// DB: Change this log into an API call with whatever is in the text field
//                 /// ### https://flutter.dev/docs/cookbook/forms/retrieve-input ### ///
//                 debugPrint(feedbackTextController.text);
//               },
//             ),
//             SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     /// DB: Make an API call with whatever is in the text field (lol)
//     feedbackTextController.dispose();
//     super.dispose();
//   }
// }