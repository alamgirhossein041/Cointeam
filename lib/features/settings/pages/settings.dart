import 'package:coinsnap/features/settings/widgets/settings_tile.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Buy from Snapshot"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPaddingVertical(),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    SizedBox(height: 50),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Text("API Link"),
                          SettingsTile(tileText: "Link Binance API"),
                          SettingsTile(tileText: "Link FTX API (coming soon"),
                          SettingsTile(tileText: "Link Coinbase API (coming soon"),
                          SizedBox(height: 10),
                          SettingsTile(tileText: "DEVTOOL: Load in Andrew's API")
                        ]
                      )
                    ),
                    SizedBox(height: 50),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Text("General"),
                          SettingsTileToggle(tileText: "Currency") /// TODO: parameters - text and toggled-value
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget> [
                      //     GestureDetector(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: <Widget> [
                      //           Text("Currency"),
                      //           Text("USD")
                      //         ]
                      //       )
                      //     )
                      //   ]
                      // )
                        ]
                      )
                    ),
                    SizedBox(height: 50),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text("System"),
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }
}