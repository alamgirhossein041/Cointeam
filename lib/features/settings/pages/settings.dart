import 'dart:developer';

import 'package:coinsnap/features/settings/widgets/settings_tile.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Settings")
          ),
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget> [
              TitleBar(title: "Buy from Snapshot"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPadding(),
                width: displayWidth(context),
                child: NEWWIDGET();
                // child: Column(
                //   children: <Widget> [
                //     SizedBox(height: 50),
                //     Flexible(
                //       flex: 1,
                //       fit: FlexFit.tight,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget> [
                //           Text("API Link"),
                //           SettingsTile(tileText: "Link Binance API"),
                //           SettingsTile(tileText: "Link FTX API (coming soon"),
                //           SettingsTile(tileText: "Link Coinbase API (coming soon"),
                //           SizedBox(height: 10),
                //           SettingsTile(tileText: "DEVTOOL: Load in Andrew's API", onClick: () async {
                //             final secureStorage = FlutterSecureStorage();
                //             String api = await secureStorage.read(key: "binanceApi");
                //             if(api != null) {
                //               debugPrint("There is already an API Key saved!");
                //               log("There is already an API Key saved!");
                //             } else {
                //               debugPrint("No Binance API Detected... Adding...");
                //               log("No Binance API Detected... Adding...");
                //               secureStorage.write(key: "binanceApi", value: "tKmm9Fyu2xPqNrfXFBnQ1UVaUduffkvLqMKH5wJD64JDO3kjRyqqqHOrTDRp1D6m");
                //               secureStorage.write(key: "binanceSapi", value: "OHEjGXTHu0gOIpmkUOHiVBkNBq8jshmikXD3UMmSd7EkjS6898SlViv5A0LW1T4f");
                //               return null;
                //             }
                //           }),
                //           SettingsTile(tileText: "DEVTOOL: Remove existing API", onClick: () async {
                //             final secureStorage = FlutterSecureStorage();
                //             String api = await secureStorage.read(key: "binanceApi");
                //             if(api == null) {
                //               log("There is no API key.");
                //             } else {
                //               secureStorage.delete(key: "binanceApi");
                //               secureStorage.delete(key: "binanceSapi");
                //               log("API key deleted.");
                //             }
                //           }),
                //           SettingsTile(tileText: "DEVTOOL: Remove all local snapshots", onClick: () async {
                //             final localStorage = LocalStorage("coinstreetapp");
                //             await localStorage.deleteItem("portfolio");
                //             log("Should be deleted");
                            
                //             // String api = await secureStorage.read(key: "binanceApi");
                //             // if(api == null) {
                //             //   log("There is no API key.");
                //             // } else {
                //             //   secureStorage.delete(key: "binanceApi");
                //             //   secureStorage.delete(key: "binanceSapi");
                //             //   log("API key deleted.");
                //             // }

                //           })
                //         ]
                //       )
                //     ),
                //     SizedBox(height: 50),
                //     Flexible(
                //       flex: 1,
                //       fit: FlexFit.tight,
                //       child: Column(
                //         // crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget> [
                //           Text("General"),
                //           SettingsTileToggle(tileText: "Currency") /// TODO: parameters - text and toggled-value
                //       // child: Column(
                //       //   crossAxisAlignment: CrossAxisAlignment.start,
                //       //   children: <Widget> [
                //       //     GestureDetector(
                //       //       child: Row(
                //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       //         children: <Widget> [
                //       //           Text("Currency"),
                //       //           Text("USD")
                //       //         ]
                //       //       )
                //       //     )
                //       //   ]
                //       // )
                //         ]
                //       )
                //     ),
                //     SizedBox(height: 50),
                //     Flexible(
                //       flex: 1,
                //       fit: FlexFit.tight,
                //       child: Text("System"),
                //     ),
                //   ],
                // ),
              ),
            ]
          )
        )
      )
    );
  }
}


class OLDTEMPWIDGET extends StatelessWidget {
  const OLDTEMPWIDGET({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              SettingsTile(tileText: "DEVTOOL: Load in Andrew's API", onClick: loadDevToolApi(true)),
                
              SettingsTile(tileText: "DEVTOOL: Remove existing API", onClick: loadDevToolApi(false)),
              SettingsTile(tileText: "DEVTOOL: Remove all local snapshots", onClick: () async {
                final localStorage = LocalStorage("coinstreetapp");
                await localStorage.deleteItem("portfolio");
                log("Should be deleted");
                
                // String api = await secureStorage.read(key: "binanceApi");
                // if(api == null) {
                //   log("There is no API key.");
                // } else {
                //   secureStorage.delete(key: "binanceApi");
                //   secureStorage.delete(key: "binanceSapi");
                //   log("API key deleted.");
                // }

              })
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
    );
  }
}


class NEWWIDGET extends StatelessWidget {
  const NEWWIDGET({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget> [
          SettingsSectionWidget(
            title: "API Link",
            items: <Widget> [
              SettingsTile(text: 'Link Binance API', onClick: loadDevToolApi(true)),
              SettingsTile(text: 'Link FTX API', onClick: loadDevToolApi(false))
            ]
          ),
          SettingsSectionWidget(title: "General", items: [SettingsTile])
        ]
      )
    );
  }

  /// This function loads in the Dev's API key in.
  /// The function will delete the existing API key if bool save is not true.
  loadDevToolApi(bool save) async {
    if(save) {
      final secureStorage = FlutterSecureStorage();
      String api = await secureStorage.read(key: "binanceApi");
      if(api != null) {
        debugPrint("There is already an API Key saved!");
        log("There is already an API Key saved!");
      } else {
        debugPrint("No Binance API Detected... Adding...");
        log("No Binance API Detected... Adding...");
        secureStorage.write(key: "binanceApi", value: "tKmm9Fyu2xPqNrfXFBnQ1UVaUduffkvLqMKH5wJD64JDO3kjRyqqqHOrTDRp1D6m");
        secureStorage.write(key: "binanceSapi", value: "OHEjGXTHu0gOIpmkUOHiVBkNBq8jshmikXD3UMmSd7EkjS6898SlViv5A0LW1T4f");
        return null;
      }
    } else {
      final secureStorage = FlutterSecureStorage();
      String api = await secureStorage.read(key: "binanceApi");
      if(api == null) {
        log("There is no API key.");
      } else {
        secureStorage.delete(key: "binanceApi");
        secureStorage.delete(key: "binanceSapi");
        log("API key deleted.");
      }
    }
  }
}

class SettingsSectionWidget extends StatelessWidget {
  final String title;
  final items;
  
  SettingsSectionWidget({
    Key key,
    @required this.title,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
    );
  }
}