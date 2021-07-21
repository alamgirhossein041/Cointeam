import 'dart:developer';

import 'package:coinsnap/features/data/coingecko_image/repos/coingecko_coin_info_repo.dart';
import 'package:coinsnap/features/data/coingecko_image/repos/coingecko_coin_repo.dart';
import 'package:coinsnap/features/settings/widgets/settings_currency_toggle.dart';
import 'package:coinsnap/features/settings/widgets/settings_section.dart';
import 'package:coinsnap/features/settings/widgets/settings_theme_toggle.dart';
import 'package:coinsnap/features/settings/widgets/settings_tile.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/dummy_data.dart';
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
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          backgroundColor: primaryBlue,
          body: Stack(
            children: <Widget>[
              TitleBar(title: "Buy from Snapshot"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPadding(),
                // width: displayWidth(context),
                child: SettingsWidget(),
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
            ],
          ),
        ),
      ),
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

class SettingsWidget extends StatelessWidget {
  SettingsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: <Widget>[
      SettingsSection(title: "API Link", items: <Widget>[
        SettingsTile(
            text: 'Link Binance API', onClick: () => _loadDevToolApi(true)),
        SettingsTile(
            text: 'Link FTX API', onClick: () => _loadDevToolApi(false))
      ]),
      SettingsSection(title: "General", items: <Widget>[
        // for now the app will toggle between USD and AUD
        SettingsCurrencyToggle()
      ]),
      SettingsSection(title: "System", items: <Widget>[
        SettingsThemeToggle()

        /// TODO 16th July: STUFF
        /// Theme (toggle)
        /// Bug Report (non-functional... i guess we could add an api)
        /// Feedback (same shit)
      ]),
      SettingsSection(title: "DEVTOOLS", items: <Widget>[
        /// TODO 16th July: STUFF
        /// Load API
        /// Unload API
        /// Load Dummy Data
        /// Unload Dummy Data
        /// Parse Raw Binance API response and load into localstorage
        SettingsTile(
          text: 'Parse Binance sold dummy data into Snapshot data',
          onClick: () => _parseBinanceSoldDummyData(),
        ),
        SettingsTile(
          text: 'Call Coingecko API for all coins and save to localstorage',
          onClick: () async {
            bool i = await _getAllCoins();
            i
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text(
                          'Got all coins from coingecko and saved to localstorage.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Nice'),
                          onPressed: () => Navigator.pop(context, 'OK'),
                        )
                      ],
                    ),
                  )
                : showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Failed'),
                      content: const Text('Something went wrong lmao'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK THEN'),
                          onPressed: () => Navigator.pop(context, 'OK'),
                        )
                      ],
                    ),
                  );
          },
        ),
        SettingsTile(
          text: 'Parse Coingecko coins and store to localstorage',
          onClick: () => _parseCoingeckoCoins(),
        ),
        SettingsTile(
          text: 'Call coingecko market repo',
          onClick: () => _coingeckoMarketCoins(),
        ),
      ])
    ]));
  }

  /// This function loads in the Dev's API key in.
  /// The function will delete the existing API key if bool save is not true.
  void _loadDevToolApi(bool save) async {
    if (save) {
      final secureStorage = FlutterSecureStorage();
      String api = await secureStorage.read(key: "binanceApi");
      if (api != null) {
        debugPrint("There is already an API Key saved!");
        log("There is already an API Key saved!");
      } else {
        debugPrint("No Binance API Detected... Adding...");
        log("No Binance API Detected... Adding...");
        secureStorage.write(
            key: "binanceApi",
            value:
                "tKmm9Fyu2xPqNrfXFBnQ1UVaUduffkvLqMKH5wJD64JDO3kjRyqqqHOrTDRp1D6m");
        secureStorage.write(
            key: "binanceSapi",
            value:
                "OHEjGXTHu0gOIpmkUOHiVBkNBq8jshmikXD3UMmSd7EkjS6898SlViv5A0LW1T4f");
        return null;
      }
    } else {
      final secureStorage = FlutterSecureStorage();
      String api = await secureStorage.read(key: "binanceApi");
      if (api == null) {
        log("There is no API key.");
      } else {
        secureStorage.delete(key: "binanceApi");
        secureStorage.delete(key: "binanceSapi");
        log("API key deleted.");
      }
    }
  }
}

_coingeckoMarketCoins() {
  CoingeckoCoinInfoRepoImpl coinRepo = CoingeckoCoinInfoRepoImpl();
  coinRepo.getCoinInfo(['bitcoin','ethereum','ripple'], 1);
}

