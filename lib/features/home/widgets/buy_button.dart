// import 'package:coinsnap/features/data/global_stats/global_stats.dart';
// import 'package:coinsnap/features/market/market.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class BuyButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: displayHeight(context) * 0.05,
        width: displayWidth(context) * 0.2,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment(-1, 1),
        //     end: Alignment(1, -1),
        //     colors: [
        //       Color(0xFF701EDB),
        //       Color(0xFF0575FF),
        //       Color(0xFF0AABFF)
        //     ],
        //     stops: [
        //       0.0,
        //       0.77,
        //       1.0
        //     ]
        //   )
        // ),
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text("Buy", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
        ),
      ),
      onTap: () => {
        // BlocProvider.of<GeckoGlobalStatsBloc>(context).add(GeckoGlobalStatsFetchEvent()),
        // BlocProvider.of<CoingeckoListTop100Bloc>(context).add(FetchCoingeckoListTop100Event()),
        // BlocProvider.of<CoingeckoListTrendingBloc>(context).add(FetchCoingeckoListTrendingEvent()),
        Navigator.pushNamed(context, '/buyportfolio1'),
      },
    );
  }
}