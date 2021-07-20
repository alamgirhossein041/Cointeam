import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SnapshotListTile extends StatelessWidget {
  const SnapshotListTile({Key key, this.id, this.coinData}) : super(key: key);
  final int id;
  final Map<String, dynamic> coinData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SnapshotCoinIconsList(coinList: _getCoinNames()),
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
  const SnapshotCoinIconsList({Key key, this.coinList}) : super(key: key);
  final List<String> coinList;

  @override
  Widget build(BuildContext context) {
    int _length = coinList.length;

    // Display maximum of 3 coin icons. Number of remaining coins is displayed as a 4th coin.
    if (_length < 1) {
      return Text('No coins are in this snapshot.');
    } else if (_length <= 3) {
      return Row(
        children: <Widget>[for (var i in coinList) BuildIcon(coin: i)],
      );
    } else {
      // > 3 coins
      int remaining = _length - 3;
      return Row(
        children: <Widget>[
          for (var i = 0; i < 3; i++) BuildIcon(coin: coinList[i]),
          RemainingCoinIcon(count: remaining),
        ],
      );
    }
  }
}

/// Returns the icon image for the given [coin]
class BuildIcon extends StatelessWidget {
  const BuildIcon({Key key, String coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // call api to get icon's name
    Future<http.Response> fetchAlbum() {
      return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    }

    return Padding(
      padding: EdgeInsets.only(right: 14.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 17.5,
        backgroundImage: CachedNetworkImageProvider(
          'https://assets.coingecko.com/coins/images/279/small/ethereum.png',
        ),
      ),
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
