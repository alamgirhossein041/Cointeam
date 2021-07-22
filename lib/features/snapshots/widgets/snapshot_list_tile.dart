import 'dart:developer';
import 'package:coinsnap/features/market/market.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

/// [id] is used to display the order number of snapshot.
/// [coinMap] is a map of all of the coingecko coin models from the startup bloc.
class SnapshotListTile extends StatelessWidget {
  const SnapshotListTile({Key key, this.id, this.coinData, this.coinMap}) : super(key: key);
  final int id;
  final Map<String, dynamic> coinData;
  final Map<String, dynamic> coinMap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0),
      child: Row(
        children: <Widget>[
          Text('#${id.toString()}'),
          Expanded(
            flex: 3,
            child: SnapshotCoinIconsList(coinList: _getCoinNames(), coinMap: coinMap),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('dd MMM yyyy').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      coinData['timestamp'],
                    ),
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      coinData['timestamp'],
                    ),
                  ),
                  style: TextStyle(
                    color: primaryDark.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

/// Displays the list of icons in [coinList].
class SnapshotCoinIconsList extends StatelessWidget {

  const SnapshotCoinIconsList({Key key, this.coinList, this.coinMap}) : super(key: key);
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
              Text('Waiting for icons to load..'),
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
