
import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_state.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/helper_widgets/numbers.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:coinsnap/working_files/initial_category_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:search_widget/search_widget.dart';

class AddCoin extends StatefulWidget {
  const AddCoin({Key key}) : super(key: key);

  @override
  _AddCoinState createState() => _AddCoinState();
}

class _AddCoinState extends State<AddCoin> {
  // List coinList = InitialCategoryData.defiCategoryData;
  var _selectedItem;

  bool _show = true;
  
  TextEditingController _coinField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
        height: displayHeight(context),
        decoration: BoxDecoration(color: Color(0xFF101010)),
        child: Column(
          children: <Widget> [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: TopMenuRowBackButton(text: "Add Coin"),
              ),
            ),

            /// ### Bloc starts here? ### ///
            Flexible(
              flex: 12,
              fit: FlexFit.tight,
              child: BlocConsumer<CoingeckoList250Bloc, CoingeckoList250State>(
                listener: (context, state) {
                  if (state is CoingeckoList250ErrorState) {
                    log("Error in coin_add.dart -> AddCoin(), CoingeckoList250 Bloc");
                    return errorTemplateWidget("Error");
                  }
                },
                builder: (context, state) {
                  if (state is CoingeckoList250InitialState) {
                    log("CoingeckoList250InitialState");
                    return loadingTemplateWidget();
                  } else if (state is CoingeckoList250LoadingState) {
                    log("CoingeckoList250LoadingState");
                    return loadingTemplateWidget();
                  } else if (state is CoingeckoList250LoadedState) {  
                    log("CoingeckoList250LoadedState");
                    return AddCoinWidget(show: _show, coinList: state.coingeckoModelList, coinMap: state.coingeckoMap, callBackFunction: _callBackSetState);
                  } else if (state is CoingeckoList250ErrorState) {
                    log("CoingeckoListErrorState" + state.errorMessage);
                    return Container();
                  } else {
                    log("CoingeckoList???State");
                    return Container();
                  }
                }
              ),
            ),
            
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(),
            )
          // SizedBox(height: displayHeight(context) * 0.05),
          // TopMenuRowBackButton(),
          // Container(
          //   height: displayHeight(context) * 0.7,
          //   width: displayWidth(context) * 0.8,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [
          //         Color(0xFFFF8C00),
          //         Color(0xFF874800),
          //       ],
          //     ),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: Padding(
          //     padding:  EdgeInsets.all(2.75),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Color(0xFF1A1B20),
          //         borderRadius: BorderRadius.circular(5),
          //       ),
          //       child: Column(
          //         children: <Widget> [
          //           SizedBox(height: displayHeight(context) * 0.06),
          //           Text("Placeholder for dropdown menu autocomplete", style: TextStyle(color: Colors.white, fontSize: 24)),
          //           SizedBox(height: displayHeight(context) * 0.03),
          //           Text("Placeholder for coin's price", style: TextStyle(color: Colors.white, fontSize: 16)),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget> [
          //               Column(
          //                 children: <Widget> [
          //                   Text("Placeholder MCap", style: TextStyle(color: Colors.white, fontSize: 16)),
          //                   Text("Market cap", style: TextStyle(color: Colors.white, fontSize: 16))
          //                 ],
          //               ),
          //               Column(
          //                 children: <Widget> [
          //                   Text("00%", style: TextStyle(color: Colors.white, fontSize: 16)),
          //                   Text("Market Dominance", style: TextStyle(color: Colors.white, fontSize: 16)),
          //                 ],
          //               ),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget> [
          //               Column(
          //                 children: <Widget> [
          //                   Text("\$2222.22", style: TextStyle(color: Colors.white, fontSize: 16)),
          //                   Text("24h Price Change", style: TextStyle(color: Colors.white, fontSize: 16)),
          //                 ],
          //               ),
          //               Column(
          //                 children: <Widget> [
          //                   Text("0.0", style: TextStyle(color: Colors.white, fontSize: 16)),
          //                   Text("Min. Trade Step Size", style: TextStyle(color: Colors.white, fontSize: 16)),
          //                 ]
          //               )
          //             ]
          //           ),
          //           ColourfulButton(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),),)
    );
  }
  void _callBackSetState(var item) {
    setState(() {
      log("Coin Add (setState Callback)");
      _selectedItem = item;
    });
  }
  // void _callBackSetFields(String ticker) {
  //   setState(() {
  //     /// set the item fields to be mapped to coin
  //   });
  // }
}

class AddCoinWidget extends StatefulWidget {
  const AddCoinWidget({Key key, this.show, this.coinList, this.coinMap, this.callBackFunction}) : super(key: key);
  final bool show;
  final List<CoingeckoList250Model> coinList;
  final Map<String, dynamic> coinMap;
  final Function callBackFunction;

