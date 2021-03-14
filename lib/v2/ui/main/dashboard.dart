import 'dart:developer';

import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_portfolio_data_bloc/get_portfolio_data_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_portfolio_data_bloc/get_portfolio_data_event.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_portfolio_data_bloc/get_portfolio_data_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/ui/copies/bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/ui/core_widgets/cards/new_card_list_tile.dart';
import 'package:coinsnap/v2/ui/core_widgets/price_container/price_container.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
import 'package:coinsnap/working_files/drawer.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/v2/asset/icon_custom/icon_custom.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  List coinList;

  @override
  void didChangeDependencies() { /// ### Calls everything inside on screen load ### ///
    super.didChangeDependencies();
    // BlocProvider.of<GetPortfolioDataBloc>(context).add(FetchGetPortfolioDataEvent());
    BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
  }

  double modalEdgePadding = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B0D19),
      bottomNavigationBar: BottomNavBar(callBack: _callBackSetState),
      drawer: DrawerMenu(),
      body: Container(
        child: Column(
          children: <Widget> [
            // Text("Hello World", style: TextStyle(color: Colors.white))
            Expanded(
              flex: 3,
              child: TopMenuRow(),
            ),
            Expanded(
              flex: 16,
              child: RefreshIndicator(
                onRefresh: () async {
                  // BlocProvider.of<GetPortfolioDataBloc>(context).add(FetchGetPortfolioDataEvent());
                },
                child: HeaderBox(),
              ),
            ),
          ]
        )
      ),
    );


    /// ### If Bloc hasn't returned yet, display splash screen(?) ### ///
    
    
    // return BlocConsumer<GetCoinListBloc, GetCoinListState>(
    //   listener: (context, state) {
    //     if (state is GetCoinListErrorState) {
    //       log("error in GetCoinListState in home_view.dart");
    //       Navigator.of(context).pushNamed('/errorscreen');
    //     } else if (state is GetCoinListCoinListState) {
    //       coinList = state.coinList;
    //       /// Navigator.of(context).pushNamed('AHHHHHH'); ### Set up splash screen bloc? Or not
    //     }
    //     /// } else if (state is GetPortfolioDispatchChartState) {
    //       /// TODO: dispatch chart bloc
    //   },
    //   builder: (context, state) {
    //     if (state is GetCoinListLoadedState) {   /// ### Comes with state.coinListData -- type CardCoinmarketcapListModel
    //       log("GetCoinListLoadedState");
    //       return 
    //     } else {
    //       log("GetCoinListLoadingState");
    //       return CircularProgressIndicator();
    //     }
    //   }
    // );
  }

  /// ### Callback function for child widget to setState (and refresh) on this widget ### ///
  void _callBackSetState() {
    setState(() {
      log("Hello World");
    });
  }
}

class BottomNavBar extends StatefulWidget {
  BottomNavBar({this.callBack});
  final Function callBack;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Container(
          /// ### This is the bottomappbar ### ///
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
                        /// ### Bottom left button on bottomnavbar ### ///
                        IconButton(icon: Icon(Icons.swap_vert, color: Color(0xFFA9B1D9)), onPressed: () {
                        }),
                        IconButton(icon: Icon(Icons.help_center, color: Color(0xFFA9B1D9)), onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              /// Manual padding override because Dialog's default padding is FAT
                              insetPadding: EdgeInsets.all(10),
                              /// Connect API tutorial modal
                              // child: ModalPopup(),
                              child: IntroScreen(),
                            ),
                          );
                        }),
                        /// ### Bottom right button on bottomnavbar ### ///
                        IconButton(icon: Icon(Icons.refresh, color: Color(0xFFA9B1D9)), onPressed: () {widget.callBack();}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderBox extends StatefulWidget {
  const HeaderBox({Key key}) : super(key: key);
  
  @override
  HeaderBoxState createState() => HeaderBoxState();
}

class HeaderBoxState extends State<HeaderBox> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Column(
        children: <Widget> [
          Expanded(
            flex: 3,
            child: Container(
              decoration: headerBoxDecoration,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,2.75,0,2.75),
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: headerBoxInnerDecoration,
                  child: BlocConsumer<GetCoinListBloc, GetCoinListState>(
                    listener: (context, state) {
                      if (state is GetCoinListErrorState) {
                        log("GetCoinListErrorState");
                      }
                    },
                    builder: (context, state) {
                      if (state is GetCoinListLoadedState) {
                        log("GetCoinListLoadedState");
                        BlocProvider.of<GetCoinListTotalValueBloc>(context).add(FetchGetCoinListTotalValueEvent(coinList: state.coinList, coinBalancesMap: state.coinBalancesMap));
                        return Column(
                          children: <Widget> [
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: HeaderBoxWalletIcon(),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: BlocConsumer<GetCoinListTotalValueBloc, GetCoinListTotalValueState>(
                                listener: (context, state) {
                                  if (state is GetCoinListTotalValueErrorState) {
                                    log("GetCoinListTotalValueErrorState");
                                  }
                                },
                                builder: (context, state) {
                                  if (state is GetCoinListTotalValueLoadedState) {
                                    return Text("\$" + state.totalValue.toStringAsFixed(2), style: TextStyle(fontSize: 22, color: Colors.white));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              
                              // Text("\$26,646.23", style: TextStyle(fontSize: 22, color: Colors.white)),
                            )
                          ]
                        );
                      } else {
                        log("GetCoinList(notloaded)State");
                        return loadingTemplateWidget();
                      }
                    }
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: BlocBuilder<GetCoinListTotalValueBloc, GetCoinListTotalValueState>(
              builder: (context, state) {
                if (state is GetCoinListTotalValueLoadedState) {
                  return CustomScrollView(
                    slivers: <Widget> [
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return NewCardListTile(state.coinListData, state.coinListData, state.totalValue);
                            // child: Text("Hello World", style: TextStyle(color: Colors.white, fontSize: 20)));
                          },
                          childCount: state.coinListData.length,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderBoxWalletIcon extends StatelessWidget {
  const HeaderBoxWalletIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      /// ### Size of wallet icon ### ///
      height: 31.43,
      width: 36.23,
      child: Column(
        children: <Widget> [
          Expanded(
            child: Transform.rotate(
              angle: -5 * math.pi / 180,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(IconCustom.wallet_tilt, color: Colors.white),
              )
            ),
          )
        ]
      )
    );
  }
}

var headerBoxDecoration = BoxDecoration(
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
);

var headerBoxInnerDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment(-1.25, -1.15),
    end: Alignment(0.85, 1.1),
    colors: [
      Color(0xFF240C37),
      Color(0xFF061330),
      // Colors.white,
    ],
  ),
);