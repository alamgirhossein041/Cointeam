import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_state.dart';
import 'package:coinsnap/v2/helpers/global_library.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/cryptocompare/chart/chart_cryptocompare.dart';
import 'package:coinsnap/v2/ui/core_widgets/cards/card_list_tile.dart';
import 'package:coinsnap/v2/ui/core_widgets/charts/syncfusion_chart_cartesian.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/v2/helpers/global_library.dart' as globals;

class ListContainer extends StatefulWidget {
  ListContainer({Key key, this.showContainer}) : super(key: key);
  final bool showContainer;

  @override
  _ListContainerState createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {

  double _heightHideContainer;
  double _heightShowContainer;

  CryptoCompareRepositoryImpl cryptoCompareRepository = CryptoCompareRepositoryImpl();
  // var hello;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // hello = cryptoCompareRepository.getHourlyCryptoCompare();
  }

  @override
  Widget build(BuildContext context) {
    _heightHideContainer = displayHeight(context) * 0.56;
    _heightShowContainer = displayHeight(context) * 0.36;
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      height: widget.showContainer ? _heightShowContainer : _heightHideContainer,
      // child: BlocListener<GetTotalValueBloc, GetTotalValueState>(
      //   listener: (context, state) {
      //     if (state is GetTotalValueErrorState) {
      //       log("error in GetTotalValueBloc in card_list_container.dart");
      //     }
      //   },
      //   child: BlocBuilder<GetTotalValueBloc, GetTotalValueState>( /// Both bloc types to be built (refactor existing controllers)
      //     builder: (context, state) {
      //       if (state is GetTotalValueLoadedState) {

            /// ### Chart section starts here ### ///
            
            // child: FutureBuilder(
            //   future: cryptoCompareRepository.getHourlyCryptoCompare(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     if (snapshot.data == null) {
            //       return CircularProgressIndicator();
            //     } else {
            //       return SizedBox(
            //         height: displayHeight(context) * 0.27,
            //         child: ChartOverall(priceList: snapshot.data),
            //       );
            //     }
            //   },
            // ),
            
            // child: BlocListener<BinanceGetChartBloc, BinanceGetChartState>(
            //   listener: (context, state) {
            //     if (state is BinanceGetChartErrorState) {
            //       log("error in GetTotalValueBloc in card_list_container.dart");
            //     }
            //   },
            //   child: BlocBuilder<BinanceGetChartBloc, BinanceGetChartState>( /// Both bloc types to be built (refactor existing controllers)
            //     builder: (context, state) {
            //       if (state is BinanceGetChartInitialState) {
            //         log("BinanceGetChartInitialState");
            //         return Container();
            //       } else if (state is BinanceGetChartLoadingState) {
            //         log("BinanceGetChartLoadingState");
            //         return Container();
            //       } else if (state is BinanceGetChartLoadedState) {
            //         return SizedBox(
            //           height: displayHeight(context) * 0.27,
            //           child: ChartOverall(),
            //         );
            //       } else {
            //         // return CircularProgressIndicator();
            //         return Container();
            //       }
            //     }
            //   ),
            // ),
          // ), /// ### Chart section ends here ### ///
      child: BlocListener<GetTotalValueBloc, GetTotalValueState>(
        listener: (context, state) {
          if (state is GetTotalValueErrorState) {
            log("error in GetTotalValueBloc in card_list_container.dart");
          }
        },
        child: BlocBuilder<GetTotalValueBloc, GetTotalValueState>( /// Both bloc types to be built (refactor existing controllers)
          builder: (context, state) {
            if (state is GetTotalValueLoadedState) {
              return CustomScrollView(
                slivers: <Widget> [
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget> [
                        IconButton(
                          icon: Icon(Icons.hourglass_empty, color: Colors.white),
                          onPressed: () {
                            BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.daily));
                          }
                        ),
                        IconButton(
                          icon: Icon(Icons.hourglass_empty, color: Colors.white),
                          onPressed: () {
                            BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.weekly));
                          }
                        ),
                        IconButton(
                          icon: Icon(Icons.hourglass_full, color: Colors.white),
                          onPressed: () {
                            BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.monthly));
                          }
                        ),
                        IconButton(
                          icon: Icon(Icons.alarm, color: Colors.white),
                          onPressed: () {
                            BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.yearly));
                          }
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    // child: SizedBox(
                    //   height: displayHeight(context) * 0.27,
                    //   child: ChartOverall(),
                    child: ChartOverall(),
                  ), /// TODO: Stop wasting time
                  
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                        return CardListTile(coinListMap: state.coinListReceived, index: index);
                      },
                      childCount: state.coinListReceived.length,
                    ),
                  )
                ]
              );
            } else {
              return Container();
              // return SliverToBoxAdapter(
              //   child: CircularProgressIndicator(), /// or just repeat sliverlist with circularprogressindics
              // );
            }
          }
        )
      )
    );
    //     ]
    //   )
    // );
                      //   ],
                      // );
            // } else if (state is GetTotalValueLoadedState) {
            //   return CustomScrollView(
            //     slivers: <Widget> [
            //       SliverToBoxAdapter(
                    /// ### Chart section starts here ### ///
                    
                    // child: FutureBuilder(
                    //   future: cryptoCompareRepository.getHourlyCryptoCompare(),
                    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //     if (snapshot.data == null) {
                    //       return CircularProgressIndicator();
                    //     } else {
                    //       return SizedBox(
                    //         height: displayHeight(context) * 0.27,
                    //         child: ChartOverall(priceList: snapshot.data),
                    //       );
                    //     }
                    //   },
                    // ),



                    // child: SizedBox(
                    //   height: displayHeight(context) * 0.27,
                    //   child: ChartOverall(),
              //     ), /// ### Chart section ends here ### ///
              //     SliverList(
              //       delegate: SliverChildBuilderDelegate((context, index) {
              //           return CardListTile(coinListMap: state.coinListReceived, index: index);
              //         },
              //         childCount: state.coinListReceived.length,
              //       ),
              //     ),
              //   ],
              // );
            // } else {
            //   return loadingTemplateWidget();
    //         }
    //       }
    //     )
    //   ),
    // );
  }
}



