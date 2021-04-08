import 'dart:developer';

class GetPortfolioModel {
  Map<String, dynamic> data = {};

  GetPortfolioModel({this.data});

  GetPortfolioModel.fromJson(json) {
    log("HELLOOOOOOOO");
    log(json.toString());
      json.forEach((k,v) {
        log("8th April: " + k);
        log("8th April: " + v.toString());
        data[k] = v;
      });
  }
}