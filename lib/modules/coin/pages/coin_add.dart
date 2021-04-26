
import 'dart:convert';
import 'package:coinsnap/modules/app_load/bloc/coingecko_list_250_bloc/coingecko_list_250_bloc.dart';
import 'package:coinsnap/modules/app_load/bloc/coingecko_list_250_bloc/coingecko_list_250_state.dart';
import 'package:coinsnap/modules/app_load/models/coingecko_list_250.dart';
import 'package:coinsnap/modules/portfolio/pages/portfolio_dashboard.dart';
import 'package:coinsnap/modules/utils/number_formatter.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/menu/drawer.dart';
import 'package:coinsnap/modules/widgets/menu/top_menu_row.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
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
  
  // TextEditingController _coinField = TextEditingController();

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
                    debugPrint("Error in coin_add.dart -> AddCoin(), CoingeckoList250 Bloc");
                    return errorTemplateWidget("Error");
                  }
                },
                builder: (context, state) {
                  if (state is CoingeckoList250InitialState) {
                    debugPrint("CoingeckoList250InitialState");
                    return loadingTemplateWidget();
                  } else if (state is CoingeckoList250LoadingState) {
                    debugPrint("CoingeckoList250LoadingState");
                    return loadingTemplateWidget();
                  } else if (state is CoingeckoList250LoadedState) {  
                    debugPrint("CoingeckoList250LoadedState");
                    return AddCoinWidget(show: _show, coinList: state.coingeckoModelList, coinMap: state.coingeckoMap, callBackFunction: _callBackSetState);
                  } else if (state is CoingeckoList250ErrorState) {
                    debugPrint("CoingeckoListErrorState" + state.errorMessage);
                    return Container();
                  } else {
                    debugPrint("CoingeckoList???State");
                    return Container();
                  }
                }
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(),
            )
          ],
        ),
      ),
      )
    );
  }
  void _callBackSetState(var item) {
    setState(() {
      debugPrint("Coin Add (setState Callback)");
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
  String selectedCoin = '';

  var localStorageResponse;

  // List<PrimeMap> primeMap;
  Map<String, dynamic> primeMap;

  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  @override
  Widget build(BuildContext context) {
    // final snackBar = SnackBar(content: Text('Yay! A SnackBar!' + _quantity.text + selectedCoin));

    // Flex row padding
    var rowPadding = EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 0);

    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: boxDeco(),
        child: Padding(
          // padding for width of gradient border
          padding: EdgeInsets.only(top:2.75, bottom: 2.75),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                    mainAxisAlignment: MainAxisAlignment.center,

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
                              selectedCoin = item.symbol;
                              selectedItemSymbol = item.symbol;
                              isSelected = true;
                              var localQuantity = localStorage.getItem(item.symbol);
                              if (localQuantity != null) {
                                debugPrint("localQuantity is " + localQuantity.toString());
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
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: rowPadding,
                      child: Row(
                      children: <Widget> [
                        Flexible( /// Market cap box
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text("Current Price", style: TextStyle(color: Colors.white38)),
                              Builder(
                                builder: (context) {
                                  if(isSelected == false) {
                                    return Text("-", style: TextStyle(color: Colors.white38));
                                  } else {
                                    // debugPrint(widget.coinMap.toString());
                                    // debugPrint(widget.coinMap[selectedItemSymbol].toString());
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                
                                Text("Quantity: ", style: TextStyle(color: Colors.white38)),
                                SizedBox(
                                  // flex: 1, 
                                  width: 110,
                                  height: 25,
                                  child: Builder(
                                    builder: (context) {
                                      if(isSelected == false) {
                                        return Text("-", style: TextStyle(color: Colors.white38));
                                      } else {
                                        // debugPrint(widget.coinMap.toString());
                                        // debugPrint(widget.coinMap[selectedItemSymbol].toString());
                                        return TextField(
                                          // keyboardType: TextInputType.number,
                                          cursorWidth: 2,
                                          cursorColor: Colors.white,
                                          controller: _quantity,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(      
                                              borderSide: BorderSide(color: Colors.white70),   
                                            ),
                                            focusedBorder: UnderlineInputBorder(      
                                              borderSide: BorderSide(color: Colors.white, width: 2),
                                            ),
                                          ),
                                        style: TextStyle(color: Colors.white)
                                        );
                                      }
                                    }
                                  ),
                                ),
                              ]
                            ),
                          )
                        )
                      ]
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: rowPadding,
                    child: Row(
                      children: <Widget> [
                        Flexible( /// Market cap box
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text("Market Cap", style: TextStyle(color: Colors.white38)),
                              Builder(
                                builder: (context) {
                                  if(isSelected == false) {
                                    return Text("-", style: TextStyle(color: Colors.white38));
                                  } else {
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Text("All Time High", style: TextStyle(color: Colors.white38)),
                                Builder(
                                  builder: (context) {
                                    if(isSelected == false) {
                                      return Text("-", style: TextStyle(color: Colors.white38));
                                    } else {
                                      return Text("\$" + widget.coinMap[selectedItemSymbol].ath.toString(), style: TextStyle(color: Colors.white));
                                    }
                                  }
                                ),
                              ]
                            ),
                          )
                        )
                      ]
                    ),
                  )
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: rowPadding,
                    child: Row(
                      children: <Widget> [
                        Flexible( /// Market cap box
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Text("24h Price Change", style: TextStyle(color: Colors.white38)),
                              Builder(
                                builder: (context) {
                                  if(isSelected == false) {
                                    return Text("-", style: TextStyle(color: Colors.white38));
                                  } else {
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
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Text("Current Supply", style: TextStyle(color: Colors.white38)),
                                Builder(
                                  builder: (context) {
                                    if(isSelected == false) {
                                      return Text("-", style: TextStyle(color: Colors.white38));
                                    } else {
                                      return Text(widget.coinMap[selectedItemSymbol].circulatingSupply.toStringAsFixed(0), style: TextStyle(color: Colors.white));
                                    }
                                  }
                                ),
                              ]
                            ),
                          )
                        ),
                      ]
                    ),  
                  )
                ),
                Flexible(
                  flex: 2,
                  child: BlocBuilder<CoingeckoList250Bloc, CoingeckoList250State>(
                    builder: (context, state) {
                      if (state is CoingeckoList250LoadedState) {
                        return FutureBuilder(
                          future: localStorage.ready,
                          builder: (context, snapshot) {
                            if (snapshot.data == true) {
                              return InkWell(
                                child: Center(
                                  child: Container(
                                    height: 52,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.9, -1.3),
                                        end: Alignment(1.25, 1.25),
                                        colors: [Color(0xFF8300FF), Color(0xFF006BFF)]
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("ADD TO PORTFOLIO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                    ),
                                  ),
                                ),
                                onTap: () => {
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
                                  localStorage.setItem("prime", jsonEncode(primeMap)),
                                  debugPrint(localStorage.getItem("prime").toString()),
                                  Navigator.pop(context, BoxedReturns(selectedCoin, _quantity.text)),

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
                          debugPrint("Greyed out Add To Portfolio button pressed in coin_add.dart"),
                        },
                      );
                    }
                  }
                  ),
                ),
              ]
            )
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
              padding: const EdgeInsets.all(18),
              child: Text(
                selectedItem,
                style: Theme.of(context).textTheme.headline1.copyWith(fontWeight: FontWeight.w300)
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
      padding: const EdgeInsets.all(16),
      child: Text(
        item,
        style: Theme.of(context).textTheme.bodyText2,
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
    return SizedBox(
      // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
      width: 300,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70, width: 1),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)
          ),
          suffixIcon: Icon(Icons.search, color: Colors.white),
          border: InputBorder.none,
          hintText: "Search coins", hintStyle: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white54, fontWeight: FontWeight.w300),
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