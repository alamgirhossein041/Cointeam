import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/helper_widgets/numbers.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';

class NewCardListTile extends StatelessWidget {
  const NewCardListTile({Key key, this.coinListData, this.coinBalancesMap, this.totalValue, this.index}) : super(key: key);

  final coinListData;
  final coinBalancesMap;
  final double totalValue;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/coinpage', arguments: {'coinListData': coinListData.data[index], 'index' :index, 'coinBalancesMap': coinBalancesMap[coinListData.data[index].symbol], 'totalValue': totalValue});
        },
        child: Container(
          height: displayHeight(context) * 0.11,
          decoration: BoxDecoration(
            color: Color(0x1FCBC1FF),
            border: Border(bottom: BorderSide(color: Colors.black))
          ),
          child: Row(
            children: <Widget> [
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget> [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Icon(CryptoFontIcons.BTC, color: Colors.orange),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      // child: Text(coinListData.data[index].symbol),
                      child: Align(
                        alignment: Alignment.topCenter,
                          child: Text((((coinBalancesMap[coinListData.data[index].symbol] * coinListData.data[index].quote.uSD.price) / totalValue) * 100).toStringAsFixed(1) + "%",
                          style: TextStyle(color: Color(0x73EEEEEE))),
                      /// we need to calculate coinListData.data[index].
                      /// coinListData.data[index].symbol
                      ),
                    ),
                  ]
                )
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    children: <Widget> [
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(coinListData.data[index].name,
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(coinListData.data[index].quote.uSD.percentChange24h.toStringAsFixed(2) + "%",
                              style: TextStyle(color: coinListData.data[index].quote.uSD.colorChange)),
                          ),
                        ),
                      )
                    ]
                  ),
                )
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget> [
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(numberFormatter(coinListData.data[index].quote.uSD.marketCap),
                            style: TextStyle(color: Color(0x73EEEEEE))),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget> [
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,0,15,5),
                          child: Text("\$" + (coinBalancesMap[coinListData.data[index].symbol] * coinListData.data[index].quote.uSD.price).toStringAsFixed(2),
                          style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,10,15,0),
                          // child: Text((coinBalancesMap[coinListData.data[index].symbol]).toStringAsFixed(8),
                          child: Text(balanceFormatter(coinBalancesMap[coinListData.data[index].symbol]),
                          style: TextStyle(color: Color(0x73EEEEEE), fontSize: 12)),
                        ),
                      ),
                    )
                  ]
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        //   child: Row(
        //     children: <Widget> [
        //       Container(
        //         decoration: BoxDecoration(
        //           color: appBlack, /// ### TODO: Change to Hana's UI Colour ### ///
        //         ),
        //         child: GestureDetector(
        //           onTap: () {
        //             // Navigator.pushNamed(context, '/coinpage', arguments: {'cryptoData' : widget.coinListMap, 'index' : widget.index, 'portfolioValue' : widget.portfolioValue});
        //           },
        //           child: Container(
        //             padding: EdgeInsets.fromLTRB(25,2,25,2),
        //             height: displayHeight(context) * 0.11,
        //             width: displayWidth(context),
        //             child: Card(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(20)),
        //               ),
        //               child: Container(
        //                 // padding: EdgetInsets.fromLTRB()
        //                 decoration: BoxDecoration(
        //                   gradient: LinearGradient(
        //                     begin: Alignment(-1.2, 0),
        //                     end: Alignment(1, 0),
        //                     colors: [Color(0xFF282136), Color(0xFF0F1D2D)],
        //                     // colors: [darkRedColor, lightRedColor]
        //                   ),
        //                 ),
        //                 child: Padding(
        //                   padding: EdgeInsets.fromLTRB(30,0,0,0),
        //                   child: Row(
        //                     children: <Widget> [ /// ### Card Tile Internal UI Starts Here ### ///
        //                       Align(
        //                         alignment: Alignment.centerLeft,
        //                         child: Icon(
        //                           CryptoFontIcons.BTC,
        //                           color: Colors.orange,
        //                         ),
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         children: <Widget> [
        //                           SizedBox(width: 10),
        //                           Column(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             children: <Widget> [
        //                               Text(
        //                                 "${widget.coinListMap[widget.index].name}",
        //                                 style: TextStyle(
        //                                   color: Colors.white,
        //                                   fontSize: 14,
        //                                 ),
        //                               ),
        //                               Text("CryptoExchange Name", style:TextStyle(color: Colors.grey, fontSize: 12)),
        //                             ]
        //                           )
        //                         ]
        //                       ),
        //                       Expanded(
        //                         child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: <Widget> [
        //                           SizedBox(height: 10),
        //                           Container(
        //                             padding: EdgeInsets.fromLTRB(0,0,30,0),
        //                             child: 
        //                           Column(
        //                             crossAxisAlignment: CrossAxisAlignment.end,
        //                             mainAxisAlignment: MainAxisAlignment.center,
        //                             children: <Widget> [
        //                               Row(
        //                                 // mainAxisAlignment: MainAxisAlignment.end,
        //                                 children: <Widget> [
        //                                   SizedBox(height: 10),
        //                                   Column(
        //                                     // crossAxisAlignment: CrossAxisAlignment.end,
        //                                     mainAxisAlignment: MainAxisAlignment.center,
        //                                     children: <Widget> [
        //                                       Text(
        //                                         "\$${widget.coinListMap[widget.index].totalUsdValue.toStringAsFixed(2)}",
        //                                         style: TextStyle(
        //                                           color: Colors.white,
        //                                           fontSize: 16,
        //                                         ),
        //                                       ),
        //                                       // Text("", style:TextStyle(color: Colors.grey, fontSize: 12)),
        //                                     ]
        //                                   ),
        //                                 ],
        //                               ),
        //                               Text(
        //                                 "${(widget.coinListMap[widget.index].free + widget.coinListMap[widget.index].locked).toStringAsFixed(8)}",
        //                                 style: TextStyle(
        //                                   color: Colors.grey,
        //                                   fontSize: 12,
        //                                 ),
        //                               ),
        //                               // Text("", style:TextStyle(color: Colors.grey, fontSize: 12)),
        //                             ]
        //                           ),
        //                         ),
        //                         ]
        //                       )),
        //                     ] /// ### Card Tile Internal UI Ends Here ### ///
        //                   )
        //                 )
        //               )
        //             )
        //           )
        //         )
        //       )
        //     ]
        //   )
        ),
      ),
    );
  }
}