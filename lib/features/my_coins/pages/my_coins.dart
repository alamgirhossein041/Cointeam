import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCoins extends StatelessWidget {

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
              TitleBar(title: "My Coins"),
              Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                // padding: mainCardPadding(),
                padding: EdgeInsets.fromLTRB(20,45,40,45),
                width: displayWidth(context),
                child: Column(
                  children: <Widget> [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget> [
                          Flexible(
                            flex: 10,
                            fit: FlexFit.tight,
                            child: SizedBox(),
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Text("Price")
                          ),
                          Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("Holdings"),
                            ),
                          ),
                        ]
                      )
                    ),
                    Flexible(
                      flex: 10,
                      fit: FlexFit.tight,
                      child: MyCoinsList(),
                    ),
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}

class MyCoinsList extends StatelessWidget {
  const MyCoinsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: BlocConsumer<StartupBloc, StartupState> (
            listener: (context, state) {
              if (state is StartupErrorState) {
                debugPrint("An error occured in my_coins.dart MyCoinsList");
                log("An error occured in my_coins.dart MyCoinsList");
              }
            },
            builder: (context, state) {
              if (state is StartupLoadedState) {
                return MyCoinsListView(binanceGetAllModelList: state.binanceGetAllModel);
              } else if (state is StartupErrorState) {
                return Text("Binance data error");
              } else {
                return loadingTemplateWidget();
              }
            }
          )
        )
      ]
    );
  }
}

class MyCoinsListView extends StatelessWidget {
  const MyCoinsListView({
    Key key,
    @required this.binanceGetAllModelList
  }) : super(key: key);

  final List<BinanceGetAllModel> binanceGetAllModelList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context),
      width: displayWidth(context) * 0.95,
      child: ListView.builder(
        itemCount: binanceGetAllModelList.length,
        itemExtent: 80,
        itemBuilder: (context, index) {
          return MyCoinsCustomTile(binanceGetAllModel: binanceGetAllModelList[index]);
        }
      )
    );
  }
}

class MyCoinsCustomTile extends StatelessWidget {
  const MyCoinsCustomTile({
    Key key,
    @required this.binanceGetAllModel
  }) : super(key: key);

  final BinanceGetAllModel binanceGetAllModel;

  @override
  Widget build(BuildContext context) {
    log(binanceGetAllModel.coin);
    log(binanceGetAllModel.name);
    log(binanceGetAllModel.totalUsdValue.toString());
    log(binanceGetAllModel.free.toString());
    log(binanceGetAllModel.locked.toString());
    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: 20),
      return Row(
        children: <Widget> [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Image.network("https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880"),
          ),
          SizedBox(width: 15),
          // Flexible(
          //   flex: 2,
          //   fit: FlexFit.tight,
          //   child: Column(
          //     children: <Widget> [
          //       Text(binanceGetAllModel.name, style: TextStyle(color: primaryDark)),
          //       // SizedBox(height: 2),
          //       Text(binanceGetAllModel.coin, style: TextStyle(color: primaryDarkHalf))
          //     ]
          //   )
          // ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: RichText(
              text: TextSpan(
                text: binanceGetAllModel.name + '\n',
                style: TextStyle(color: primaryDark, height: 1.4),
                children: <TextSpan> [
                  TextSpan(
                    text: binanceGetAllModel.coin,
                    style: TextStyle(color: primaryDarkHalf)
                  )
                ]
              )
            )
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                text: '\$' + binanceGetAllModel.usdValue.toStringAsFixed(2) + '\n',
                style: TextStyle(color: Colors.black, height: 1.4),
                children: <TextSpan> [
                  TextSpan(
                    text: "+2.19%", style: TextStyle(color: Colors.pinkAccent[200]),
                  )
                ]
              ),
            )
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                text: '\$' + binanceGetAllModel.totalUsdValue.toStringAsFixed(2) + '\n',
                style: TextStyle(color: Colors.black, height: 1.4),
                children: <TextSpan> [
                  TextSpan(
                    text: (binanceGetAllModel.free + binanceGetAllModel.locked).toStringAsFixed(2),
                    style: TextStyle(color: primaryDarkHalf)
                  )
                ]
              ),
            )
          ),
        ]
      // ),
    );
  }
}

// class BinanceCoinNullCheck extends StatelessWidget {
//   const BinanceCoinNullCheck({
//     Key key,

//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if()
//     return Container(
//       child: child,
//     );
//   }
// }