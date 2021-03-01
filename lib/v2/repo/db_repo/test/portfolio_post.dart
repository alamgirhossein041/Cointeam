import 'package:http/http.dart' as http;
import 'dart:developer';

abstract class IDBPortfolioPostTest {
  Future dbPortfolioPostTest();
}

class DBPortfolioPostTest implements IDBPortfolioPostTest {
  String requestUrl = "http://localhost:8888/portfolio/add";
  @override
    dbPortfolioPostTest() async {
      var response = http.get(requestUrl);
      log(response.toString());
  }
}