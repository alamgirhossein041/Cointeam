import 'dart:developer';

import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_bloc.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_event.dart';
import 'package:coinsnap/bloc/firestore/firestore_get_user_data_bloc/firestore_get_user_data_state.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:coinsnap/ui_root/template/loading.dart';
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
    BlocProvider.of<FirestoreGetUserDataBloc>(context);
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
            BlocListener<FirestoreGetUserDataBloc, FirestoreGetUserDataState>(
            listener: (context, state) {
              if (state is FirestoreGetUserDataErrorState) {
                log("error in FirestoreGetUserDataErrorState in text.dart");
              }
            },
            child: BlocBuilder<FirestoreGetUserDataBloc, FirestoreGetUserDataState>( /// Both bloc types to be built (refactor existing controllers)
              builder: (context, state) {
                if (state is FirestoreGetUserDataInitialState) {
                  log("FirestoreGetUserDataInitialState");
                  return Text("InitialLoadingState");
                } else if (state is FirestoreGetUserDataLoadingState) {
                  log("FirestoreGetUserDataLoadingState");
                  // return buildLoadingTemplate();
                  // return buildGetTotalValue(tmpTotalValue, tmpBtcSpecial);
                  return Text("Loading State");
                } else if (state is FirestoreGetUserDataLoadedState) {
                  log("FirestoreGetUserDataLoadedState");
                  // tmpTotalValue = state.totalValue;
                  // tmpBtcSpecial = state.btcSpecial;
                  var tmp = state.portfolioMap;
                  log("tmp['HistPortfolios']: " + tmp['HistPortfolios'].toString());
                  int i = 0;
                  log("tmp['HistPorfolios'][0]['BTC']: " + tmp['HistPortfolios'][0]['BTC'].toString());
                  return Column(
                    
                    children: <Widget> [ 
                      Column(
                        children: tmp['HistPortfolios'][0]
                          .values.map<Widget>((v) => Text("Wallah", style: TextStyle(color: Colors.white))) /// THIS IS WHERE I AM UP TO 20FEB
                          .toList(),
                      ),
                    ],
                  );
                    
                    // ListTile(
                    //   title: TextButton(
                    //     style: TextButton.styleFrom(
                    //       primary: Colors.red,
                    //     ),
                    //     child: Text('Portfolio ' + i.toString()),
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, '/home');
                    //     },
                    //   ),
                    // );
                  //   i++;
                  // })]); 
                  // return Column(
                    
                  //   children: <Widget> [ tmp['HistPortfolios'][0].forEach((v)
                    
                  //   ListTile(
                  //     title: TextButton(
                  //       style: TextButton.styleFrom(
                  //         primary: Colors.red,
                  //       ),
                  //       child: Text('Portfolio ' + i.toString()),
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/home');
                  //       },
                  //     ),
                  //   );
                  //   i++;
                  // })]); 
                  // return ListTile(title: TextButton(
                  //       style: TextButton.styleFrom(
                  //         primary: Colors.red,
                  //       ),
                  //       child: Text('Portfolio '),
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, '/home');
                  //       },
                  //     ),
                  // );
            // SizedBox(height: displayHeight(context) * 0.45);
            // ListTile(
            //   title: TextButton(
            //     style: TextButton.styleFrom(
            //       primary: Colors.red,
            //     ),
            //     child: Text('Logout'),
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/home');
            //     },
            //   ),
            // );
            
                    // child: Row(
                    //   children: <Widget> [
                    //     // SizedBox(width: displayWidth(context) * 0.1),
                    //     buildGetTotalValue(state.totalValue, state.btcSpecial),
                    //     Column( /// refactor into a function like buildGetTotalValue
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       children: <Widget> [
                    //         buildTicker(context, tmpBtcSpecial),
                    //       ]
                    //     ),
                    //   ]
                    // ),
                  // );
                } else if (state is FirestoreGetUserDataErrorState) {
                  log("FirestoreGetUserDataErrorState");
                  return buildErrorTemplate(state.errorMessage);
                } else {
                  return null;
                }
                return null;
              }
            )
            
          ),
          ],
        ),
      ),
    );
  }
}

