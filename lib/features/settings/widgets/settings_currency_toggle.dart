import 'package:coinsnap/features/data/global_stats/global_stats.dart';
import 'package:coinsnap/features/data/startup/startup.dart';
import 'package:coinsnap/features/market/market.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class SettingsCurrencyToggle extends StatefulWidget {
  SettingsCurrencyToggle({Key key}) : super(key: key);

  @override
  SettingsCurrencyToggleState createState() => SettingsCurrencyToggleState();
}

class SettingsCurrencyToggleState extends State<SettingsCurrencyToggle> {
  String currency = '';

  @override
  void initState() {
    final storage = LocalStorage("settings");
    storage.ready.then((_) {
      setState(() {currency = storage.getItem("currency") ?? 'USD';});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: displayWidth(context),
        // child: Container(
        //   width: double.infinity,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text("Currency"),
            Text(currency, style: TextStyle(color: Colors.black.withOpacity(0.4))),
          ]
        // ),
        )
      ),
      onTap: () => _currencyToggleHelper()
    );
  }
  _currencyToggleHelper() {
    final storage = LocalStorage("settings");
    storage.ready.then((_) {
      currency = storage.getItem("currency") ?? 'USD';
      BlocProvider.of<StartupBloc>(context).add(FetchStartupEvent());
      BlocProvider.of<GeckoGlobalStatsBloc>(context).add(GeckoGlobalStatsFetchEvent());
      BlocProvider.of<CoingeckoListTop100Bloc>(context).add(FetchCoingeckoListTop100Event());
      BlocProvider.of<CoingeckoListTrendingBloc>(context).add(FetchCoingeckoListTrendingEvent());
    });
    if(currency == 'USD') {
      storage.setItem("currency", 'AUD');
      setState(() {
        currency = 'AUD';
      });
    } else if (currency == 'AUD') {
      storage.setItem("currency", 'USD');
      setState(() {
        currency = 'USD';
      });
    }
  }
}