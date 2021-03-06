
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:flutter/material.dart';

class AddCoin extends StatelessWidget {
  const AddCoin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      body: Container(
      decoration: BoxDecoration(color: Color(0xFF101010)),
      child: Column(
        children: <Widget> [
          SizedBox(height: displayHeight(context) * 0.05),
          TopMenuRow(),
          Container(
            height: displayHeight(context) * 0.7,
            width: displayWidth(context) * 0.8,
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
                    SizedBox(height: displayHeight(context) * 0.06),
                    Text("Placeholder for dropdown menu autocomplete", style: TextStyle(color: Colors.white, fontSize: 24)),
                    SizedBox(height: displayHeight(context) * 0.03),
                    Text("Placeholder for coin's price", style: TextStyle(color: Colors.white, fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Column(
                          children: <Widget> [
                            Text("Placeholder MCap", style: TextStyle(color: Colors.white, fontSize: 16)),
                            Text("Market cap", style: TextStyle(color: Colors.white, fontSize: 16))
                          ],
                        ),
                        Column(
                          children: <Widget> [
                            Text("00%", style: TextStyle(color: Colors.white, fontSize: 16)),
                            Text("Market Dominance", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Column(
                          children: <Widget> [
                            Text("\$2222.22", style: TextStyle(color: Colors.white, fontSize: 16)),
                            Text("24h Price Change", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: <Widget> [
                            Text("0.0", style: TextStyle(color: Colors.white, fontSize: 16)),
                            Text("Min. Trade Step Size", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ]
                        )
                      ]
                    ),
                    ColourfulButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),),
    );
  }
}