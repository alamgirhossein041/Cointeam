import 'dart:convert';
import 'dart:developer';

import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/cryptocompare/chart/chart_cryptocompare.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_chart_repo.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E2330),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: displayHeight(context) * 0.1),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: displayHeight(context) * 0.05,
                child: Container(
                  // height: displayHeight(context) * 0.4,
                  // width: displayWidth(context) * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment(0,-1),
                      end: Alignment(0, 1),
                      colors: [
                        Color(0xFFC21EDB),
                        Color(0xFF0575FF),
                        Color(0xFF0AE6FF),
                      ], stops: [
                        0.0,
                        0.63,
                        1.0
                      ],
                    )
                  ),
                ),
              ),
            ),
            ListTile(
              // contentPadding: EdgeInsets.fromLTRB(20,20,0,0),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'User Name Placeholderrrrrrrrrrr',
                  style: TextStyle(color: Colors.white, fontSize:16),
                ),
              ),
            ),
            DottedLine(dashLength: 2, dashColor: Color(0xFF526E8E)),
            SizedBox(height: displayHeight(context) * 0.025),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              /// title: Text('Portfolio 1 - Live'),
              title: Text(
                'Test Crypto Compare',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                CryptoCompareRepositoryImpl hello = CryptoCompareRepositoryImpl();
                hello.getHourlyCryptoCompare();
                // Navigator.pushReplacementNamed(context, '/first');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              /// title: Text('Portfolio 1 - Live'),
              title: Text(
                'Test Binance',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                BinanceGetChartRepositoryImpl helloBinance = BinanceGetChartRepositoryImpl();
                helloBinance.getBinanceChart('btc', '');
                // Navigator.pushReplacementNamed(context, '/first');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              /// title: Text('Portfolio 1 - Live'),
              title: Text(
                'Test CoinGecko',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                CoingeckoList250RepositoryImpl helloGecko = CoingeckoList250RepositoryImpl();
                helloGecko.getCoinMarketCapCoinLatest();
                // Navigator.pushReplacementNamed(context, '/first');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              /// title: Text('Portfolio 1 - Live'),
              title: Text(
                'Test CoinMarketCap',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                CardCoinmarketcapCoinLatestRepositoryImpl helloCmc = CardCoinmarketcapCoinLatestRepositoryImpl();
                helloCmc.getCoinMarketCapCoinLatest();
                // Navigator.pushReplacementNamed(context, '/first');
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                'Dashboard - No API',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/dashboardnoapitest');
              },
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
            //   title: Text(
            //     'Home - With API',
            //     style: TextStyle(color: Colors.white, fontSize:18),
            //   ),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/hometest');
            //   },
            // ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                'New Portfolio Screen',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },  
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Delete 1st Time Login API *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                final storage = FlutterSecureStorage();
                storage.delete(key: "api");
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Delete Trading API *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                final storage = FlutterSecureStorage();
                storage.delete(key: "trading");
                
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Clear Local Storage *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                final storage = LocalStorage("coinstreetapp");
                storage.clear();
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Log Local Storage *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                final storage = LocalStorage("coinstreetapp");
                log(storage.getItem("prime").toString());
                // json.decode(storage.getItem("prime")).forEach((k,v) {
                //   log(k.toString());
                //   log(v.toString());
                // });
                // log(storage.getItem("prime").symbol.toString());
                /// 19th oh mfer the key value store can't just be called as 
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Sell Portfolio Screen *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/sellportfolio');
              },
            ),
            SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(30,10,0,0),
              title: Text(
                '* Reset Application & State *',
                style: TextStyle(color: Colors.white, fontSize:18),
              ),
              onTap: () {
                // Navigator.pushNamed(context, '/hometest');
                Phoenix.rebirth(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}