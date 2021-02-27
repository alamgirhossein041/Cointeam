import 'package:coinsnap/v1/data/model/internal/coin_data/card/derivative/card_crypto_data.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typicons_flutter/typicons.dart';

import 'dart:developer';

class PortfolioListTile extends StatefulWidget {
  PortfolioListTile({Key key, this.coinListMap, this.index}) : super(key: key);
  final CoinMarketCapCoinLatestModel coinListMap;
  final dynamic index;

  // PortfolioListTile(this.cryptoData, this.index);
  @override
  PortfolioListTileState createState() => PortfolioListTileState();
}

class PortfolioListTileState extends State<PortfolioListTile> {
  @override
  void initState() { 
    super.initState(); 
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }




  @override
  Widget build(BuildContext context) {

    return InkWell(
      // child: Container(
        // width: displayWidth(context) * 0.75,
      child: Container(
        child: Row(
          children: <Widget> [
            Test(widget.coinListMap, widget.index),
          ]
        ),
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
  Test(this.coinListMap, this.index);

  final CoinMarketCapCoinLatestModel coinListMap;
  final dynamic index;

  @override
  Widget build(BuildContext context) {
    // GetPriceInfoBloc getPriceInfoBloc = BlocProvider.of<GetPriceInfoBloc>(context);
    // return BlocProvider<GetPriceInfoBloc>(
    //   create: (BuildContext context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
    //   child: Container(
        return Container(
          decoration: BoxDecoration(
            color: appBlack,
          ),
          child: GestureDetector(
          onTap: () {
            log("cryptoData: " + coinListMap.toString());
            log("index: " + index.toString());
            // final Test test1 = Test(cryptoData, index);
            // Navigator.pushNamed(context, '/coinview');
            Navigator.pushNamed(
              context,
              '/coinview',
              arguments: {'cryptoData' : coinListMap.data, 'index' : index},

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
            padding: EdgeInsets.fromLTRB(10,0,10,0),
            height: displayWidth(context) * 0.35,
            // width: double.maxFinite,
            width: displayWidth(context),
            child: Card(
              // elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  // border: Border(
                  //   top: BorderSide(
                  //   ),
                  //     // width: 2.0, color: cryptoData[index]['iconColor']),
                  // ),
                  color: tilePurple,
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
                                      cryptoIcon(coinListMap.data[index]),
                                      // SizedBox(height: displayHeight(context) * 0.05),
                                      cryptoNameSymbol(coinListMap.data[index]),
                                      Spacer(),
                                      cryptoChange(coinListMap.data[index]),
                                      // SizedBox(width: displayWidth(context) * 0.1),
                                      changeIcon(coinListMap.data[index]),
                                      // SizedBox(width: displayWidth(context) * 0.2),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget> [
                                      cryptoAmount(coinListMap.data[index]),
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
              // ),
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
        // child: Icon(
        //   // CryptoFontIcons.BTC,
        //   // color: data['iconColor'],
        //   size: 30,
        // ),
      ),
    );
  }

  Widget cryptoNameSymbol(data) {
    log(data.toString());
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: "${data.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16
          ),
          // children: <TextSpan>[
          //   TextSpan(
          //     text: "\n${data['symbol']}",
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }

  Widget cryptoChange(data) {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: "${data.quote.uSD.percentChange24h.toStringAsFixed(2)}%",
          style: TextStyle(
            fontWeight: FontWeight.bold, color: data.quote.uSD.changeColor, fontSize: 14
          ),
          // children: <TextSpan>[
          //   TextSpan(
          //     text: "\n+${data['changeValue']}",
          //     style: TextStyle(
          //       color: data['changeColor'],
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }


  Widget changeIcon(data) {
    return Align(
      alignment: Alignment.topRight,
      child: data.quote.uSD.percentChange24h < 0
      ? Icon(
        Typicons.arrow_sorted_down,
        color: data.quote.uSD.changeColor,
        size: 16,
      ) : Icon(
        Typicons.arrow_sorted_up,
        color: data.quote.uSD.changeColor,
        size: 16,
      ),
    );
  }

  Widget cryptoAmount(data) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                // text: "\n0.00451349",
                // text: "\n${data.quote.uSD.price}",
                style: TextStyle(
                  // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: textGrey,
                  fontSize: 16,
                ),
                
                children: <TextSpan>[
                  TextSpan(
                    // text: "\n0.1349",
                    text: "\n\$${data.quote.uSD.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: textGrey,
                      // fontStyle: FontStyle.italic,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold
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