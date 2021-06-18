import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> readStorage(String _key) async {

  final storage = FlutterSecureStorage();
  
  String value = await storage.read(key: _key);
  if (value == null) {
    log("there is no " + _key + " flutterlocalstorage");
    return "none";
  } else {
  log("there is " + _key + ": " + value + "flutterlocalstorage");
    return value;
  }
}

void deleteStorage(String _key) async {
  final storage = new FlutterSecureStorage();
  await storage.delete(key: _key);
}

void writeStorage(String _key, String _value) async {
  final storage = new FlutterSecureStorage();
  await storage.write(key: _key, value: _value);
}