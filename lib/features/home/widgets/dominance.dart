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
         children: [
           Text('Dominance'),
           Row(children: [
             Text('BTC: 64%%'),
             Text('ETH: 12%'),
           ],)
         ],
       ),
    );
  }
}