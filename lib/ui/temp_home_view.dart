import 'package:coinsnap/resource/colors_helper.dart';
import 'package:flutter/material.dart';
import 'home_content.dart';

import 'dart:developer';

class TempHomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [appPink, Colors.blue]
            /// temp colours
          ),
        ),
        child: RefreshIndicator(
          onRefresh: refreshEvent,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: InnerHomeView(),
          ),
        ),
      ),
    );
  }
  refreshEvent() async {
    /// setState(() {
    /// });
    /// 
    /// ***Instead of setState we use our Bloc event caller or whatever
    log("this is a very hard problem");
  }
}