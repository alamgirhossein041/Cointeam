import 'package:flutter/material.dart';

class GetPortfolioModel {
  Map<String, dynamic> data = {};

  GetPortfolioModel({this.data});

  GetPortfolioModel.fromJson(json) {
    debugPrint("HELLOOOOOOOO");
    debugPrint(json.toString());
      json.forEach((k,v) {
        debugPrint("8th April: " + k);
        debugPrint("8th April: " + v.toString());
        data[k] = v;
      });
  }
}