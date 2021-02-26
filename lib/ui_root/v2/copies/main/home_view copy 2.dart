import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_bloc.dart';
import 'package:coinsnap/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_event.dart';
import 'package:coinsnap/bloc/internal/coin_data/card/derivative/card_crypto_data_bloc.dart/card_crypto_data_state.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/data/model/internal/coin_data/card/derivative/card_crypto_data.dart';
import 'package:coinsnap/data/repository/internal/coin_data/card/coinmarketcap_coin_latest.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui_root/drawer/drawer.dart';
import 'package:coinsnap/ui_root/template/data/chart/overall/chart_cartesian.dart';
import 'package:coinsnap/ui_root/template/loading.dart';
import 'package:coinsnap/ui_root/v2/helper_widgets/loading_screen.dart';
import 'package:coinsnap/ui_root/v2/menu_drawer/top_menu_row.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:coinsnap/resource/icon_test/icon_test_icons.dart' as CustomIcon;

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  final firestoreInstance = FirebaseFirestore.instance;
  var firestoreUser = FirebaseFirestore.instance.collection('User');
  var firebaseAuth = FirebaseAuth.instance;



  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 65,
        child: BottomAppBar(
          
          child: Row(
            children: <Widget> [
              IconButton(icon: Icon(Icons.menu), onPressed: () {}),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ]
          ),
        ),
      ),
      key: scaffoldState,
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: FutureBuilder(
          future: readStorage(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
              if (!snapshot.hasError) {
                /// ("Return a welcome screen") ??? default comment
                return snapshot.data != null
                    ? DashboardWithApi()
                    // : DashboardWithoutApi();
                    : Text("Wallah");
              } else {
                return errorTemplateWidget(snapshot.error);
              }
            }
          },
        ),
      ),
    );
  }

  Future<String> readStorage() async {
    String value = await storage.read(key: "api");
    if (value == null) {
      return "none";
    } else { /// TODO; Check for api key validity using cryptography
      return value;
    }
  }


}

class DashboardWithApi extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: Column(
          children: <Widget> [
            SizedBox(height: displayHeight(context) * 0.05),
            /// ### Top Row starts here ### ///
            topMenuRow(context),
            RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                BlocProvider.of<CardCryptoDataBloc>(context).add(FetchCardCryptoDataEvent());
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: <Widget> [
                    PriceContainer(context: context,),
                  ],
                ),
              ),
              
            ),
          // create: (context) => FirestoreGetUserDataBloc(firestoreGetUserDataRepository: FirestoreGetUserDataRepositoryImpl())..add(FetchFirestoreGetUserDataEvent()),
            
          ],
        ),
      ),
    );
  }
}

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
    _heightOffset = displayHeight(widget.context) * 0.12;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        AnimatedContainer( /// ### This is the container ### ///
          duration: Duration(seconds: 2),
          height: _showContainer ? (_heightShowContainer + _heightOffset) : (_heightHideContainer + _heightOffset),
          padding: EdgeInsets.all(30),
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
                                        child: Icon(CustomIcon.IconTest.wallet_tilt, color: Colors.white, )
                                      ),
                                    ),
                                  ),
                                
                                ],
                              ),
                            ),
                          )
                        ),
                        Row(
                          /// TODO: Alignment (padding?)
                          children: <Widget> [
                            Container(
                              padding: EdgeInsets.fromLTRB(displayWidth(context) * 0.3, 10, 0, 0),
                              child: Row( /// ### Start Bitcoin total value line here ### ///
                                children: <Widget> [
                                  Icon(CryptoFontIcons.BTC, color: Colors.white),
                                  Text("0.01980000", style: TextStyle(fontSize: 12, color: Colors.white)),
                                ],
                              ), /// ### End Bitcoin total value line here ### ///
                            )
                          ],
                        ),
                        Text("\$49,162.71", style: TextStyle(fontSize: 28, color: Colors.white)),
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
                      });
                    },
                    child: Icon(Icons.swap_horiz, size: 36),
                    backgroundColor: Color(0xFF25365b),
                  )
                ),
              ),
            ]
          )
        ),
      ListContainer(showContainer: _showContainer),
      ]
    );
  }
}

class ListContainer extends StatefulWidget {
  ListContainer({Key key, this.showContainer}) : super(key: key);
  final bool showContainer;

  @override
  _ListContainerState createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {

  CardCryptoDataBloc cardCryptoDataBloc;

  double _heightHideContainer;
  double _heightShowContainer;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    cardCryptoDataBloc = BlocProvider.of<CardCryptoDataBloc>(context);
    cardCryptoDataBloc.add(FetchCardCryptoDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    _heightHideContainer = displayHeight(context) * 0.46;
    _heightShowContainer = displayHeight(context) * 0.23;
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      height: widget.showContainer ? _heightShowContainer : _heightHideContainer,
      child: BlocListener<CardCryptoDataBloc, CardCryptoDataState>(
        listener: (context, state) {
          if (state is CardCryptoDataErrorState) {
            log("error in CardCryptoDataErrorState in home_view_real.dart");
          }
        },
        child: BlocBuilder<CardCryptoDataBloc, CardCryptoDataState>( /// Both bloc types to be built (refactor existing controllers)
          builder: (context, state) {
            if (state is CardCryptoDataInitialState) {
              log("CardCryptoDataInitialState");
              return buildLoadingTemplate();
            } else if (state is CardCryptoDataLoadingState) {
              log("CardCryptoDataLoadingState");
              return buildLoadingTemplate();
            } else if (state is CardCryptoDataLoadedState) {
              log("CardCryptoDataLoadedState");
              return Container(
                // height: widget.showContainer ? displayHeight(context) * 0.4 : displayHeight(context) 0.2,
                // height: widget.showContainer ? (displayHeight(context) * 0.4) : (displayHeight(context) * 0.2),

                /// ### Commenting out customscrollview since the chart is no longer here         ### ///
                /// ### The issue is I can't seem to constrain? the height and dynamically adjust ### ///
                /// ### But I can with normal ListView.builder                                    ### ///
                
                child: CustomScrollView(
                  slivers: <Widget> [
                    SliverToBoxAdapter(
                      /// ### Chart section starts here ### ///
                      // child: SizedBox(
                      //   height: displayHeight(context) * 0.27,
                      //   child: ChartOverall(),
                      // ), /// ### Chart section ends here ### ///
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                          return CardListTile(coinListMap: state.coinListMap, index: index);
                        },
                        childCount: state.coinListMap.data.length,
                      ),
                    ),
                  ],
                )

                /// ### Commented out customscrollview above ### ///

              );
            } else if (state is CardCryptoDataErrorState) {
              log("CardCryptoDataErrorState");
              return buildErrorTemplate(state.errorMessage);
            } else {
              return null;
            }
          }
        ),
      ),
    );
  }
}

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