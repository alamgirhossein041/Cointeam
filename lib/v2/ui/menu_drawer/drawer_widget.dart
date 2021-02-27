import 'dart:developer';

import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // BlocProvider.of<FirestoreGetUserDataBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: appBlack,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Settings\n\n\n\n\n\nEarn Doge - Does nothing yet'),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueAccent, appBlue],
                ),
              ),
            ),
            ListTile(
              /// title: Text('Portfolio 1 - Live'),
              title: Text(
                'Go to Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/homeviewreal');
              },
            ),
            ListTile(
              title: Text(
                'Build New Portfolio',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/builder');
              },
            ),
            ListTile(
              title: Text(
                'Something goes here',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/testview');
              },
            ),

            /// ### For dynamically generated menu list of portfolios, see below (Firestore) ### ///

            // BlocListener<FirestoreGetUserDataBloc, FirestoreGetUserDataState>(
            //   listener: (context, state) {
            //     if (state is FirestoreGetUserDataErrorState) {
            //       log("error in FirestoreGetUserDataErrorState in text.dart");
            //     }
            //   },
            //   child: BlocBuilder<FirestoreGetUserDataBloc, FirestoreGetUserDataState>( /// Both bloc types to be built (refactor existing controllers)
            //     builder: (context, state) {
            //       if (state is FirestoreGetUserDataInitialState) {
            //         log("FirestoreGetUserDataInitialState");
            //         return Text("InitialLoadingState");
            //       } else if (state is FirestoreGetUserDataLoadingState) {
            //         log("FirestoreGetUserDataLoadingState");
            //         return Text("Loading State");
            //       } else if (state is FirestoreGetUserDataLoadedState) {
            //         log("FirestoreGetUserDataLoadedState");
            //         var tmp = state.portfolioMap;
            //         log("tmp['HistPortfolios']: " + tmp['HistPortfolios'].toString());
            //         log("tmp['HistPorfolios'][0]['BTC']: " + tmp['HistPortfolios'][0]['BTC'].toString());

            //         return Column(
            //           children: <Widget> [
            //             Column(
            //               children: <Widget> [
            //                 for(int i=0; tmp['BuildPortfolios'].length > i; i++) ListTile(title: Text(
            //                   "Built Portfolio " + i.toString(),
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 onTap: () {
            //                   Navigator.pushNamed(context, '/homeviewreal');
            //                 }
            //               )
            //             ]),
            //             Column(children: <Widget> [
            //               for(int i=0; tmp['HistPortfolios'].length > i; i++) ListTile(title: Text(
            //                 "Historical Portfolio " + i.toString(),
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //               onTap: () {
            //                 Navigator.pushNamed(context, '/homeviewreal');
            //               }
            //             )]),
            //           ]);
            //       } else if (state is FirestoreGetUserDataErrorState) {
            //         log("FirestoreGetUserDataErrorState");
            //         return buildErrorTemplate(state.errorMessage);
            //       } else {
            //         return null;
            //       }
            //     }
            //   )
            // ),

            /// ### For dynamically generated menu list of portfolios, see above (Firestore) ### ///

          ],
        ),
      ),
    );
  }
}

