import 'dart:developer';

import 'package:coinsnap/features/settings/widgets/settings_section.dart';
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
                child: NEWWIDGET(),
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
                //           SettingsTile(text: "Link Binance API"),
                //           SettingsTile(text: "Link FTX API (coming soon"),
                //           SettingsTile(text: "Link Coinbase API (coming soon"),
                //           SizedBox(height: 10),
                //           SettingsTile(text: "DEVTOOL: Load in Andrew's API", onClick: () async {
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
                //           SettingsTile(text: "DEVTOOL: Remove existing API", onClick: () async {
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
                //           SettingsTile(text: "DEVTOOL: Remove all local snapshots", onClick: () async {
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
                //           SettingsTileToggle(text: "Currency") /// TODO: parameters - text and toggled-value
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


// class OLDTEMPWIDGET extends StatelessWidget {
//   const OLDTEMPWIDGET({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget> [
//         SizedBox(height: 50),
//         Flexible(
//           flex: 1,
//           fit: FlexFit.tight,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget> [
//               Text("API Link"),
//               SettingsTile(text: "Link Binance API"),
//               SettingsTile(text: "Link FTX API (coming soon"),
//               SettingsTile(text: "Link Coinbase API (coming soon"),
//               SizedBox(height: 10),
//               // SettingsTile(text: "DEVTOOL: Load in Andrew's API", onClick: loadDevToolApi(true)),
                
//               // SettingsTile(text: "DEVTOOL: Remove existing API", onClick: loadDevToolApi(false)),
//               SettingsTile(text: "DEVTOOL: Remove all local snapshots", onClick: () async {
//                 final localStorage = LocalStorage("coinstreetapp");
//                 await localStorage.deleteItem("portfolio");
//                 log("Should be deleted");
                
//                 // String api = await secureStorage.read(key: "binanceApi");
//                 // if(api == null) {
//                 //   log("There is no API key.");
//                 // } else {
//                 //   secureStorage.delete(key: "binanceApi");
//                 //   secureStorage.delete(key: "binanceSapi");
//                 //   log("API key deleted.");
//                 // }

//               })
//             ]
//           )
//         ),
//         SizedBox(height: 50),
//         Flexible(
//           flex: 1,
//           fit: FlexFit.tight,
//           child: Column(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget> [
//               Text("General"),
//               // SettingsTileToggle(tile: "Currency") /// TODO: parameters - text and toggled-value
//           // child: Column(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: <Widget> [
//           //     GestureDetector(
//           //       child: Row(
//           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //         children: <Widget> [
//           //           Text("Currency"),
//           //           Text("USD")
//           //         ]
//           //       )
//           //     )
//           //   ]
//           // )
//             ]
//           )
//         ),
//         SizedBox(height: 50),
//         Flexible(
//           flex: 1,
//           fit: FlexFit.tight,
//           child: Text("System"),
//         ),
//       ],
//     );
//   }
// }


class NEWWIDGET extends StatelessWidget {
  NEWWIDGET({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget> [
          SettingsSection(
            title: "API Link",
            items: <Widget> [
              SettingsTile(text: 'Link Binance API', onClick: () => _loadDevToolApi(true)),
              SettingsTile(text: 'Link FTX API', onClick: () => _loadDevToolApi(false))
              
            ]
          ),
          SettingsSection(
            title: "General",
            items: <Widget> [
              // for now the app will toggle between USD and AUD
              SettingsTileCurrency(text: 'Currency')
            ])
        ]
      )
    );
  }

  /// This function loads in the Dev's API key in.
  /// The function will delete the existing API key if bool save is not true.
  void _loadDevToolApi(bool save) async {
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