import 'dart:convert';

import 'package:coinsnap/v2/model/db_model/test.dart/db_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

abstract class IDBPortfolioPostTest {
  Future dbPortfolioPostTest();
}

class DBPortfolioPostTest implements IDBPortfolioPostTest {
  String requestUrl = "http://46d3afcd348b.ngrok.io";
  @override
  
    dbPortfolioPostTest() async {
      DBUserModel dbUserModel = DBUserModel(
        userId: 123,
        email: "testEMAIL@gmail.com",
        phoneNumber: 124,
        createdTimestamp: DateTime.now(), /// check client-side if new user
        createdBy: "Me",
        modifiedTimestamp: DateTime.now(), /// Check as above
        modifiedBy: "Me",
        lastUserActivityTimestamp: DateTime.now() /// always
      );

        var json = jsonEncode(dbUserModel.toJson());
      // debugPrint(json);


      var response = await http.post(
        requestUrl + '/user/login/123/',
        headers: <String, String>{
          'content-type': 'application/json',
          "accept": "application/json",
        },
        body: json
        /// ### I assume the below is the non-model way of doing it ### ///
        // body: jsonEncode(<String, String>{
        //   'title': title,
        // }
        /// ### See Above ### ///
      );
      
      debugPrint(response.body.toString());
  }
}