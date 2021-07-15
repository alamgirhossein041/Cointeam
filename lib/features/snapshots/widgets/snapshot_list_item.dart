import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SnapshotListItem extends StatelessWidget {
  const SnapshotListItem({Key key, this.id, this.coinData}) : super(key: key);
  final int id;
  final Map<String, dynamic> coinData;

  // list of coin symbols in this list item
  List _getKeys() {
    return coinData['coins'].keys.toList();
    // keys.forEach((v) => log(v));
  }

  @override
  Widget build(BuildContext context) {
    _getKeys();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: SnapshotCoinIconsList(coinList: _getKeys()),
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
}

/// Displays the list of icons in [coinList].
class SnapshotCoinIconsList extends StatelessWidget {
  const SnapshotCoinIconsList({Key key, this.coinList}) : super(key: key);
  final List coinList;

  @override
  Widget build(BuildContext context) {
    int _length = coinList.length;

    // Display maximum of 3 coin icons. Number of remaining coins is displayed as a 4th coin.
    if (_length < 1) {
      return Text('No coins are in this snapshot.');
    } else if (_length <= 3) {
      return Row(
        children: <Widget>[
          // for (var i in coinList) Text(i),
          for (var i in coinList) buildIcon(i)
        ],
      );
    } else {
      // > 3 coins
      int remaining = _length - 3;
      return Row(
        children: <Widget>[
          for (var i = 0; i < 3; i++) buildIcon(coinList[i]),
          RemainingCoinIcon(count: remaining),
        ],
      );
    }
  }

  buildIcon(String symbol) => CircleAvatar(
    radius: 17.5,
        backgroundImage: CachedNetworkImageProvider(
          'https://assets.coingecko.com/coins/images/279/small/ethereum.png',
        ),
      );
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