/// Gets all Coingecko coins
_getAllCoins() async {
  // Call api using CoingeckoCoinRepo
  CoingeckoCoinRepoImpl coinRepo = CoingeckoCoinRepoImpl();
  bool flag = await coinRepo.getCoins();
  return flag;
}

/// Parse the full list of coins from Coingecko into our own map
/// with coin symbol as key, and other values as properties.
/// Then it saves it into localstorage.
void _parseCoingeckoCoins() async {
  // assume we have the api response saved to localstorage
  // get it from localstorage
  LocalStorage localStorage = LocalStorage('coinstreetapp');
  await localStorage.ready.then((_) {
    List<dynamic> coingeckoCoins = localStorage.getItem('coingeckoCoins');

    // parse each element into our own map of coingecko coins
    Map<String, Map> parsedCoingeckoCoins = Map.fromIterable(coingeckoCoins,
        key: (item) => item['symbol'].toString(), value: (item) => item);

    // save into localstorage
    localStorage.setItem('parsedCoingeckoCoins', parsedCoingeckoCoins);
  });
}

/// Fetches pre-saved Binance snapshot sell data into our own snapshot data structure.
/// The pre-saved data contains ONE sold snapshot record, with multiple coins.
_parseBinanceSoldDummyData() {
  // get the list of sold binance coins from dummy data file
  List<dynamic> binanceSoldCoins = rawBinanceSoldResp;
  // parse it into our custom coin data structure
  Map parsedCoins = {};
  // total value of this sale
  double totalValue = 0.0;
  binanceSoldCoins.forEach((v) {
    // add sold coin value into total value
    totalValue += v['cummulativeQuoteQty'];

    // each coin has fields: quantity, value.
    // ***IMPORTANT***
    // Special case regarding BTC <-> USDT:
    // When trading BTC and USDT together,
    // whether you're selling BTC into USDT, or selling USDT into BTC,
    // it's always gonna be BTCUSDT, and never the other way around(i.e. never USDTBTC).
    // Normally:
    // executedQty = number of assets sold,
    // cummulativeQuoteQty = the total value of those assets in a currency.
    // However, in the special case of BTC <-> USDT, always being BTCUSDT,
    // Example:
    // User tries to sell 1.5 BTC into $20 USDT:
    // Order for 1.5 BTC -> $20.00 on trading pair BTCUSDT
    // executedQty(number of assets) = 1.5 (BTC)
    // cummulativeQuoteQty(total value of this asset in the incoming currency) = $20.00 USDT
    //
    // User tries to sell $20.50 USDT into 5.7 BTC:
    // Order for 5.7 BTC -> $20.50 USDT on trading pair BTCUSDT
    // executedQty(number of assets) = $20.50 (USDT)
    // cummulativeQuoteQty(total value of this asset in the incoming currency) = 5.7 BTC
    // But since USDTBTC does not exist, and it has to be BTCUSD, these two fields must be switched around:
    // executedQty(number of assets) = 5.7 BTC
    // cummulativeQuoteQty(total value of this asset in the incoming currency) = $20.50 (USDT)
    //
    // In summary, if the user is selling BTC for USDT, everything is fine, but,
    // if the user is selling USDT for BTC, the executedQty and cummulativeQuoteQty must be switched around,
    // because Binance automatically "fixes" the lack of USDTBTC by switching it around.
    //
    // For now, there's no need to switch these around here, since
    // each record in binanceSoldCoins is just a log of the sell transaction on trading pair,
    // and we can safely assume that it's been correctly switched around before it got saved at this point.

    // Map of coin's properties containing its quantity and value
    Map<String, double> coinProperties = {};
    coinProperties["quantity"] = v['executedQty'];
    coinProperties["value"] = v['cummulativeQuoteQty'];

    // create coin key basd on trading pair
    String coinName = v['symbol'].toString().replaceAll(RegExp(r'USDT$'), '');

    // append to list of parsed coins with coin symbol as key
    parsedCoins[coinName] = coinProperties;
  });

  // add the list of parsed coins into our snapshot data structure.
  Map<String, dynamic> snapshot = {};
  snapshot["coins"] = parsedCoins;

  // the currency it was sold into
  // hardcoded for now, as the dummy data sold it into USDT.
  snapshot["currency"] = "USDT";

  // add total sold value into snapshot
  snapshot["total"] = totalValue;

  // add current time as the snapshot's timestamp
  snapshot["timestamp"] = DateTime.now().millisecondsSinceEpoch;

  // save to local storage
  // final LocalStorage localStorage = LocalStorage("coinstreetapp");
  // localStorage.setItem("parsedBinanceData", snapshot);
}
