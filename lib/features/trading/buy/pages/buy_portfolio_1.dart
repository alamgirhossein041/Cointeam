import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/market/models/coingecko_list_top_100_model.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class BuyPortfolioScreenOne extends StatefulWidget {
  BuyPortfolioScreenOne({
    Key key
  }) : super(key: key);

  @override
  BuyPortfolioScreenOneState createState() => BuyPortfolioScreenOneState();
}

class BuyPortfolioScreenOneState extends State<BuyPortfolioScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy From Snapshot'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: primaryBlue,
          ),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: primaryBlue,
            body: Stack(
              children: <Widget> [
                TitleBar(title: "Buy from Snapshot"),
                Container(
                  margin: mainCardMargin(),
                  decoration: mainCardDecoration(),
                  // padding: mainCardPaddingVertical(),
                  padding: scrollCardPadding(),
                  width: displayWidth(context),
                  child: Column(
                    children: <Widget> [
                      Text("Select a Snapshot to buy from"),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BuyFromSnapshotList(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          )
        )
      ),
    );
  }
}

class BuyFromSnapshotList extends StatefulWidget {
  const BuyFromSnapshotList({
    Key key
  }) : super(key: key);

  @override
  BuyFromSnapshotListState createState() => BuyFromSnapshotListState();
}

class BuyFromSnapshotListState extends State<BuyFromSnapshotList> {
  final _scrollController = ScrollController();
  final LocalStorage localStorage = LocalStorage("coinstreetapp");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      child: FutureBuilder(
        future: getStorage(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
            if (!snapshot.hasError) {
              if(snapshot.data != null) {
                return BlocConsumer<StartupBloc, StartupState>(
                  listener: (context, state) {
                    if (state is StartupErrorState) {
                      log("There is an error");
                    }
                  },
                  builder: (context, state) {
                    if (state is StartupLoadedState) {
                      return Column(
                        children: <Widget> [
                          Flexible(
                            flex: 10,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: EdgeInsets.only(top: displayHeight(context) * 0.035),
                              child: Scrollbar(
                                controller: _scrollController,
                                isAlwaysShown: true,
                                thickness: 5,
                                child: CustomScrollView(
                                  controller: _scrollController,
                                  slivers: <Widget> [
                                    // SliverToBoxAdapter(
                                    SliverToBoxAdapter(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,0,0,30),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget> [
                                              Text("Date", style: TextStyle(color: Color(0x800B2940), fontSize: 14)),
                                              SizedBox(width: 20),
                                              Icon(Icons.swap_vert),
                                              SizedBox(width: 20),
                                            ]
                                          )
                                        ),
                                      )
                                    ),
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate((context, index) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () => {
                                            // log(snapshot.data[index].toString()),
                                            Navigator.pushNamed(context, '/buyportfolio2', arguments: {'coinDataStructure': snapshot.data[index], 'index': index+1})
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: displayHeight(context) * 0.035),
                                            child: BuySnapshotListTile(
                                              id: (index + 1),
                                              coinData: snapshot.data[index],
                                              coinMap: state.coingeckoModelMap,
                                            ),
                                          ),
                                        );
                                      },
                                      childCount: (snapshot.data.length),
                                      ),
                                    ),
                                  ]
                                ),
                              ),
                            ),
                          ),
                        ]
                      );
                    } else if (state is StartupLoadingState) {
                      return loadingTemplateWidget(1);
                    } else {
                      return Text("ERROR");
                    }
                  }
                );
              } else {
                // log(snapshot.toString());
                return errorTemplateWidget("You have no transaction snapshots.");
              }
            } else {
              log("Something");
              return errorTemplateWidget("Help");
            }
          }
        }
      ),
    );
  }
  Future getStorage() async {
    var ready = await localStorage.ready;
    var value = localStorage.getItem("portfolio");
    // log(value.toString());
    return value;
  }
}

