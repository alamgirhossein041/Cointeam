import 'package:flutter/material.dart';

class SnapshotListItem extends StatelessWidget {
  const SnapshotListItem({Key key, this.id, this.coinData})
      : super(key: key);
  final int id;
  final Map<String, dynamic> coinData;

  // parse json coin data
  _getKeys() {
  var keys = coinData?.coinData['coins']?.coinData.keys.toList();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Text(id.toString()),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: _SnapshotCoinList(coinList: coins),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(date),
                    Text(time),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SnapshotCoinList extends StatelessWidget {
  const _SnapshotCoinList({Key key, this.coinList}) : super(key: key);
  final List coinList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
