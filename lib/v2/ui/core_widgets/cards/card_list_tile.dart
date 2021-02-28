import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';

class CardListTile extends StatefulWidget {
  CardListTile({Key key, this.coinListMap, this.index}) : super(key: key);

  final CoinMarketCapCoinLatestModel coinListMap;
  final dynamic index;

  @override
  _CardListTileState createState() => _CardListTileState();
}

class _CardListTileState extends State<CardListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Container(
          child: Row(
            children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  color: appBlack, /// ### TODO: Change to Hana's UI Colour ### ///
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/coinview', arguments: {'cryptoData' : widget.coinListMap.data, 'index' : widget.index});
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(25,2,25,2),
                    height: displayHeight(context) * 0.11,
                    width: displayWidth(context),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Container(
                        // padding: EdgetInsets.fromLTRB()
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.2, 0),
                            end: Alignment(1, 0),
                            colors: [Color(0xFF282136), Color(0xFF0F1D2D)],
                            // colors: [darkRedColor, lightRedColor]
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30,0,0,0),
                          child: Row(
                            children: <Widget> [ /// ### Card Tile Internal UI Starts Here ### ///
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  CryptoFontIcons.BTC,
                                  color: Colors.orange,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget> [
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget> [
                                      Text(
                                        "${widget.coinListMap.data[widget.index].name}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text("CryptoExchange Name", style:TextStyle(color: Colors.grey, fontSize: 12)),
                                    ]
                                  )
                                ]
                              ),
                              Expanded(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget> [
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0,0,30,0),
                                    child: 
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget> [
                                      Text(
                                        "\$${widget.coinListMap.data[widget.index].quote.uSD.price.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text("", style:TextStyle(color: Colors.grey, fontSize: 12)),
                                    ]
                                  ),),
                                ]
                              ))
                              // Row(
                              //   // mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget> [
                              //     SizedBox(height: 10),
                              //     Column(
                              //       // crossAxisAlignment: CrossAxisAlignment.end,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: <Widget> [
                              //         Text(
                              //           "${widget.coinListMap.data[widget.index].quote.uSD.price.toStringAsFixed(2)}",
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         Text("", style:TextStyle(color: Colors.grey, fontSize: 12)),
                              //       ]
                              //     ),
                              //   ]
                              // )
                            ] /// ### Card Tile Internal UI Ends Here ### ///
                          )
                        )
                      )
                    )
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
