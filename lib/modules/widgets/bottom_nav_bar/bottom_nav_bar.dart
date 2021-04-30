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
                  Expanded(
                    child: Row(
                      children: <Widget> [

                        // Home button
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            // makes the whole area clickable
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: <Widget> [
                                SizedBox(height: 8),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Icon(Icons.home, color: Color(0xFFA9B1D9)),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text("Home", style: TextStyle(color: Color(0xFFA9B1D9), fontSize: 12)),
                                ),
                            ],)
                          ),
                        ),

                        // Trade button
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              // BlocProvider.of<GetTotalValueBloc>(context).add(FetchGetTotalValueEvent());
                              Navigator.pushNamed(context, '/sellportfolio');
                            },
                            // makes the whole area clickable
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: <Widget> [
                                SizedBox(height: 8),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Icon(Icons.bolt, color: Colors.yellow[600])
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text("Trade", textAlign: TextAlign.center, style: TextStyle(color: Colors.yellow, fontSize: 12)),
                                ),
                            ],)
                          ),
                        ),

                        // Refresh button
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              widget.callBack();
                            },
                            // makes the whole area clickable
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: <Widget> [
                                SizedBox(height: 8),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Icon(Icons.refresh, color: Color(0xFFA9B1D9)),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text("Refresh", style: TextStyle(color: Color(0xFFA9B1D9), fontSize: 12)),
                                ),
                            ],)
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