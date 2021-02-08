import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/test/testjson/test_crypto_json.dart';
import 'package:coinsnap/ui/template/small/card/portfolio_list_tile.dart';
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