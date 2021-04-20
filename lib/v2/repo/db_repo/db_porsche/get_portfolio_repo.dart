

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:coinsnap/v2/model/db_model/db_porsche/get_portfolio_model.dart';
import 'package:localstorage/localstorage.dart';

abstract class IGetPortfolioRepository {
  GetPortfolioModel getPortfolio(String _portfolio);
}

class GetPortfolioImpl implements IGetPortfolioRepository {
  @override
  GetPortfolioModel getPortfolio(String _portfolio) {
    final LocalStorage localStorage = LocalStorage("coinstreetapp");
    // return GetPortfolioModel.fromJson(GetPortfolioDummyData.getData);
    var localStorageResponse = localStorage.getItem(_portfolio);
    debugPrint("8th April: Our local storage is - " + localStorageResponse.toString());
    return GetPortfolioModel.fromJson(localStorageResponse);
  }
}

class GetPortfolioDummyData {

  final LocalStorage localStorage = LocalStorage("coinstreetapp");
  // var localStorageResponse = localStorage.getItem("prime");
  // if(localStorageResponse != null) {
  //   primeCoin = Map.from(json.decode(await localStorage.getItem("prime")));

  // Map<String, dynamic> getData = 
  //   {
      
  //     'BTC': 40,
  //     'ETH': 30,
  //     //  'icon': CryptoFontIcons.BTC,
  //     //  'iconColor': Colors.orange,
  //     //  'change': '+3.67%',
  //     //  'changeValue': '+202.835',
  //     //  'changeColor': Colors.green,
  //     'XRP': 25,
  //     'totalValue': 95
  //   };

  
}