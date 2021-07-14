import 'dart:developer';

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
            child: _SnapshotCoinIconsList(coinList: _getKeys()),
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

class _SnapshotCoinIconsList extends StatelessWidget {
  const _SnapshotCoinIconsList({Key key, this.coinList}) : super(key: key);
  final List coinList;

  @override
  Widget build(BuildContext context) {
    int _length = coinList.length;

    // Display maximum of 3 coin icons. Number of remaining coins is displayed as a 4th coin.
    if (_length < 1) {
      return Text('No coins are in this snapshot.');
    } else if (_length == 1) {
      return Text(coinList[0]);
    } else if (_length <= 3) {
      return Row(
        children: <Text>[
          for (var i in coinList) Text(i),
        ],
      );
    } else {
      // > 3 coins
      int remaining = _length - 3;
      return Row(
        children: <Text>[
          for (var i = 0; i < 3; i++) Text(coinList[i]),
          Text('+$remaining'),
        ],
      );
    }
  }
}
