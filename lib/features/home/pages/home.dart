import 'package:coinsnap/features/home/widgets/home_menu_button.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';

// Packages
import 'package:coinsnap/features/data/startup/startup_bloc/startup_bloc.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_event.dart';
import 'package:coinsnap/features/data/startup/startup_bloc/startup_state.dart';
import 'package:coinsnap/features/utils/time_sync/repos/binance_time_sync.dart';
import 'package:coinsnap/features/widget_templates/loading_error_screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coinsnap/features/utils/colors_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../ui_components/ui_components.dart';

// Widgets
import '../widgets/coin_ticker.dart';
import '../widgets/panic_button.dart';
import '../widgets/home_display_info.dart';
import '../widgets/total_value.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  BinanceTimeSyncRepositoryImpl helloWorld;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
    helloWorld = BinanceTimeSyncRepositoryImpl();
    helloWorld.getBinanceTimeSyncLatest();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryBlue,
          body: Stack(overflow: Overflow.visible, children: <Widget>[
            CoinTicker(),
            Container(
                margin: mainCardMargin(),
                decoration: mainCardDecoration(),
                padding: mainCardPaddingVertical(),
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: mainCardPaddingHorizontal(),
                          child: HomeDisplayInfo(),
                          ),
                      ),
                    ],
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: PanicButton(),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      padding: mainCardPaddingHorizontal(),
                      child: HomeMenuButton()
                    ),
                  ),
                ])),
            Positioned(
              top: 80,
              right: 40,
              child: SvgPicture.asset('graphics/assets/svg/bolt_transp.svg',
                  width: 65),
            ),
          ])),
    );
  }
}

class AnimatedTicker extends StatefulWidget {
  final double btcSpecial;
  final double ethSpecial;
  AnimatedTicker({this.btcSpecial, this.ethSpecial});

  @override
  AnimatedTickerState createState() => AnimatedTickerState();
}

class AnimatedTickerState extends State<AnimatedTicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Text(
            "BTC  \$" +
                widget.btcSpecial.toStringAsFixed(0) +
                "       ETH  \$" +
                widget.ethSpecial.toStringAsFixed(0),
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)));
  }
}
