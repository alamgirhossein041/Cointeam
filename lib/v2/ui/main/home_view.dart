import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/cryptocompare/chart/chart_cryptocompare.dart';
import 'package:coinsnap/v2/ui/core_widgets/container_panel.dart';
import 'package:coinsnap/v2/ui/core_widgets/syncfusion_chart_cartesian.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/menu_drawer/drawer_widget.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
// import 'package:crypto_font_icons/crypto_font_icon_data.dart';
import 'package:coinsnap/v2/asset/icon_custom/icon_custom.dart' as CustomIcon;

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

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

  /// custom padding in pixels, because Dialog comes attached with a default FAT padding :)
  double modalEdgePadding = 10;

 

  @override
  void initState() {
    /// TODO: stuff
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: appBlack,
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
                        IconButton(icon: Icon(Icons.swap_vert, color: Color(0xFFA9B1D9)), onPressed: () {}),
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
                              child: introViews,

                              // content: Builder(
                              //   builder: (context) {
                              //     // var width = displayWidth(context) * 0.2;

                              //     return Container(
                              //       height: displayHeight(context) * 0.65,
                              //       width: displayWidth(context),
                              //       // decoration: BoxDecoration(
                              //       //   color:
                              //       // ),
                              //       child: Center(
                              //         child: Text("Hello"),
                              //       ),
                              //     );
                              //   }
                              // )


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
/// list of pageviewmodels required by intro_views_flutter
/// used for API tutorial thingy
final page = new PageViewModel(
  pageColor: const Color(0xFF607D8B),
  // iconImageAssetPath: '',
  iconColor:  Color(0xFF607D8B),
  bubbleBackgroundColor:  Color(0xFF607D8B),
  body: Text(
    'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
  ),
  title: Text('Cabs'),
  // mainImage: Image.asset(
  //   height: 285.0,
  //   width: 285.0,
  //   alignment: Alignment.center,
  // ),
  titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
  bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
);


final Widget introViews = IntroViewsFlutter(
  [page],
  onTapDoneButton: (){
    //Void Callback
  },
  showSkipButton: true,
  pageButtonTextStyles: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontFamily: "Regular",
    ),
);


class ModalPopup extends StatefulWidget {
  ModalPopup({Key key}) : super(key: key);

  @override
  _ModalPopupState createState() => _ModalPopupState();
}




/// API tutorial modal popup
class _ModalPopupState extends State<ModalPopup> {

  /// Currently selected value of dropdown
  String dropdownValue = 'Binance';

