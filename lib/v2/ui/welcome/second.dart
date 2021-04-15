import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/repo/app_repo/binance_api_check/binance_api_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Second extends StatefulWidget {
  const Second({Key key}) : super(key: key);

  @override
  SecondState createState() => SecondState();
}

class SecondState extends State<Second> with TickerProviderStateMixin {

  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController _secretApiTextController;
  TextEditingController _publicApiTextController;

  int apiCharCount = 0;
  int sapiCharCount = 0;

  bool _obscureText = true;

  var modalPadding = EdgeInsets.all(20.0);

  /// In order to get hot reload to work we need to pause the camera if the platform
  /// is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2B064B), Color(0xFF381AA2)]
          ),
        ),
        padding: modalPadding,
        child: Column(
          children: <Widget> [
            // ModalTopBar(1), // estimated time indicator
            Container(height: 70),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: <Widget> [
                  Text("Connect Binance", style: TextStyle(fontSize: 24))
                  // Text("Connect " + exchanges[widget.exch]),
                  // ModalHeading("Connect "+ exchanges[widget.exch]),
                ]
              )
            ),

            // Flexible(
            //   flex: 1,
            //   fit: FlexFit.tight,
            //   child: ModalGuideText(page, widget.exch),
            // ),
            // SizedBox(height: displayHeight(context) * 0.1),
            // Flexible(
            //   flex: 1,
            //   fit: FlexFit.tight,
            //   child: SingleChildScrollView(
            //     child: StatefulBuilder(
            //       builder: (context, setState) {
            //         return Align(
            //           alignment: Alignment.bottomCenter,
            //           child: TextField(
            //             controller: _publicApiTextController,
            //             onChanged: _onChanged,
            //             decoration: InputDecoration(
            //               border: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 1, color: Colors.white),
            //               ),
            //               enabledBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 1, color: Theme.of(context).accentColor),
            //               ),
            //               focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 3, color: Theme.of(context).accentColor),
            //               ),
            //               labelStyle: TextStyle(color: Colors.white),
            //               labelText: 'Public API key',
            //               helperText: "",
            //               helperStyle: TextStyle(color: Colors.white),
            //               // toggle visibility on/off
            //               // suffixIcon: IconButton(
            //               //   icon: _obscureText? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off),
            //               //   onPressed: () {
            //               //     setState(() => _obscureText = !_obscureText);
            //               //   },
            //               //   color: Colors.grey,
            //               // )
            //             ),
            //             style: Theme.of(context).textTheme.bodyText1
            //           )
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // // SizedBox(height: displayHeight(context) * 0.05),
            // Flexible(
            //   flex: 1,
            //   fit:FlexFit.tight,
            //   child: SingleChildScrollView(
            //     child: Center(
            //       child: StatefulBuilder(
            //         builder: (context, setState) {
            //           return TextField(
            //             controller: _secretApiTextController,
            //             obscureText: _obscureText,
            //             onChanged: _onChanged,
            //             decoration: InputDecoration(
            //               border: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 1, color: Colors.white),
            //               ),
            //               enabledBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 1, color: Theme.of(context).accentColor),
            //               ),
            //               focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(width: 3, color: Theme.of(context).accentColor),
            //               ),
            //               labelStyle: TextStyle(color: Colors.white),
            //               labelText: 'Secret API key',
            //               helperText: "",
            //               helperStyle: TextStyle(color: Colors.white),
            //               // toggle visibility on/off
            //               suffixIcon: IconButton(
            //                 icon: _obscureText? Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off),
            //                 onPressed: () {
            //                   setState(() => _obscureText = !_obscureText);
            //                 },
            //                 color: Colors.grey,
            //               )
            //             ),
            //             style: Theme.of(context).textTheme.bodyText1
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: displayHeight(context) * 0.05),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text("Scan QR Code below", style: TextStyle(color: Colors.white, fontSize: 22)),
                  // IconButton(
                  //   onPressed: () => {
                      
                  //   },
                  //   icon: Icon(Icons.camera_alt, color: Colors.blueGrey, size: 36)
                  // ),
                
            ),
            // Builder(
            //   builder: (context) {
            //     final condition = result != null;

            //     return condition ? Flexible(
            //       flex: 1,
            //       fit: FlexFit.tight,
            //       child: Text("Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}"), /// 31st
            //       ) : Flexible(
            //         flex: 1,
            //         fit: FlexFit.tight,
            //         child: Text("Nothing scanned"),
            //       );
            //   }
            // ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: _buildQrView(context)
            ),
            SizedBox(height: displayHeight(context) * 0.08),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TextButton(
                onPressed: () {},
                child: Text("I don't have a QR Code")
              )
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              // child: Text("What is this?")
              child: Container(),
            ),
            // SizedBox(height: displayHeight(context) * 0.08),
            
            // Flexible(
            //   flex: 1,
            //   fit: FlexFit.tight,
            //   child: Visibility(
            //     visible: _visibility,
            //     child: Text("\nContacting Binance...\n\nChecking Validity..."),
            //   ),
            // ),

            
          ]
        ),
      ),
    );
  }
  // _onChanged(String value) async {
  // // TextEditingController _secretApiTextController;
  // // TextEditingController _publicApiTextController;
  //   apiCharCount = _publicApiTextController.text.length;
  //   sapiCharCount = _secretApiTextController.text.length;
  //   if (sapiCharCount == 64) {
  //     if(apiCharCount == 64) {
  //     // widget.indexCallback(6);

  //       bool response = await BinanceApiCheckRepositoryImpl().getBinanceApiCheckLatest();
  //       if (response == true) {
  //         log("HELL YEA");
  //       }
  //     }
    // }
  // }


  /// QR STUFF (Expensive, plz refactor)
  
  
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    bool qrSanityCheck = true;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        result = scanData; /// 31st
        // log(result.code);
        Map<String, dynamic> body = Map.from(json.decode(result.code));
        QrResult qrDecoded = QrResult.fromJson(body);
        // QrResult qrDecoded = json.decode(result.code).fromJson();
        // log(qrDecoded.toString());
        // log("Hello World: " + qrDecoded.toString());
        // log("apiKey is " + qrDecoded.apiKey);
        // _publicApiTextController.value = TextEditingValue(
        //   text: qrDecoded.apiKey,
        //   selection: TextSelection.fromPosition(
        //     TextPosition(offset: qrDecoded.apiKey.length),
        //   )
        // );
        // _secretApiTextController.value = TextEditingValue(
        //   text: qrDecoded.secretKey,
        //   selection: TextSelection.fromPosition(
        //     TextPosition(offset: qrDecoded.secretKey.length),
        //   )
        // );
        // log(_publicApiTextController.text);
        // log(_secretApiTextController.text);
        final secureStorage = FlutterSecureStorage();

        await secureStorage.write(key: 'binanceApi', value: qrDecoded.apiKey);
        await secureStorage.write(key: 'binanceSapi', value: qrDecoded.secretKey);

        if(qrSanityCheck == true) {
          
          Navigator.pushReplacementNamed(context, '/third');
          qrSanityCheck = false;
        }

        /// 1st

        // _onChanged(_secretApiTextController.text);

        /// json decode the string
        /// save as map
        /// retrieve value of public
        /// retrieve value of secret
        /// save into controllers

        // _secretApiTextController = 
      // TextEditingController _publicApiTextController;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QrResult {
  String apiKey;
  String secretKey;

  QrResult({
    this.apiKey,
    this.secretKey,
  });

  QrResult.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    secretKey = json['secretKey'];
  }
}