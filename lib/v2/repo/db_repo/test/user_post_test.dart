import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

abstract class IDBUserPostTest {
  Future dbUserPostTest();
}

class DBUserPostTest implements IDBUserPostTest {
  String requestUrl = "http://localhost:8888/portfolio/add";
  @override
    dbUserPostTest() async {
      var response = http.get(requestUrl);
      debugPrint(response.toString());
  }
}