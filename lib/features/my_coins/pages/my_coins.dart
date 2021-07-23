import 'dart:developer';

import 'package:coinsnap/features/data/binance_price/models/binance_get_portfolio.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:coinsnap/features/widget_templates/title_bar.dart';
import 'package:coinsnap/ui_components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  const MyCoinsListView({
    Key key,
    @required this.binanceGetAllModelList,
    @required this.coingeckoModelMap
  }) : super(key: key);

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
              coingeckoModel: coingeckoModelMap[binanceGetAllModelList[index].coin]);
        },
      ),
    );
  }
}

class MyCoinsCustomTile extends StatefulWidget {
  const MyCoinsCustomTile({
    Key key,
    @required this.binanceGetAllModel,
    @required this.coingeckoModel
  }) : super(key: key);

  final BinanceGetAllModel binanceGetAllModel;
  final CoingeckoListTop100Model coingeckoModel;

  @override
  _MyCoinsCustomTileState createState() => _MyCoinsCustomTileState();
}

class _MyCoinsCustomTileState extends State<MyCoinsCustomTile> {
  CoingeckoListTop100Model dummyCoingeckoModel;

  @override
  void initState() { 
    super.initState();
    if(widget.coingeckoModel == null) {
      dummyCoingeckoModel = CoingeckoListTop100Model(
        image: "https://assets.coingecko.com/coins/images/17030/small/binance-coin-bnb-logo.png",
        name: widget.binanceGetAllModel.name,
        symbol: widget.binanceGetAllModel.coin,
      );
    } else {
      dummyCoingeckoModel = widget.coingeckoModel;
    }
  }
  @override
  Widget build(BuildContext context) {
    // log(widget.coingeckoModel.toString());
    // log(widget.coingeckoModel.image);
    // log(binanceGetAllModel.coin);
    // log(binanceGetAllModel.name);
    // log(binanceGetAllModel.totalUsdValue.toString());
    // log(binanceGetAllModel.free.toString());
    // log(binanceGetAllModel.locked.toString());
    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: 20),
    return Row(
      children: <Widget>[
      Flexible(
        flex: 2,
        fit: FlexFit.tight,
        child: Image.network(
            // "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880"),
            // sadly the below nullable line doesn't work (it still compiles, just doesn't do what i want)
            // possible solution is to set a model for coins that exist in portfolio but are not on coingecko
            // like a dummy model - stuff like ETHUP
            // coingeckoModel.image ?? "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880")
            dummyCoingeckoModel.image)
      ),
      SizedBox(width: 15),
      Flexible(
        flex: 4,
        fit: FlexFit.tight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dummyCoingeckoModel.name),
            Text(dummyCoingeckoModel.symbol),
          ],
        ),
      ),
      Flexible(
        flex: 4,
        fit: FlexFit.tight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('\$${widget.binanceGetAllModel.usdValue.toStringAsFixed(2)}'),
            Text('+9999.99%'), // TODO: fix this hard coded value
          ],
        ),
      ),
      Flexible(
          flex: 5,
          fit: FlexFit.tight,
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
                text: '\$' +
                    widget.binanceGetAllModel.totalUsdValue.toStringAsFixed(2) +
                    '\n',
                style: TextStyle(color: Colors.black, height: 1.4),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          (widget.binanceGetAllModel.free + widget.binanceGetAllModel.locked)
                              .toStringAsFixed(2),
                      style: TextStyle(color: primaryDark.withOpacity(0.5)))
                ]),
          )),
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
