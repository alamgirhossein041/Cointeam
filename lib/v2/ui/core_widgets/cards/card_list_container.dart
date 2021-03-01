import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest_state.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_state.dart';
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
    _heightHideContainer = displayHeight(context) * 0.50;
    _heightShowContainer = displayHeight(context) * 0.23;
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      height: widget.showContainer ? _heightShowContainer : _heightHideContainer,
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
                        return CardListTile(coinListMap: state.coinListReceived, index: index);
                      },
                      childCount: state.coinListReceived.length,
                    ),
                  ),
                ],
              );
            } else if (state is GetTotalValueLoadedState) {
              return CustomScrollView(
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
                        return CardListTile(coinListMap: state.coinListReceived, index: index);
                      },
                      childCount: state.coinListReceived.length,
                    ),
                  ),
                ],
              );
            } else {
              return loadingTemplateWidget();
            }
          }
        )
      ),
    );
  }
}