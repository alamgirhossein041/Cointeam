import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_bloc.dart';
import 'package:coinsnap/data/respository/unauth/prices/binance_get_prices.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/test/testjson/test_crypto_json.dart';
import 'package:coinsnap/ui/pages/coin_view/coin_view.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typicons_flutter/typicons.dart';

import 'dart:developer';

class PortfolioListTile extends StatelessWidget {
  PortfolioListTile(this.cryptoData, this.index);

  final dynamic cryptoData;
  final dynamic index;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      // child: Container(
        // width: displayWidth(context) * 0.75,
        child: Row(
          children: <Widget> [
            Test(cryptoData, index),
          ]
        ),
      // ),
    );
  }
}

// class CryptoData {
//   final dynamic cryptoData;
//   final dynamic index;

//   CryptoData(this.cryptoData, this.index);
// }

class Test extends StatelessWidget {
  Test(this.cryptoData, this.index);

  final dynamic cryptoData;
  final dynamic index;
  

  @override
  Widget build(BuildContext context) {
    // GetPriceInfoBloc getPriceInfoBloc = BlocProvider.of<GetPriceInfoBloc>(context);
    // return BlocProvider<GetPriceInfoBloc>(
    //   create: (BuildContext context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
    //   child: Container(
        return Container(
          child: GestureDetector(
          onTap: () {
            log("cryptoData: " + cryptoData.toString());
            log("index: " + index.toString());
            // final Test test1 = Test(cryptoData, index);
            // Navigator.pushNamed(context, '/coinview');
            Navigator.pushNamed(
              context,
              '/coinview',
              arguments: {'cryptoData' : cryptoData, 'index' : index},

              // MaterialPageRoute(
              //   builder: (context) => BlocProvider.value(
              //     value: BlocProvider.of<GetPriceInfoBloc>(context),
              //     child: CoinView(),
              //   ),
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => CoinView(),
            //     // Pass the arguments as part of the RouteSettings. The
            //     // DetailScreen reads the arguments from these settings.
            //     settings: RouteSettings(
            //       arguments: {'cryptoData' : cryptoData, 'index' : index}
            //     ),
            //   ),
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10,10,10,0),
            height: displayWidth(context) * 0.5,
            // width: double.maxFinite,
            width: displayWidth(context),
            child: Card(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                    ),
                      // width: 2.0, color: cryptoData[index]['iconColor']),
                  ),
                  color: tilePurple,
                ),
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      cryptoIcon(cryptoData[index]),
                                      // SizedBox(height: displayHeight(context) * 0.05),
                                      cryptoNameSymbol(cryptoData[index]),
                                      Spacer(),
                                      cryptoChange(cryptoData[index]),
                                      // SizedBox(width: displayWidth(context) * 0.1),
                                      changeIcon(cryptoData[index]),
                                      // SizedBox(width: displayWidth(context) * 0.2),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget> [
                                      cryptoAmount(cryptoData[index]),
                                    ]
                                  ),
                                ]
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
        ),
      // ),
    );
  }

  Widget cryptoIcon(data) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Icon(
          data['icon'],
          color: data['iconColor'],
          size: 40,
        ),
      ),
    );
  }

  Widget cryptoNameSymbol(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: "${data['name']}",
          style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20
          ),
          children: <TextSpan>[
            TextSpan(
              text: "\n${data['symbol']}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cryptoChange(data) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: "${data['change']}",
          style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20
          ),
          children: <TextSpan>[
            TextSpan(
              text: "\n+${data['changeValue']}",
              style: TextStyle(
                color: data['changeColor'],
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget changeIcon(data) {
    return Align(
      alignment: Alignment.topRight,
      child: data['change'].contains('-')
      ? Icon(
        Typicons.arrow_sorted_up,
        color: data['changeColor'],
        size: 30,
      ) : Icon(
        Typicons.arrow_sorted_down,
        color: data['changeColor'],
      ),
    );
  }

  Widget cryptoAmount(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: "\n${data['value']}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "\n0.1349",
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}