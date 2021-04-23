import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_bloc.dart';
import 'package:coinsnap/modules/data/total_tradeable_value/binance_total_value/bloc/binance_total_value_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({this.callBack});
  final Function callBack;

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {

  final storage = new FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Container(
          /// ### This is the bottomappbar ### ///
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomAppBar(
              color: Color(0xFF2E374E),
              child: Column(
                children: <Widget> [
                  // SizedBox(height: 5),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        /// ### Bottom left button on bottomnavbar ### ///
                        Column(
                          children: <Widget> [
                            Align(
                              alignment: Alignment.topCenter,
                              child: IconButton(icon: Icon(Icons.home, color: Color(0xFFA9B1D9)), onPressed: () {
                                Navigator.pushReplacementNamed(context, '/home');
                              }),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text("Home", style: TextStyle(color: Color(0xFFA9B1D9)))
                            ),
                          ]
                        ),
                        Column(
                          children: <Widget> [
                            Align(
                              alignment: Alignment.topCenter,
                              child: IconButton(icon: Icon(Icons.bolt, color: Colors.yellowAccent[100]), onPressed: () {
                                BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                                Navigator.pushNamed(context, '/sellportfolio');
                              }),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text("Trade", style: TextStyle(color: Colors.yellowAccent[100]))
                            ),
                          ]
                        ),
                        /// ### Bottom right button on bottomnavbar ### ///
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: <Widget> [
                              IconButton(icon: Icon(Icons.refresh, color: Color(0xFFA9B1D9)), onPressed: () {widget.callBack();}),
                              Text("Refresh", style: TextStyle(color: Color(0xFFA9B1D9)))
                            ]
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}