import 'package:flutter/material.dart';

import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_event.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/global_library.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/widgets/core_widgets/cards/card_list_container.dart';
import 'package:coinsnap/v2/ui/widgets/core_widgets/price_container/container_panel.dart';
import 'package:coinsnap/v2/ui/widgets/helper_widgets/loading_screen.dart';
import 'package:coinsnap/working_files/initial_category_data.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:coinsnap/v2/asset/icon_custom/icon_custom.dart' as CustomIcon;
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

class PriceContainer extends StatefulWidget {
  PriceContainer({Key key, this.context}) : super(key: key);
  final BuildContext context;

  @override
  _PriceContainerState createState() => _PriceContainerState();
}

class _PriceContainerState extends State<PriceContainer> {

  double _heightHideContainer;
  double _heightShowContainer;
  double _heightOffset;

  bool _showContainer = false;
  bool _panelVisibility = false;
  // Widget _widget = Container();
  
  @override
  void initState() { 
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _heightHideContainer = displayHeight(widget.context) * 0.2;
    _heightShowContainer = displayHeight(widget.context) * 0.4;
    _heightOffset = displayHeight(widget.context) * 0.065 ;
    BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
    // debugPrint("Here you go + " + widget.category.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        AnimatedContainer( /// ### This is the container ### ///
          duration: Duration(seconds: 2),
          height: _showContainer ? (_heightShowContainer + _heightOffset) : (_heightHideContainer + _heightOffset),
          padding: EdgeInsets.fromLTRB(30,0,30,0),
          child: Stack(
            children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.9, -1.3),
                    end: Alignment(1.25, 1.25),
                    colors: [
                      Color(0xFFC21EDB),
                      Color(0xFF0575FF),
                      Color(0xFF0AE6FF),
                    ], stops: [
                      0.0,
                      0.63,
                      1.0
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(2.75),
                  child: AnimatedContainer(
                    height: _showContainer ? _heightShowContainer : _heightHideContainer,
                    duration: Duration(seconds: 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.25, -1.15),
                        end: Alignment(0.85, 1.1),
                        colors: [
                          Color(0xFF240C37),
                          Color(0xFF061330),
                          // Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    /// ### This is where the inner container starts ### ///
                    // child: Center(
                    //   child: Text('Enter further widgets here', style: TextStyle(color: Colors.white)),
                    // ),
                    child: Column(
                      /// ### Start container columns here ### ///
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, displayHeight(context) * 0.025, 0, 0),
                          child: Center(
                            child: Container(
                              height: 31.43,
                              width: 36.23,
                              child: Column(
                                children: <Widget> [
                                  Expanded(
                                    child: Transform.rotate(
                                      angle: -5 * math.pi / 180,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Icon(CustomIcon.IconCustom.wallet_tilt, color: Colors.white, )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ),
                        BlocConsumer<GetTotalValueBloc, GetTotalValueState>(
                          listener: (context, state) {
                            if (state is GetTotalValueErrorState) {
                              debugPrint("error in GetTotalValueState in home_view.dart");
                            } else if (state is GetTotalValueResponseState) {
                              debugPrint("Is it working?");
                              BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.binanceGetAllModelList, binanceGetPricesMap: state.binanceGetPricesMap));
                            }
                          },
                          builder: (context, state) {
                            if (state is GetTotalValueInitialState) {
                              debugPrint("GetTotalValueInitialState");
                              return loadingTemplateWidget();
                            } else if (state is GetTotalValueLoadingState) {
                              debugPrint("GetTotalValueLoadingStatedoodoo");
                              return loadingTemplateWidget();
                            } else if (state is GetTotalValueResponseState) {
                              debugPrint("GetTotalValueResponseReceivedState");
                              return loadingTemplateWidget();
                            } else if (state is GetTotalValueLoadedState) {
                              debugPrint("GetTotalValueLoadedState");
                              return Column(
                                children: <Widget> [
                                  Row(
                        /// TODO: Alignment (padding?)
                                    children: <Widget> [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(displayWidth(context) * 0.3, 23, 0, 0),
                                        child: Row( /// ### Start Bitcoin total value line here ### ///
                                          children: <Widget> [
                                            Icon(CryptoFontIcons.BTC, color: Colors.white, size: 14),
                                            Text(state.totalValue.toStringAsFixed(8), style: TextStyle(fontSize: 14, color: Colors.white)),
                                          ],
                                        ), /// ### End Bitcoin total value line here ### ///
                                      )
                                    ],
                                  ),
                                  Text("\$" + (state.totalValue * state.btcSpecial).toStringAsFixed(2), style: TextStyle(fontSize: 28, color: Colors.white)),
                                ],
                              );
                              
                        
                            } else {
                              return Text("Placeholder in home_view.dart -> PriceContainer()");
                            }
                          }
                        ),
                        


                        /// ### Start Expanded Buttons Here ### ///
                        ContainerPanel(panelVisibility: _panelVisibility),

                        /// ### End Expanded Buttons Here ### ///

                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget> [
                              // Row(
                              //   children: <Widget> [ /// ### Start bottom right corner icons ### ///
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget> [
                                    Icon(Icons.pie_chart, color: Colors.white),
                                    Icon(Icons.stacked_line_chart, color: Colors.green),
                                  ]
                                )
                              )
                            ]
                          )
                        ),
                        /// ####### ///
                      ] /// ### End container columns here ### ///
                    )
                    /// ### This is where the inner container ends ### ///
                  ),
                ),
              ),
              // AnimatedContainer(
              //   duration: Duration(seconds: 2),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     // child: FractionalTranslation(
              //     //   translation: Offset(0, .5),
              //     child: FloatingActionButton(
              //       onPressed: () {
              //         setState(() {
              //           _showContainer = !_showContainer;
              //           // _height = displayHeight(context) * 0.40;
              //           // _heightContainer = displayHeight(context) * 0.512;
              //           // _widget = ContainerSlider();
              //         });
              //       },
              //       child: Icon(Icons.swap_horiz, size: 36),
              //       backgroundColor: Color(0xFF25365b),
              //     )
              //   ),
              // )
              AnimatedContainer(
                height: _showContainer ? (_heightShowContainer + _heightOffset) : (_heightHideContainer + _heightOffset),
                duration: Duration(seconds: 2),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showContainer = !_showContainer;
                        _panelVisibility = !_panelVisibility;
                      });
                    },
                    child: Icon(Icons.swap_horiz, size: 36),
                    backgroundColor: uniColor,
                  )
                ),
              ),
            ]
          )
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: <Widget> [
        //     IconButton(
        //       icon: Icon(Icons.hourglass_empty, color: Colors.white),
        //       onPressed: () {
        //         // BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.binanceGetAllModelList, binanceGetPricesMap: state.binanceGetPricesMap));
        //       }
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.hourglass_full, color: Colors.white),
        //       onPressed: () {}
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.alarm, color: Colors.white),
        //       onPressed: () {}
        //     ),
        //   ],
        // ),
        ListContainer(showContainer: _showContainer),
      ]
    );
  }
}



