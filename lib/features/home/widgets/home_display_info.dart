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
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text('Balance'),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    '\$12,345.67',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text('Total Market Cap'),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          '\$2.1T',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: DominanceWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
