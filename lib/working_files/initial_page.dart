import 'dart:developer';

import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';



class InitialPage extends StatefulWidget {
  // const InitialPage({Key key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  
  @override
  Widget build(BuildContext context) {
    log("INITIALPAGE");
    // BlocProvider.of<GlobalCoinmarketcapStatsBloc>(context).add(FetchGlobalCoinmarketcapStatsEvent());
    // BlocProvider.of<GetCoinListBloc>(context).add(FetchGetCoinListEvent());
    // BlocProvider.of<CoingeckoList250Bloc>(context).add(FetchCoingeckoList250Event());
    SchedulerBinding.instance.addPostFrameCallback((_) => {Navigator.pushReplacementNamed(context, '/dashboardnoapitest')});
    return Container();
  }
}