class ListContainerWithContainer extends StatefulWidget {
  ListContainerWithContainer({Key key, this.showContainer, this.category}) : super(key: key);
  final bool showContainer;
  final Categories category;

  @override
  _ListContainerStateWithContainer createState() => _ListContainerStateWithContainer();
}

class _ListContainerStateWithContainer extends State<ListContainerWithContainer> {

  double _heightHideContainer;
  double _heightShowContainer;

  CryptoCompareRepositoryImpl cryptoCompareRepository = CryptoCompareRepositoryImpl();
  // var hello;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _heightHideContainer = displayHeight(context) * 0.56;
    _heightShowContainer = displayHeight(context) * 0.36;
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      height: widget.showContainer ? _heightShowContainer : _heightHideContainer,
      child: BlocListener<ListTotalValueBloc, ListTotalValueState>(
        listener: (context, state) {
          if (state is ListTotalValueErrorState) {
            log("error in ListTotalValueBloc in card_list_container.dart");
          }
        },
        child: BlocBuilder<ListTotalValueBloc, ListTotalValueState>( /// Both bloc types to be built (refactor existing controllers)
          builder: (context, state) {
            if (state is ListTotalValueLoadedState) {
              return CustomScrollView(
                slivers: <Widget> [
                  // SliverToBoxAdapter(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: <Widget> [
                  //       IconButton(
                  //         icon: Icon(Icons.hourglass_empty, color: Colors.white),
                  //         onPressed: () {
                  //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.daily));
                  //         }
                  //       ),
                  //       IconButton(
                  //         icon: Icon(Icons.hourglass_empty, color: Colors.white),
                  //         onPressed: () {
                  //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.weekly));
                  //         }
                  //       ),
                  //       IconButton(
                  //         icon: Icon(Icons.hourglass_full, color: Colors.white),
                  //         onPressed: () {
                  //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.monthly));
                  //         }
                  //       ),
                  //       IconButton(
                  //         icon: Icon(Icons.alarm, color: Colors.white),
                  //         onPressed: () {
                  //           BlocProvider.of<BinanceGetChartBloc>(context).add(FetchBinanceGetChartEvent(binanceGetAllModelList: state.coinListReceived, binanceGetPricesMap: state.binanceGetPricesMap, timeSelection: globals.Status.yearly));
                  //         }
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SliverToBoxAdapter(
                  //   child: ChartOverall(),
                  // ), /// TODO: Stop wasting time
                  
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                        return CardListTileWithCategory(coinList: state.coinList, index: index, cardCoinmarketcapListModel: state.cardCoinmarketcapListModel,);
                      },
                      childCount: state.coinList.length,
                    ),
                  )
                ]
              );
            } else {
              return Container();
            }
          }
        )
      )
    );
  }
}