  @override
  AddCoinWidgetState createState() => AddCoinWidgetState();
}

class AddCoinWidgetState extends State<AddCoinWidget> {

  String selectedItemSymbol;
  bool isSelected = false;
  TextEditingController _quantity = TextEditingController();

  var localStorageResponse;

  // List<PrimeMap> primeMap;
  Map<String, dynamic> primeMap;

  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: boxDeco(),
        child: Padding(
          padding: EdgeInsets.only(top:2.75, bottom: 2.75),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1A1B20),
            ),
            child: Column(
              children: <Widget> [

                /// ### Dropdown menu starts here ### ///
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Column(
                    children: <Widget> [
                      if (widget.show)
                        SearchWidget(
                          dataList: widget.coinList,
                          hideSearchBoxWhenItemSelected: true,
                          listContainerHeight: displayHeight(context) * 0.25,
                          queryBuilder: (query, list) {
                            return list
                              .where((item) => item.symbol /// ### I think this is returning all matches as user searches
                                .toUpperCase()
                                .contains(query.toUpperCase()))
                              .toList();
                          },
                          popupListItemBuilder: (item) {
                            return PopupListItemWidget(item.symbol);
                          },
                          selectedItemBuilder: (item, deleteSelectedItem) {
                            
                            // setState(() {
                            //   selectedItemSymbol = item.symbol;
                            //   isSelected = true;
                            // });
                            return SelectedItemWidget(item.name, _callBackDeleteSelected, deleteSelectedItem);
                          },
                          noItemsFoundWidget: NoItemsFound(),
                          textFieldBuilder: (controller, focusNode) {
                            return MyTextField(controller, focusNode);
                          },
                          onItemSelected: (item) {
                            /// ### VoidCallback parent widget setState??? ### ///
                            setState(() {
                              selectedItemSymbol = item.symbol;
                              isSelected = true;
                              var localQuantity = localStorage.getItem(item.symbol);
                              if (localQuantity != null) {
                                log("localQuantity is " + localQuantity.toString());
                                _quantity = localQuantity;
                              }
                            });
                            widget.callBackFunction(item);
                          },
                        )
                    ]
                  )
                ),
                /// ### Dropdown menu ends here ### ///
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget> [
                      Flexible( /// Market cap box
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget> [
                            Text("Current Price", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300)),
                            Builder(
                              builder: (context) {
                                if(isSelected == false) {
                                  return Text("-", style: TextStyle(color: Colors.white));
                                } else {
                                  // log(widget.coinMap.toString());
                                  // log(widget.coinMap[selectedItemSymbol].toString());
                                  return Text("\$" + widget.coinMap[selectedItemSymbol].currentPrice.toStringAsFixed(2), style: TextStyle(color: Colors.white));
                                }
                              }
                            ),
                          ]
                        )
                      ),
                      Flexible( /// Market dominance box
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget> [
                            Text("Quantity: ", style: TextStyle(color: Colors.grey)),
                            Builder(
                              builder: (context) {
                                if(isSelected == false) {
                                  return Text("-", style: TextStyle(color: Colors.white));
                                } else {
                                  // log(widget.coinMap.toString());
                                  // log(widget.coinMap[selectedItemSymbol].toString());
                                  return Container(
                                    width: 50,
                                    height: 35,
                                    child: TextField(
                                      controller: _quantity,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(      
                                          borderSide: BorderSide(color: Colors.blue[200]),   
                                        ),
                                      ),
                                      // border: OutlineInputBorder(
                                      //   borderSide: BorderSide(width: 1, color: Colors.white),
                                      // ),
                                    //   enabledBorder: OutlineInputBorder(
                                    //     borderSide: BorderSide(width: 1, color: Colors.deepPurpleAccent),
                                    //   ),
                                    // //   // focusedBorder: OutlineInputBorder(
                                    //   //   borderSide: BorderSide(width: 3, color: Colors.deepPurpleAccent),
                                    //   // ),
                                    //   // labelStyle: TextStyle(color: Colors.white),
                                    //   // labelText: 'Secret API key',
                                    //   // helperText: "(We only need the Secret API Key)",
                                    //   // helperStyle: TextStyle(color: Colors.white),
                                    // ),
                                    style: TextStyle(color: Colors.white)
                                    ),
                                  );
                                }
                              }
                            ),
                          ]
                        )
                      )
                    ]
                  ),
                ),
                  
                //   Align(
                //     alignment: Alignment.center,
                //     child: Column(
                //       children: <Widget> [
                //         Text("Current Price:", style: TextStyle(color: Colors.grey)),
                //         Builder(
                //           builder: (context) {
                //             if(isSelected == false) {
                //               return Text("-", style: TextStyle(color: Colors.white));
                //             } else {
                //               // log(widget.coinMap.toString());
                //               // log(widget.coinMap[selectedItemSymbol].toString());
                //               return Text("\$" + widget.coinMap[selectedItemSymbol].currentPrice.toStringAsFixed(2), style: TextStyle(color: Colors.white));
                //             }
                //           }
                //         )
                //       ]
                //     )
                //   )
                // ),
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget> [
                      Flexible( /// Market cap box
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget> [
                            Text("Market Cap", style: TextStyle(color: Colors.grey)),
                            Builder(
                              builder: (context) {
                                if(isSelected == false) {
                                  return Text("-", style: TextStyle(color: Colors.white));
                                } else {
                                  // log(widget.coinMap.toString());
                                  // log(widget.coinMap[selectedItemSymbol].toString());
                                  return Text(numberFormatter(widget.coinMap[selectedItemSymbol].marketCap), style: TextStyle(color: Colors.white));
                                }
                              }
                            ),
                          ]
                        )
                      ),
                      Flexible( /// Market dominance box
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget> [
                            Text("All Time High", style: TextStyle(color: Colors.grey)),
                            Builder(
                              builder: (context) {
                                if(isSelected == false) {
                                  return Text("-", style: TextStyle(color: Colors.white));
                                } else {
                                  // log(widget.coinMap.toString());
                                  // log(widget.coinMap[selectedItemSymbol].toString());
                                  return Text("\$" + widget.coinMap[selectedItemSymbol].ath.toString(), style: TextStyle(color: Colors.white));
                                }
                              }
                            ),
                          ]
                        )
                      )
                    ]
                  )
                ),
                  // child: Text("HEllo WOrld!", style: TextStyle(color: Colors.white))),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget> [
                      Flexible( /// Market cap box
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget> [
                            Text("24h Price Change", style: TextStyle(color: Colors.grey)),
                            Builder(
                              builder: (context) {
                                if(isSelected == false) {
                                  return Text("-", style: TextStyle(color: Colors.white));
                                } else {
                                  // log(widget.coinMap.toString());
                                  // log(widget.coinMap[selectedItemSymbol].toString());
                                  return Text("\$" + widget.coinMap[selectedItemSymbol].priceChange24h.toStringAsFixed(2) + " (" +
                                    widget.coinMap[selectedItemSymbol].priceChangePercentage24h.toStringAsFixed(1) + "%)", style: TextStyle(color: Colors.white));
                                }
                              }
                            ),
                          ]
                        )
                      ),
                      Flexible( /// Market dominance box
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget> [
                            Text("Current Supply", style: TextStyle(color: Colors.grey)),
                            Builder(
                              builder: (context) {
                                if(isSelected == false) {
                                  return Text("-", style: TextStyle(color: Colors.white));
                                } else {
                                  // log(widget.coinMap.toString());
                                  // log(widget.coinMap[selectedItemSymbol].toString());
                                  // return Text(widget.coinMap[selectedItemSymbol].circulatingSupply.toString() + " / " + widget.coinMap[selectedItemSymbol].totalSupply.toString(), style: TextStyle(color: Colors.grey));
                                  return Text(widget.coinMap[selectedItemSymbol].circulatingSupply.toStringAsFixed(0), style: TextStyle(color: Colors.white));
                                }
                              }
                            ),
                          ]
                        )
                      ),
                    ]
                  )
                ),
                BlocBuilder<GetCoinListBloc, GetCoinListState>(
                  builder: (context, state) {
                    if (state is GetCoinListLoadedState) {
                      return FutureBuilder(
                        future: localStorage.ready,
                        builder: (context, snapshot) {
                          if (snapshot.data == true) {
                            
                            // var primeCoin = localStorage.getItem("prime");
                            return InkWell(
                              child: Container(
                                height: displayHeight(context) * 0.065,
                                width: displayWidth(context) * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.9, -1.3),
                                    end: Alignment(1.25, 1.25),
                                    colors: [Color(0xFF8300FF), Color(0xFF006BFF)]
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("ADD TO PORTFOLIO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                                ),
                              ),
                              onTap: () => {
                                // primeCoinList.add({selectedItemSymbol: double.parse(_quantity.text)}),
                                // Navigator.pushNamed(context, '/hometest'),
                                // dbPortfolioPostTest.dbPortfolioPostTest(),
                                /// 20th
                                localStorageResponse = localStorage.getItem("prime"),
                                if(localStorageResponse != null) {
                                  primeMap = json.decode(localStorage.getItem("prime")),
                                },
                                if(primeMap != null) {
                                  if(primeMap[selectedItemSymbol] != null) {
                                    primeMap[selectedItemSymbol] += double.parse(_quantity.text),
                                  } else {
                                    // primeMap = {},
                                    primeMap[selectedItemSymbol] = double.parse(_quantity.text),
                                  }
                                 /// 19th
                                  // primeMap.add(PrimeMap(symbol: selectedItemSymbol, quantity: double.parse(_quantity.text))),
                                } else {
                                  primeMap = {},
                                  primeMap[selectedItemSymbol] = double.parse(_quantity.text),
                                  // primeMap.add(PrimeMap(symbol: selectedItemSymbol, quantity: double.parse(_quantity.text))),
                                },
                                log("Is this where it's going wrong"),
                                localStorage.setItem("prime", jsonEncode(primeMap)),
                                log(localStorage.getItem("prime").toString()),
                                /// primeMap = PrimeMap(symbol: selectedItemSymbol, quantity: double.parse(_quantity.text)),
                                /// localStorage.setItem("prime", primeMap.toJson()),
                                /// 19th
                              },
                            );
                          } else {
                            return loadingTemplateWidget();
                          }
                        }
                      );
                    } else {
                      return InkWell(
                        child: Container(
                          height: displayHeight(context) * 0.065,
                          width: displayWidth(context) * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.grey,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("ADD TO PORTFOLIO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                          ),
                        ),
                        onTap: () => {
                          // Navigator.pushNamed(context, '/hometest'),
                          // dbPortfolioPostTest.dbPortfolioPostTest(),
                          log("Greyed out Add To Portfolio button pressed in coin_add.dart"),
                        },
                      );
                    }
                  }
                ),
                SizedBox(height: displayHeight(context) * 0.075)
              ]
            )
              //   Text("Placeholder for dropdown menu autocomplete", style: TextStyle(color: Colors.white, fontSize: 12)),
              //   Text("Placeholder for coin's price", style: TextStyle(color: Colors.white, fontSize: 16)),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget> [
              //       Column(
              //         children: <Widget> [
              //           Text("Placeholder MCap", style: TextStyle(color: Colors.white, fontSize: 16)),
              //           Text("Market cap", style: TextStyle(color: Colors.white, fontSize: 16))
              //         ],
              //       ),
              //       Column(
              //         children: <Widget> [
              //           Text("00%", style: TextStyle(color: Colors.white, fontSize: 16)),
              //           Text("Market Dominance", style: TextStyle(color: Colors.white, fontSize: 16)),
              //         ],
              //       ),
              //     ],
              //   ),
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget> [
              //       Column(
              //         children: <Widget> [
              //           Text("\$2222.22", style: TextStyle(color: Colors.white, fontSize: 16)),
              //           Text("24h Price Change", style: TextStyle(color: Colors.white, fontSize: 16)),
              //         ],
              //       ),
              //       Column(
              //         children: <Widget> [
              //           Text("0.0", style: TextStyle(color: Colors.white, fontSize: 16)),
              //           Container(
              //             height: 100,
              //             width: 100,
              //           child: TextField(
              //             obscureText: true,
              //             controller: _coinField,
              //             decoration: InputDecoration(
              //               labelText: 'Add Coin',
              //               labelStyle: TextStyle(color: Colors.white),
              //               floatingLabelBehavior: FloatingLabelBehavior.always,
              //               filled: true,
              //               fillColor: Color(0xFF126FFF),
              //               enabledBorder: UnderlineInputBorder(      
              //                 borderSide: BorderSide(color: Colors.white),   
              //               ),  
              //             ),
              //           ),
              //           ),
              //         ]
              //       )
              //     ]
              //   ),
              //   ColourfulButton(),
            
          ),
        ),
      ),
    );
  }
  void _callBackDeleteSelected() {
    setState(() {
      isSelected = false;
    });
  }

  boxDeco() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFF8C00),
          Color(0xFF874800),
        ],
      ),
    );
  }

}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem, this.callBackDeletedSelected);

  final String selectedItem;
  final VoidCallback deleteSelectedItem;
  final Function callBackDeletedSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF101010)),
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedItem,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: Colors.grey[700],
            onPressed: () {
              deleteSelectedItem();
              callBackDeletedSelected();
            },
          ),
        ],
      ),
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).popupMenuTheme.color),
      padding: const EdgeInsets.all(12),
      child: Text(
        item,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)
          ),
          suffixIcon: Icon(Icons.search, color: Colors.white),
          border: InputBorder.none,
          hintText: "Search here...", hintStyle: TextStyle(color: Colors.white, fontSize: 14),
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.folder_open,
          size: 24,
          color: Colors.grey[900].withOpacity(0.7),
        ),
        const SizedBox(width: 10),
        Text(
          "No Items Found",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}