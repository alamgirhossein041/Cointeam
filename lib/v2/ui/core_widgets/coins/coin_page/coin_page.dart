import 'dart:developer';

import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';

class CoinPage extends StatefulWidget {
  CoinPage({Key key}) : super(key: key);

  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  final double modalEdgePadding = 10;
  double usdValue = 0.0;
  String usdValueString = '';
  double btcValue = 0.0;
  String coinName = '';
  String coinTicker = '';
  double balance = 0.0;
  String balanceString = '';
  double totalValue = 0.0;
  String totalValueString = '';
  double portfolioValue = 1.0;
  String portfolioShareString = '-';

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    
    /// ### Dev Testing Values ### ///
    
    if (arguments == null) {
      log("Arguments is null");
    } else {
      log("Arguments is: " + arguments['cryptoData'].toString());
      log(arguments['cryptoData'][arguments['index']].toString());
      log(arguments['cryptoData'][arguments['index']].coin);
      log(arguments['cryptoData'][arguments['index']].name);
      log(arguments['cryptoData'][arguments['index']].free.toString());
      log(arguments['cryptoData'][arguments['index']].locked.toString());
      log(arguments['cryptoData'][arguments['index']].btcValue.toString());
      usdValue = arguments['cryptoData'][arguments['index']].usdValue ;
      balance = arguments['cryptoData'][arguments['index']].free + arguments['cryptoData'][arguments['index']].locked;
      totalValue = balance * usdValue;
      coinName = arguments['cryptoData'][arguments['index']].name;
      portfolioValue = arguments['portfolioValue'];
      log(totalValue.toString());
    }

    /// ### Neatly formatting total price of coin:
    /// Eg. Dogecoin is $0.054998 = 6 decimal places is neat
    /// Eg. Bitcoin is $57,582.51 = 2 decimal places is neat
    /// QED // Conditional - If coin is greater or less than 1:
    
    if(usdValue > 1) {
      usdValueString = usdValue.toStringAsFixed(2);
    } else {
      usdValueString = usdValue.toStringAsFixed(6);
    }
    if(balance > 1000) {
      balanceString = balance.toStringAsFixed(4);
    } else {
      balanceString = balance.toStringAsFixed(8);
    }
    if(totalValue > 1) {
      totalValueString = totalValue.toStringAsFixed(2);
    } else {
      totalValueString = ' < 1';
    }

