import 'package:flutter/material.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';


class PortfolioBuilderSelect extends StatefulWidget {
  PortfolioBuilderSelect({Key key}) : super(key: key);

  @override
  _PortfolioBuilderSelectState createState() => _PortfolioBuilderSelectState();
}

class _PortfolioBuilderSelectState extends State<PortfolioBuilderSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bgGrad1, bgGrad2],
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Build new Portfolio'),
        ),
        body: Center(
          child: Text('asdfasf'),
        ),
      ),
    );
  }
}