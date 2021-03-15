
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/buttons/colourful_button.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:coinsnap/working_files/initial_category_data.dart';
import 'package:flutter/material.dart';
import 'package:search_widget/search_widget.dart';

class AddCoin extends StatefulWidget {
  const AddCoin({Key key}) : super(key: key);

  @override
  _AddCoinState createState() => _AddCoinState();
}

class _AddCoinState extends State<AddCoin> {
  List coinList = InitialCategoryData.defiCategoryData;
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
            Flexible(
              flex: 12,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(displayWidth(context) * 0.05,0,displayWidth(context) * 0.05,0),
                child: Container(
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

                        /// ### Dropdown menu starts here ### ///
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            children: <Widget> [
                              if (_show)
                                SearchWidget(
                                  dataList: coinList,
                                  hideSearchBoxWhenItemSelected: true,
                                  listContainerHeight: displayHeight(context) * 0.25,
                                  queryBuilder: (query, list) {
                                    return list
                                      .where((item) => item /// ### I think this is returning all matches as user searches
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                      .toList();
                                  },
                                  popupListItemBuilder: (item) {
                                    return PopupListItemWidget(item);
                                  },
                                  selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                                    return SelectedItemWidget(selectedItem, deleteSelectedItem);
                                  },
                                  noItemsFoundWidget: NoItemsFound(),
                                  textFieldBuilder: (controller, focusNode) {
                                    return MyTextField(controller, focusNode);
                                  },
                                  onItemSelected: (item) {
                                    setState(() {
                                      _selectedItem = item;
                                    });
                                  },
                                )
                            ]
                          )
                        ),
                        /// ### Dropdown menu ends here ### ///
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("-", style: TextStyle(color: Colors.blueGrey))
                          )
                        ),
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
                                    Text("-", style: TextStyle(color: Colors.blueGrey)),
                                    Text("Market Cap", style: TextStyle(color: Colors.blueGrey))
                                  ]
                                )
                              ),
                              Flexible( /// Market dominance box
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Column(
                                  children: <Widget> [
                                    Text("-", style: TextStyle(color: Colors.blueGrey)),
                                    Text("Market Dominance", style: TextStyle(color: Colors.blueGrey))
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
                                    Text("-", style: TextStyle(color: Colors.blueGrey)),
                                    Text("24h Price Change", style: TextStyle(color: Colors.blueGrey))
                                  ]
                                )
                              ),
                              Flexible( /// Market dominance box
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Column(
                                  children: <Widget> [
                                    Text("-", style: TextStyle(color: Colors.blueGrey)),
                                    Text("Min. Trade Step Size", style: TextStyle(color: Colors.blueGrey))
                                  ]
                                )
                              ),
                            ]
                          )
                        ),

/// ### The plan ### ///
/// 
/// Overview:
/// 
/// When the user searches a coin,
/// The app should get all the data for the coin as well
/// And populate the fields instantly
/// So for example:
/// User selects Bitcoin
/// Then everything populates with Bitcoin's price etc.
/// 
/// How TF
/// 
/// State: BlocBuilder
/// Data exists somewhere(maybe)
/// 
/// App can grab and store top 100 coins worth of info
/// 
/// These 100 coins can be shown instantly
/// 
/// Any other coin has to be searched for individually??????????
/// Use Coingecko as data source..........
/// 
/// seems like a lot of bloody work for 1 small page


                        InkWell(
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
                            // Navigator.pushNamed(context, '/hometest'),
                            // dbPortfolioPostTest.dbPortfolioPostTest(),
                          },
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
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final String selectedItem;
  final VoidCallback deleteSelectedItem;

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
            onPressed: deleteSelectedItem,
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
      decoration: BoxDecoration(color: Colors.blueGrey),
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurpleAccent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Search here...", hintStyle: TextStyle(color: Colors.orange, fontSize: 14),
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