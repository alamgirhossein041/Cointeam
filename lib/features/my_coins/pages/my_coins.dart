import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/number_formatter.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCoins extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlue,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: primaryBlue,
          appBar: AppBar(
            title: Text('My Coins'),
          ),
          body: Container(
            margin: mainCardMargin(),
            decoration: mainCardDecoration(),
            padding: scrollCardPadding(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Text(
                          "Price",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: primaryDark.withOpacity(0.7),
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          "Holdings",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: primaryDark.withOpacity(0.7),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MyCoinsList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCoinsList extends StatelessWidget {
  const MyCoinsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return Scrollbar(
      controller: _scrollController,
      thickness: 5,
      radius: Radius.circular(3),
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: BlocConsumer<StartupBloc, StartupState>(
                listener: (context, state) {
                  if (state is StartupErrorState) {
                    debugPrint("An error occured in my_coins.dart MyCoinsList");
                    log("An error occured in my_coins.dart MyCoinsList");
                  }
                },
                builder: (context, state) {
                  if (state is StartupLoadedState) {
                    return MyCoinsListView(
                        binanceGetAllModelList: state.binanceGetAllModel,
                        coingeckoModelMap: state.coingeckoModelMap);
                  } else if (state is StartupErrorState) {
                    return Text("Binance data error");
                  } else {
                    return loadingTemplateWidget();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCoinsListView extends StatelessWidget {
  const MyCoinsListView(
      {Key key, @required this.binanceGetAllModelList, this.coingeckoModelMap})
      : super(key: key);

  final List<BinanceGetAllModel> binanceGetAllModelList;
  final Map<String, dynamic> coingeckoModelMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context),
      width: displayWidth(context) * 0.95,
      child: ListView.builder(
        itemCount: binanceGetAllModelList.length,
        itemExtent: 80,
        itemBuilder: (context, index) {
          return MyCoinsCustomTile(
              binanceGetAllModel: binanceGetAllModelList[index],
              coingeckoModel:
                  coingeckoModelMap[binanceGetAllModelList[index].coin]);
        },
      ),
    );
  }
}

class MyCoinsCustomTile extends StatelessWidget {
  const MyCoinsCustomTile(
      {Key key, @required this.binanceGetAllModel, this.coingeckoModel})
      : super(key: key);

  final BinanceGetAllModel binanceGetAllModel;
  final CoingeckoListTop100Model coingeckoModel;

  @override
  Widget build(BuildContext context) {
    /// temp coin with dummy image when coingecko coin is null (i.e. not found when it was parsed alongside binance data)
    CoingeckoListTop100Model c;
    // coingeckoModel ?? log('null coingecko coin, binance coin name is = ' + binanceGetAllModel.name);
    // log('my_coins: coingecko model name = '+coingeckoModel.name);
    // log(binanceGetAllModel.name);
    // log(binanceGetAllModel.totalUsdValue.toString());
    // log(binanceGetAllModel.free.toString());
    // log(binanceGetAllModel.locked.toString());
    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: 20),

    // placeholder image if no coingecko image is found
    c = coingeckoModel ??
        CoingeckoListTop100Model(
            image:
                'https://pics.me.me/thumb_2-mario-bros-question-mark-box-coin-candies-display-sour-54064620.png');
    return Row(children: <Widget>[
      Flexible(
        flex: 2,
        fit: FlexFit.tight,
        child: coingeckoModel == null
            ? SvgPicture.asset(
                'graphics/assets/svg/missing_coin.svg',
                height: 40,
                width: 40,
              )
            : Image.network(
                coingeckoModel.image,
                height: 40,
                width: 40,
              ),

        // child: coingeckoModel ?? Text(':(')  Image.network(coingeckoModel.image),
      ),

      //   child: Image.network(
      //       "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880"),
      // ),
      SizedBox(width: 15),
      Flexible(
        flex: 4,
        fit: FlexFit.tight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // FittedBox(
            //   fit: BoxFit.fitWidth,
            //   child: Text(binanceGetAllModel.name),
            // ),
            Flexible(
              child: Text(
                binanceGetAllModel.name,
                overflow: TextOverflow.fade,
                softWrap: false,
                // maxLines: 1,
              ),
            ),
            // Just in case the coin symbol exceeds the unofficial 9 char limit
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(binanceGetAllModel.coin),
            ),
          ],
        ),
      ),
      Flexible(
        flex: 4,
        fit: FlexFit.tight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('\$${binanceGetAllModel.usdValue.toStringAsFixed(2)}'),
            Text('+9999.99%'), // TODO: fix this hard coded value
          ],
        ),
      ),
      Flexible(
        flex: 4,
        fit: FlexFit.tight,
        // child: RichText(
        //   textAlign: TextAlign.end,
        //   text: TextSpan(
        //       text: '\$${binanceGetAllModel.totalUsdValue.toStringAsFixed(2)}',
        //       style: TextStyle(color: Colors.black, height: 1.4),
        //       children: <TextSpan>[
        //         TextSpan(
        //             text:
        //                 (binanceGetAllModel.free + binanceGetAllModel.locked)
        //                     .toStringAsFixed(2),
        //             style: TextStyle(color: primaryDark.withOpacity(0.5)))
        //       ]),
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Text>[
            Text(
                '\$${(binanceGetAllModel.free + binanceGetAllModel.locked).toStringAsFixed(2)}'),
            // Text('\$${binanceGetAllModel.totalUsdValue.toStringAsFixed(2)}'),
            // Text('\$${double.parse((binanceGetAllModel.totalUsdValue.toStringAsFixed(2))).toString()}'),
            // Text('\$${numberFormatter(double.parse(((binanceGetAllModel.free + binanceGetAllModel.locked).toStringAsFixed(2))))}'),
            // Text('\$${numberFormatter(126.02)}'),
            Text('${numberFormatter(165.14)}'),
          ],
        ),
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
