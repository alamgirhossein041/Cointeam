import 'package:coinsnap/features/home/widgets/dominance.dart';
import 'package:flutter/material.dart';

class HomeDisplayInfo extends StatefulWidget {
  @override
  _HomeDisplayInfoState createState() => _HomeDisplayInfoState();
}

class _HomeDisplayInfoState extends State<HomeDisplayInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Balance'),
          Text(
            '\$12,345.67',
            style: Theme.of(context).textTheme.headline1,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Market Cap'),
                    Text('\$2.1T'),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: DominanceWidget(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
