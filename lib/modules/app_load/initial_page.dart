import 'package:coinsnap/modules/services/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;
import 'package:flutter/scheduler.dart';

class InitialPage extends StatefulWidget {
  // const InitialPage({Key key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  void initState() { 
    super.initState();
    analytics.logEvent (
      name: 'test_event',
      parameters: {'test_param_1': 'thisisastring', 'test_param_2': 1337, 'test_param_3': {'map_test': 'map_value'}}
    );
  }
  
  @override
  Widget build(BuildContext context) {
    debugPrint("INITIALPAGE");
    globals.binanceTimestampModifier = 0;
    // BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
    // BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
    // BlocProvider.of<CoingeckoList250Bloc>(context).add(FetchCoingeckoList250Event());
    SchedulerBinding.instance.addPostFrameCallback((_) => {Navigator.pushReplacementNamed(context, '/home')});
    return Container();
  }
}