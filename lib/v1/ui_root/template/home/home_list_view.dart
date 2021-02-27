// import 'package:coinsnap/ui_root/template/small/card/.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';

class HomeListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column (
        children: <Widget> [
          Container(
            child: SizedBox(
              height: displayHeight(context) * 0.35,
              width: displayWidth(context),
              // child: ListView.builder(
              //   itemCount: cryptoData.length,
              //   itemBuilder: (context, index) {
              //     return PortfolioListTile(cryptoData, index);
              //   }
              // ),
            ),
          ),
        ]
      ),
      // child: PortfolioListTile(cryptoData),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
    );
  }
}