    if(totalValue != null && portfolioValue != null) {
      log(totalValue.toString());
      log(portfolioValue.toString());
      portfolioShareString = ((totalValue / portfolioValue) * 100).toStringAsFixed(1);
    }

    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.orientation == Orientation.landscape) {
      return Text("Hello World");
      /// if bloc check blabla see line 194
    } else {
      return Scaffold(
        backgroundColor: Color(0xFF0E0F18),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Container( /// ### This is the bottomappbar ### ///
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //     topRight: Radius.circular(15),
            //     topLeft: Radius.circular(15),
            //   ),
      //          boxShadow: [                                                               
      //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),       
      // ], 
            // ),
          
          
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: BottomAppBar(
                color: Color(0xFF2E374E),
                child: Column(
                  children: <Widget> [
                    SizedBox(height: 5),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [
                          IconButton(icon: Icon(Icons.swap_vert, color: Color(0xFFA9B1D9)), onPressed: () {

                            /// API Call
                            /// 

                          }),
                          // IconButton(icon: Icon(Icons.search), onPressed: () {}),
                          
                            /// /// ApiModalFirst();  /// ///
                            
                          IconButton(icon: Icon(Icons.help_center, color: Color(0xFFA9B1D9)), onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                /// Manual padding override because Dialog's default padding is FAT
                                insetPadding: EdgeInsets.all(modalEdgePadding),
                                // title: Text("Hello"),
                                // insetPadding: EdgeInsets.fromLTRB(0,1000,0,1000),
                                
                                /// Connect API tutorial modal
                                // child: ModalPopup(),
                                child: IntroScreen(),
                              ),
                            );
                          }),
                          IconButton(icon: Icon(Icons.refresh, color: Color(0xFFA9B1D9)), onPressed: () {setState(() {});}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: DrawerMenu(),
        body: Container(
          child: Column(
            children: <Widget> [
              SizedBox(height: displayHeight(context) * 0.05),
                /// ### Top Row starts here ### ///
              Builder(
                builder: (BuildContext innerContext) {
                  return TopMenuRowForCoin(precontext: innerContext, coinName: coinName);
                }
              ),
              // TopMenuRow(precontext: context),
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.only(left: 20), /// Constant padding
                      child: Icon(CryptoFontIcons.BTC, color: Colors.orange, size: 34),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text("\$" + usdValueString, style: TextStyle(color: Colors.white, fontSize: 24))
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("+ \$xxx.xx (y.yy%)", style: TextStyle(color: Colors.greenAccent[400], fontSize:12))
                            ),),
                          )
                        ]
                      )
                    )
                  ]
                )
              ),
              Expanded(
                flex: 12,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// ### Buy button ### ///
                      
                      Container(
                        height: displayHeight(context) * 0.055,
                        width: displayWidth(context) * 0.35,
                        // child: Card(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(20)),
                        //   ),
                          child: InkWell(
                            splashColor: Colors.red,
                            highlightColor: Colors.red,
                            hoverColor: Colors.red,
                            focusColor: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF2B3139),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Buy", style: TextStyle(color: Colors.white))
                              ),
                            ),
                            onTap: () => {
                              // Navigator.pushNamed(context, '/hometest'),
                              
                            },
                          // ),
                          // elevation: 2,
                        ),
                      ),
                      /// ### Sell Button ### ///
                      Container(
                        height: displayHeight(context) * 0.055,
                        width: displayWidth(context) * 0.35,
                        child: InkWell(
                          splashColor: Color(0xFF2B3139),
                          highlightColor: Color(0xFF2B3139),
                          hoverColor: Color(0xFF2B3139),
                          focusColor: Color(0xFF2B3139),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF2B3139),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Sell", style: TextStyle(color: Colors.white))
                            ),
                          ),
                          onTap: () => {
                            // Navigator.pushNamed(context, '/hometest'),
                            
                          },
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("------------", style: TextStyle(color: Colors.orange)),
                )
              ),
              Expanded(
                flex: 12,
                // child: Align(
                //   alignment: Alignment.center,
                //   child: Text("Hello World", style: TextStyle(color: Colors.white))
                // )
                child: Container(
                  constraints: BoxConstraints.expand(),
                
                  decoration: BoxDecoration(color: Color(0xFF1A1B20)),
                  child: Container(
                    padding: EdgeInsets.only(top: 10), /// modal padding constant
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Investment", style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text("\$" + totalValueString, style: TextStyle(color: Colors.white, fontSize: 24)),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget> [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Holdings", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        child: Text(balanceString, style: TextStyle(color: Colors.white, fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Total Purchase Cost", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        child: Text("-", style: TextStyle(color: Colors.white, fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            ),
                          )
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget> [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Portfolio Share", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        child: Text(portfolioShareString + "%", style: TextStyle(color: Colors.blue[400], fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Total Profit/Loss", style: TextStyle(color: Colors.blueGrey)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(30,5,0,0),
                                        // child: Text("+\$92,241.16", style: TextStyle(color: Colors.blue[200], fontSize: 18)),
                                        // child: Text("-\$92,241.16", style: TextStyle(color: Colors.deepOrange[100], fontSize: 18)),
                                        child: Text("-", style: TextStyle(color: Colors.greenAccent[400], fontSize: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            ),
                          )
                        ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: <Widget> [
                                Text("Have a suggestion?", style: TextStyle(color: Colors.white))
                              ]
                            )
                          ),
                        ),
                      ]
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
}