  /// placeholder URL for API linking tutorial process
  String placeHolderImgURL = "http://2.bp.blogspot.com/_ThTvH632hGo/S92-5kncTYI/AAAAAAAAByE/7DAWC0aecC0/s640/2-7.jpg";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.70,
      width: displayWidth(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.08, -1.08),
          end: Alignment(1, 1.06),
          colors: [
            Color(0xFF443E48),
            Color(0xFF1B1F2D),
          ],
        ),
      ),

      child: Column(
        children: <Widget> [
          SizedBox(height: displayHeight(context) * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget> [
              Container(width: 58),
              Text("(3 mins)", style: TextStyle(color: Colors.white)),
              // Container(width: displayWidth(context) * 0.4,
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  Text("+50 ", style: TextStyle(color: Colors.white)),
                  Icon(Icons.av_timer, color: Colors.white),
                ],
              ),
            ],
          ),
          SizedBox(height: displayHeight(context) * 0.1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text("Connect ", style: TextStyle(color: textLight)),
              Container(
                // height: displayHeight(context) * 0.07,
                // width: displayWidth(context) * 0.18,
                child: 
                  /// Dropdown selection for API linking tutorial, select from Binance, FTX etc
                  DropdownButton<String>(
                        dropdownColor: uniColor,
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down, color: modalAccentColor),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: textLight),
                        underline: Container(
                          height: 2,
                          // TODO: andrew wants line to be shorter
                          padding: EdgeInsets.only(right: 40),
                          color: modalAccentColor,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Binance', 'Two', 'Free', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                //   child: TextField(
                //   textAlign: TextAlign.center,
                //   decoration: InputDecoration(
                //     labelText: 'Binance',
                //     labelStyle: TextStyle(color: Colors.white),
                //     // floatingLabelBehavior: FloatingLabelBehavior.always,
                //     // filled: true,
                //     // fillColor: Color(0xFF126FFF),
                //     enabledBorder: UnderlineInputBorder(      
                //       borderSide: BorderSide(color: Color(0X3BA6D6)),   
                //     ),  
                //   ),
                // ),
              ),
            ],
          ),
          // Image.network(placeHolderImgURL),
          Text('To enable trading, go to Binance Web', style: TextStyle(color: textLight)),
          Padding(
            padding: EdgeInsets.all(30),
            child: Image.network(placeHolderImgURL),
          ),
          
          Row(),
          Row(),
          Row(),
        ],
      ),
    );
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
                BlocProvider.of<CardCoinmarketcapCoinLatestBloc>(context).add(FetchCardCoinmarketcapCoinLatestEvent());
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
    _heightOffset = displayHeight(widget.context) * 0.12;
    BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
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
                                        child: Icon(CustomIcon.IconCustom.wallet_tilt, color: Colors.white, )
                                      ),
                                    ),
                                  ),
                                
                                ],
                              ),
                            ),
                          )
                        ),
                        BlocListener<GetTotalValueBloc, GetTotalValueState>(
                          listener: (context, state) {
                            if (state is GetTotalValueErrorState) {
                              log("error in GetTotalValueState in home_view.dart");
                            }
                          },
                          child: BlocBuilder<GetTotalValueBloc, GetTotalValueState>( /// Both bloc types to be built (refactor existing controllers)
                            builder: (context, state) {
                              if (state is GetTotalValueInitialState) {
                                log("GetTotalValueInitialState");
                                return loadingTemplateWidget();
                              } else if (state is GetTotalValueLoadingState) {
                                log("GetTotalValueLoadingState");
                                return loadingTemplateWidget();
                              } else if (state is GetTotalValueLoadedState) {
                                log("GetTotalValueLoadedState");
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
                        ),
                        


                        /// ### Start Expanded Buttons Here ### ///

                        // Column(
                        //   children: <Widget> [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: <Widget> [
                        //         Text("Price", style: TextStyle(fontSize: 20, color: Colors.white)),
                        //         Text("\$3,616.62"),
                        //       ],
                        //     ),
                        //     Row(

                        //     ),
                        //     Row(),
                        //     SizedBox(),
                        //   ],
                        // ),

                        /// ### Providing the GetTotalValueBloc to the child ContainerPanel widget (file stored in ui_root/v2/core_widgets) ### ///
                        // BlocProvider<GetTotalValueBloc>(
                          // create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
                          ContainerPanel(panelVisibility: _panelVisibility),
                        // ),

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

  CardCoinmarketcapCoinLatestBloc  cardCoinmarketcapCoinLatestBloc;

  double _heightHideContainer;
  double _heightShowContainer;

  CryptoCompareRepositoryImpl cryptoCompareRepository = CryptoCompareRepositoryImpl();
  // var hello;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    cardCoinmarketcapCoinLatestBloc = BlocProvider.of<CardCoinmarketcapCoinLatestBloc>(context);
    cardCoinmarketcapCoinLatestBloc.add(FetchCardCoinmarketcapCoinLatestEvent());
    // hello = cryptoCompareRepository.getHourlyCryptoCompare();
  }

  @override
  Widget build(BuildContext context) {
    _heightHideContainer = displayHeight(context) * 0.50;
    _heightShowContainer = displayHeight(context) * 0.23;
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      height: widget.showContainer ? _heightShowContainer : _heightHideContainer,
      child: BlocListener<CardCoinmarketcapCoinLatestBloc, CardCoinmarketcapCoinLatestState>(
        listener: (context, state) {
          if (state is CardCoinmarketcapCoinLatestErrorState) {
            log("error in CardCryptoDataErrorState in home_view_real.dart");
          }
        },
        child: BlocBuilder<CardCoinmarketcapCoinLatestBloc, CardCoinmarketcapCoinLatestState>( /// Both bloc types to be built (refactor existing controllers)
          builder: (context, state) {
            if (state is CardCoinmarketcapCoinLatestInitialState) {
              log("CardCoinmarketcapCoinLatestInitialState");
              return loadingTemplateWidget();
            } else if (state is CardCoinmarketcapCoinLatestLoadingState) {
              log("CardCoinmarketcapCoinLatestLoadingState");
              return loadingTemplateWidget();
            } else if (state is CardCoinmarketcapCoinLatestLoadedState) {
              log("CardCoinmarketcapCoinLatestLoadedState");
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
                      
                      child: FutureBuilder(
                        future: cryptoCompareRepository.getHourlyCryptoCompare(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return CircularProgressIndicator();
                          } else {
                            return SizedBox(
                              height: displayHeight(context) * 0.27,
                              child: ChartOverall(priceList: snapshot.data),
                            );
                          }
                        },
                      ),

                      // child: SizedBox(
                      //   height: displayHeight(context) * 0.27,
                      //   child: ChartOverall(),
                    ), /// ### Chart section ends here ### ///
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
