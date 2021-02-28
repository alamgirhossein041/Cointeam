import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_state.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/cryptocompare/chart/chart_cryptocompare.dart';
import 'package:coinsnap/v2/ui/core_widgets/cards/card_list_tile.dart';
import 'package:coinsnap/v2/ui/core_widgets/charts/syncfusion_chart_cartesian.dart';
import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListContainer extends StatefulWidget {
  ListContainer({Key key, this.showContainer}) : super(key: key);
  final bool showContainer;

  @override
  _ListContainerState createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {

  CardCoinmarketcapCoinLatestBloc cardCoinmarketcapCoinLatestBloc;

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