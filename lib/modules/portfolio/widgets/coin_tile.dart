import 'dart:convert';

import 'package:coinsnap/modules/utils/number_formatter.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class NewCardListTile extends StatefulWidget {
  const NewCardListTile({Key key, this.coinListData, this.coinBalancesMap, this.totalValue, this.index, this.portfolioMap}) : super(key: key);

  final coinListData;
  final coinBalancesMap;
  final double totalValue;
  final int index;
  final portfolioMap;

  @override
  NewCardListTileState createState() => NewCardListTileState();
}

class NewCardListTileState extends State<NewCardListTile> {

  // List<String> menuChoices = [
  //   'Edit',
  //   'Delete',
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/viewcoin', arguments: {'coinListData': widget.coinListData.data[widget.index], 'index' :widget.index, 'coinBalancesMap': widget.coinBalancesMap[widget.coinListData.data[widget.index].symbol], 'totalValue': widget.totalValue});
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
                          child: Text((((widget.portfolioMap[widget.coinListData.data[widget.index].symbol] * widget.coinListData.data[widget.index].quote.uSD.price) / widget.totalValue) * 100).toStringAsFixed(1) + "%",
                          style: TextStyle(color: Color(0x73EEEEEE), fontSize: 12)),
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
                            child: Text(widget.coinListData.data[widget.index].name,
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      /// swap this location 23rd
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            // child: Text(coinListData.data[index].quote.uSD.percentChange24h.toStringAsFixed(2) + "%"),
                            child: Text("\$" + widget.coinListData.data[widget.index].quote.uSD.price.toStringAsFixed(2),
                              style: TextStyle(color: widget.coinListData.data[widget.index].quote.uSD.colorChange, fontSize: 14)),
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
                    /// ### Here I think we just want the coin price???
                    /// 23rd
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(numberFormatter(widget.coinListData.data[widget.index].quote.uSD.marketCap),
                            style: TextStyle(color: Color(0x73EEEEEE), fontSize: 14)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(widget.coinListData.data[widget.index].quote.uSD.percentChange24h.toStringAsFixed(2) + "%",
                            style: TextStyle(color: widget.coinListData.data[widget.index].quote.uSD.colorChange, fontSize: 14)),
                        ),
                      ),
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
                          padding: EdgeInsets.fromLTRB(0,0,10,5),
                          // child: Text((coinBalancesMap[coinListData.data[index].symbol]).toStringAsFixed(8),
                          child: Text(balanceFormatter(widget.coinBalancesMap[widget.coinListData.data[widget.index].symbol]),
                          style: TextStyle(color: Color(0x73EEEEEE), fontSize: 14)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0,5,10,0),
                          child: Text("\$" + (widget.coinBalancesMap[widget.coinListData.data[widget.index].symbol] * widget.coinListData.data[widget.index].quote.uSD.price).toStringAsFixed(2),
                          style: TextStyle(color: widget.coinListData.data[widget.index].quote.uSD.colorChange, fontSize: 14)),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      _showPopupMenu(details.globalPosition, widget.coinListData.data[widget.index].symbol);
                    },
                    child: Icon(Icons.more_vert, color: Colors.white),
                  ),
                )
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
        //             // Navigator.pushNamed(context, '/viewcoin', arguments: {'cryptoData' : widget.coinListMap, 'index' : widget.index, 'portfolioValue' : widget.portfolioValue});
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

  void _showPopupMenu(Offset offset, String coin) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left,top,0,0),
      items: [
        /// Dev Todo: We don't really have an Edit screen yet
        /// KAN-80
        // PopupMenuItem<String>(
        //   value: 'Edit',
        //   child: TextButton(
        //     child: Text('Edit'),
        //     onPressed: () {debugPrint("We have liftoff - Edit pressed");},
        //     style: ButtonStyle(
        //       foregroundColor: MaterialStateProperty.resolveWith(
        //               (state) => Colors.black)
        //     ),
        //   )
        // ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: TextButton(
            child: Text('Delete', style: Theme.of(context).textTheme.bodyText1),
            onPressed: () async {
              /// Pseudocode: Get local storage
              /// Should return an object map
              /// https://api.dart.dev/stable/2.10.5/dart-core/Map/remove.html
              
              var localStorage = LocalStorage("coinstreetapp");
              // debugPrint(localStorage.toString());
              var localStorageResponse = json.decode(localStorage.getItem("prime"));
              // debugPrint("First, LocalStorage is" + localStorage.getItem("prime").toString());
              // debugPrint("Coin to remove is: " + coin);
              localStorageResponse.remove(coin);
              // debugPrint("LocalStorage is now: \n");
              // debugPrint(localStorage.getItem("prime").toString());
              localStorage.setItem("prime", jsonEncode(localStorageResponse));
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                      (state) => Colors.black)
            ),
          )
        ),
      ],
      elevation: 8.0,
    );
  }

  // void _callBackSetState() {
  //   setState(() {});
  // }

  // void _showPopupMenu(Offset offset) async {
  //   double left = offset.dx;
  //   double top = offset.dy;
  //   await showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(left,top,0,0),
  //     items: <PopupMenuEntry> [
        

        
  //     ],
  //     elevation: 8.0,
  //   );
  // }

  // _showPopupMenu(Offset offset) {
  //   // _doSomething () => {(debugPrint("We have liftoff"))};
  //   // double left = offset.dx;
  //   // double top = offset.dy;
  //   PopupMenuButton(
  //     // context: context,
  //     // position: RelativeRect.fromLTRB(left,top,0,0),
  //     offset: offset,
  //     itemBuilder: (_) => <PopupMenuItem<String>>[
  //       PopupMenuItem<String>(
  //         child: Text('Edit'), value: 'Edit',
  //       ),
  //       PopupMenuItem<String>(
  //         child: Text('Delete'), value: 'Delete',
  //       ),
  //     ],
  //     onSelected: (_) {debugPrint("We have liftoff");},
  //     elevation: 8.0,
  //   );
  // }

}