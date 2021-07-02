import 'package:flutter/material.dart';

class DominanceWidget extends StatefulWidget {
  @override
  _DominanceWidgetState createState() => _DominanceWidgetState();
}

class _DominanceWidgetState extends State<DominanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Dominance'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  'BTC: 64%',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'ETH: 12%',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
