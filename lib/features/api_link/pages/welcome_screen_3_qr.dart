import 'package:coinsnap/features/utils/sizes_helper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class Second extends StatefulWidget {
  const Second({Key key}) : super(key: key);

  @override
  SecondState createState() => SecondState();
}

class SecondState extends State<Second> with TickerProviderStateMixin {

  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  int apiCharCount = 0;
  int sapiCharCount = 0;

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
            Container(height: 30),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blueGrey, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              )
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: <Widget> [
                  Text("Connect Binance", style: TextStyle(fontSize: 24))
                ]
              )
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text("Scan QR Code below", style: TextStyle(color: Colors.white, fontSize: 22)),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: _buildQrView(context)
            ),
            SizedBox(height: displayHeight(context) * 0.04),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/linkapitext');
                },
                child: Text("I don't have a QR Code", style: TextStyle(fontSize: 20))
              )
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(),
            ),
          ]
        ),
      ),
    );
  }
  /// QR STUFF (Expensive, plz refactor)
  
  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea
      ),
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
        Map<String, dynamic> body = Map.from(json.decode(result.code));
        QrResult qrDecoded = QrResult.fromJson(body);
        // final secureStorage = FlutterSecureStorage();
        if(qrSanityCheck == true) {
          qrSanityCheck = false;
          Navigator.pushReplacementNamed(context, '/checkapi', arguments: {'api': qrDecoded.apiKey, 'sapi': qrDecoded.secretKey});
        }
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