class PriceContainerWithCategory extends StatefulWidget {
  PriceContainerWithCategory({Key key, this.context, this.category, this.coinList}) : super(key: key);
  final BuildContext context;
  final Categories category;
  final coinList;

  @override
  _PriceContainerStateWithCategory createState() => _PriceContainerStateWithCategory();
}

class _PriceContainerStateWithCategory extends State<PriceContainerWithCategory> {

  double _heightHideContainer;
  double _heightShowContainer;
  double _heightOffset;

  bool _showContainer = false;
  bool _panelVisibility = false;
  // Widget _widget = Container();
  
  @override
  void initState() { 
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _heightHideContainer = displayHeight(widget.context) * 0.2;
    _heightShowContainer = displayHeight(widget.context) * 0.4;
    _heightOffset = displayHeight(widget.context) * 0.065 ;
    // debugPrint(widget.coinList.toString());
    if(widget.category == globals.Categories.top100) {
      // debugPrint(widget.coinList.toString());
      BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: widget.coinList));
    } else if(widget.category == globals.Categories.defi) {
      BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.defiCategoryData));
    } else if(widget.category == globals.Categories.cexdex) {
      BlocProvider.of<ListTotalValueBloc>(context).add(FetchListTotalValueEvent(coinList: InitialCategoryData.cexDexCategoryData));
    }
    debugPrint("Here you go + " + widget.category.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        AnimatedContainer( /// ### This is the container ### ///
          duration: Duration(seconds: 2),
          height: _showContainer ? (_heightShowContainer + _heightOffset) : (_heightHideContainer + _heightOffset),
          padding: EdgeInsets.fromLTRB(30,30,30,0),
          child: Stack(
            children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.9, -1.3),
                    end: Alignment(1.25, 1.25),
                    colors: [
                      Color(0xFFC21EDB),
                      Color(0xFF0575FF),
                      Color(0xFF0AE6FF),
                    ], stops: [
                      0.0,
                      0.63,
                      1.0
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(2.75),
                  child: AnimatedContainer(
                    height: _showContainer ? _heightShowContainer : _heightHideContainer,
                    duration: Duration(seconds: 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.25, -1.15),
                        end: Alignment(0.85, 1.1),
                        colors: [
                          Color(0xFF240C37),
                          Color(0xFF061330),
                          // Colors.white,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    /// ### This is where the inner container starts ### ///
                    // child: Center(
                    //   child: Text('Enter further widgets here', style: TextStyle(color: Colors.white)),
                    // ),
                    child: Column(
                      /// ### Start container columns here ### ///
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, displayHeight(context) * 0.025, 0, 0),
                          child: Center(
                            child: Container(
                              height: 31.43,
                              width: 36.23,
                              child: Column(
                                children: <Widget> [
                                  Expanded(
                                    child: Transform.rotate(
                                      angle: -5 * math.pi / 180,
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: Icon(CustomIcon.IconCustom.wallet_tilt, color: Colors.white)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        BlocConsumer<ListTotalValueBloc, ListTotalValueState>(
                          listener: (context, state) {
                            if (state is ListTotalValueErrorState) {
                              debugPrint("error in ListTotalValueState in price_container(withcategory).dart");
                            } else if (state is ListTotalValueResponseState) {
                              debugPrint("Is it working?");
                              // BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.binanceGetAllModelList, binanceGetPricesMap: state.binanceGetPricesMap));
                            }
                          },
                          builder: (context, state) {
                            if (state is ListTotalValueInitialState) {
                              debugPrint("ListTotalValueInitialState");
                              return loadingTemplateWidget();
                            } else if (state is ListTotalValueLoadingState) {
                              debugPrint("ListTotalValueLoadingStatedoodoo");
                              return loadingTemplateWidget();
                            } else if (state is ListTotalValueResponseState) {
                              debugPrint("ListTotalValueResponseReceivedState");
                              return loadingTemplateWidget();
                            } else if (state is ListTotalValueLoadedState) {
                              debugPrint("ListTotalValueLoadedState");
                              return Column(
                                children: <Widget> [
                                  Row(
                            /// TODO: Alignment (padding?)
                                    children: <Widget> [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(displayWidth(context) * 0.3, 23, 0, 0),
                                        child: Row( /// ### Start Bitcoin total value line here ### ///
                                          children: <Widget> [
                                            Icon(CryptoFontIcons.BTC, color: Colors.white, size: 14),
                                            // Text(state.totalValue.toStringAsFixed(8), style: TextStyle(fontSize: 14, color: Colors.white)),
                                          ],
                                        ), /// ### End Bitcoin total value line here ### ///
                                      )
                                    ],
                                  ),
                                  // Text("\$" + (state.totalValue * state.btcSpecial).toStringAsFixed(2), style: TextStyle(fontSize: 28, color: Colors.white)),
                                ],
                              );
                              
                        
                            } else {
                              return Text("Placeholder in home_view.dart -> PriceContainer()");
                            }
                          }
                        ),
                        ContainerPanel(panelVisibility: _panelVisibility),
                        /// ### End Expanded Buttons Here ### ///
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget> [
                              // Row(
                              //   children: <Widget> [ /// ### Start bottom right corner icons ### ///
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget> [
                                    Icon(Icons.pie_chart, color: Colors.white),
                                    Icon(Icons.stacked_line_chart, color: Colors.green),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        /// ####### ///
                      ], /// ### End container columns here ### ///
                    ),
                    /// ### This is where the inner container ends ### ///
                  ),
                ),
              ),
              AnimatedContainer(
                height: _showContainer ? (_heightShowContainer + _heightOffset) : (_heightHideContainer + _heightOffset),
                duration: Duration(seconds: 2),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showContainer = !_showContainer;
                        _panelVisibility = !_panelVisibility;
                      });
                    },
                    child: Icon(Icons.swap_horiz, size: 36),
                    backgroundColor: uniColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListContainerWithContainer(showContainer: _showContainer),
      ],
    );
  }
}