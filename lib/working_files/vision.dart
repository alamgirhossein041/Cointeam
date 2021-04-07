// import 'dart:async';

// import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
// import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_event.dart';
// import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_state.dart';
// import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_bloc.dart';
// import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_event.dart';
// import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_state.dart';
// import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_bloc.dart';
// import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_list_250_bloc/coingecko_list_250_event.dart';

// import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_bloc.dart';
// import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_event.dart';
// import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_state.dart';
// import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
// import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_event.dart';
// import 'package:coinsnap/v2/helpers/colors_helper.dart';
// import 'package:coinsnap/v2/helpers/global_library.dart';
// import 'package:coinsnap/v2/helpers/sizes_helper.dart';
// import 'package:coinsnap/v2/repo/app_repo/binance_time_sync/binance_time_sync.dart';
// import 'package:coinsnap/v2/repo/db_repo/test/portfolio_post.dart';
// import 'package:coinsnap/v2/ui/helper_widgets/loading_screen.dart';
// import 'package:coinsnap/v2/ui/main/dashboard.dart';
// import 'package:coinsnap/v2/ui/main/home_view.dart';
// import 'package:coinsnap/v2/ui/menu_drawer/top_menu_row.dart';
// import 'package:coinsnap/v2/ui/modal_widgets/slider_widget.dart';
// import 'package:coinsnap/v2/ui/welcome/first.dart';
// import 'package:coinsnap/working_files/bottom_nav_bar.dart';
// import 'package:coinsnap/working_files/drawer.dart';
// import 'package:coinsnap/working_files/hidden_panel.dart';

import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class Vision extends StatefulWidget {
 Vision({Key key}) : super(key: key);

  @override
   VisionState createState() =>  VisionState();
}

class VisionState extends State<Vision> {
  ConfettiController _controllerTopCenter;
  @override
  void initState() { 
    super.initState();
    _controllerTopCenter = ConfettiController(duration: Duration(seconds: 20));
    WidgetsBinding.instance.addPostFrameCallback((_) => 
        _controllerTopCenter.play(),
    );
  }
  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
       body: Stack(
        children: <Widget> [
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _controllerTopCenter,
            blastDirection: 3.14 / 2,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
          ),
        ),
        // Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(7),
        //   gradient: LinearGradient(
        //     begin: Alignment(-1, -0.6),
        //     end: Alignment(1, 0.75),
        //     colors: [Colors.blueAccent[200], Colors.pink[200]],
        //   ),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Color(0xFFFFCA1E),
        //       spreadRadius: 4,
        //       blurRadius: 10,
        //     ),
        //     BoxShadow(
        //       color: Color(0xFFFFCA1E),
        //       spreadRadius: -4,
        //       blurRadius: 5,
        //     )
        //   ]
        // ),
        Column(
    children: <Widget> [
        Flexible(
        flex: 4,
        fit: FlexFit.tight,
        child: Center(child: Text("Happy 29++th Birthday!!!")),
    
      ),
      Flexible(
        flex: 5,
        fit: FlexFit.tight,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text("Thanks for being part of the "),
            Text("fam", style: TextStyle(decoration: TextDecoration.lineThrough)),
            Text(" team!"),
          ]
        )
      ),
      Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Column(
          children: <Widget> [
            Text("We are all your #1 fans"),
            SizedBox(height: displayHeight(context) * 0.05),
            TextButton(child: Text("Replay?"), onPressed: () => _controllerTopCenter.play()),
            
          ]
        )
      )
    ]
    )]));
  }
}