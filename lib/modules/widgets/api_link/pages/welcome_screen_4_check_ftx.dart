import 'dart:developer';

import 'package:coinsnap/modules/data/ftx_api_check.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:coinsnap/modules/widgets/templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckFtxApi extends StatefulWidget {
  @override
  _CheckFtxApiState createState() => _CheckFtxApiState();
}

class _CheckFtxApiState extends State<CheckFtxApi> {
  String api = '';
  String sapi = '';
  bool sanityCheck = true;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if(sanityCheck == true) {
      if(arguments == null) {
        debugPrint("CheckFtxApi arguments is null");
        log("CheckFtxApi arguments is null");
      } else {
        api = arguments['api'];
        sapi = arguments['sapi'];
      }
      log("TWICE");
      checkApi(api, sapi);
      sanityCheck = false;
    }
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2B064B), Color(0xFF381AA2)]
          ),
        ),
        child: Column(
          children: <Widget> [
            SizedBox(height: 250),
            Text("Checking FTX API...", style: TextStyle(fontSize: 24)),
            SizedBox(height: 50),
            loadingTemplateWidget()
          ]
        ),
      ),
    );
  }

  void checkApi(String api, String sapi) async {
    bool response = await FtxApiCheckRepositoryImpl().getFtxApiCheckLatest(api, sapi);
    if(response) {
      final secureStorage = FlutterSecureStorage();
      await secureStorage.write(key: 'ftxApi', value: api);
      await secureStorage.write(key: 'ftxSapi', value: sapi);
      await secureStorage.write(key: 'trading', value: 'true');
      await secureStorage.write(key: 'binance', value: 'true');
      await secureStorage.write(key: 'ftx', value: 'true');
      Navigator.pushNamed(context, '/modalsuccess');
    } else {
      Navigator.pushNamed(context, '/modalfailure');
    }
  }
}