class BuySnapshotListTile extends StatelessWidget {
  const BuySnapshotListTile({Key key, this.id, this.coinData, this.coinMap}) : super(key: key);
  final int id;
  final Map<String, dynamic> coinData;
  final Map<String, dynamic> coinMap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [
        // Flexible(
        //   flex: 1,
        //   fit: FlexFit.tight,
        //   child: Container(),
        // ),
        // Container(width: 40),
        Text('#${id.toString()}'),
        Expanded(
          flex: 3,
          child: BuySnapshotCoinIconsList(coinList: _getCoinNames(), coinMap: coinMap),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget> [
              Text(DateFormat("dd MMM yyyy").format(DateTime.fromMillisecondsSinceEpoch(coinData['timestamp']))),
              SizedBox(height: 5),
              Text(DateFormat("h:mm a").format(DateTime.fromMillisecondsSinceEpoch(coinData['timestamp'])),
                style: TextStyle(color: primaryDark.withOpacity(0.5)),
              ),
            ]
          )
        ),
      ]
    );
  }
  /// Iterate through the map of coins and return a list of their symbols
  List<String> _getCoinNames() {
    List<String> coinNames = [];
    coinData['coins'].forEach((key, value) {
      coinNames.add(key.toString());
    });
    return coinNames;
  }
}

class BuySnapshotCoinIconsList extends StatelessWidget {
  const BuySnapshotCoinIconsList({Key key, this.coinList, this.coinMap}) : super(key: key);
  final List<String> coinList;
  final Map<String, dynamic> coinMap;

  @override
  Widget build(BuildContext context) {
    int _length = coinList.length;

    // Display maximum of 3 coin icons. Number of remaining coins is displayed as a 4th coin.
    if (_length < 1) {
      return Text('No coins are in this snapshot.');
    } else if (_length <= 3) {
      log('coinmap = ' + coinMap.toString());
      return Row(
        // i = 'BTC'
        children: <Widget>[for (var i in coinList) BuildIcon(coin: coinMap[i])],
      );
    } else {
      // > 3 coins
      int remaining = _length - 3;
      return Row(
        children: <Widget>[
          for (var i = 0; i < 3; i++) BuildIcon(coin: coinMap[coinList[i]]),
          RemainingCoinIcon(count: remaining),
        ],
      );
    }
  }
}

/// Returns the icon image for the given [coin]
class BuildIcon extends StatelessWidget {
  const BuildIcon({Key key, this.coin, }) : super(key: key);

  final CoingeckoListTop100Model coin;

  @override
  Widget build(BuildContext context) {
  final LocalStorage localStorage = LocalStorage("coinstreetapp");

    // get localstorage of icons
    // if it doesnt exist, 
    // LocalStorage package will create a new localstorage instance with this key,
    // then return it. So then, check if it contains the item "coinIcons",
    // if it doesn't exist, create one with the default image.
    List<dynamic> coinIcons = localStorage.getItem('coinIcons') ?? [{'coinstreetapp-placeholder-coin-icon':'placeholder-icon.jpg'}];

    // when you sell a coin, add to a list of sold coin history 
    // on app load, get this list of coins, get url 

    // else get it
    
    log(coin.image.toString());
    log(coin.symbol.toString());

    return FutureBuilder(
      future: localStorage.ready,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Couldn't get snapshot data.");
          }
          return Padding(
            padding: EdgeInsets.only(right: 14.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 17.5,
              backgroundImage: CachedNetworkImageProvider(
                coin.image
              ),
              // backgroundImage: CachedNetworkImageProvider(
              //   'https://assets.coingecko.com/coins/images/279/small/ethereum.png',
              // ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: <Widget>[
              Text('Loading..'),
              CircularProgressIndicator(),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

/// Circle icon that displays the remaining [count] of coins.
class RemainingCoinIcon extends StatelessWidget {
  const RemainingCoinIcon({Key key, this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            border: Border.all(color: primaryBlue),
            shape: BoxShape.circle,
          ),
        ),
        Text(
          '+$count',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: primaryDark.withOpacity(0.6)),
        ),
      ],
    );
  }
}
