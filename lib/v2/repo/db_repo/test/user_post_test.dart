import 'package:http/http.dart' as http;
import 'dart:developer';

abstract class IDBUserPostTest {
  Future dbUserPostTest();
}

class DBUserPostTest implements IDBUserPostTest {
  String requestUrl = "http://localhost:8888/portfolio/add";
  @override
    dbUserPostTest() async {
      var response = http.get(requestUrl);
      log(response.toString());
  }
}