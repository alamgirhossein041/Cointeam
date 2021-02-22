import 'package:flutter/material.dart';

class CoinMarketCapCoinLatestModel {
  List<Data> data;

  CoinMarketCapCoinLatestModel({this.data});

  CoinMarketCapCoinLatestModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<Data>();
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String name;
  String symbol;
  String lastUpdated;
  Quote quote;

  Data(
      {this.name,
      this.symbol,
      this.lastUpdated,
      this.quote});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    lastUpdated = json['last_updated'];
    quote = json['quote'] != null ? Quote.fromJson(json['quote']) : null;
  }
}

class Quote {
  USD uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? USD.fromJson(json['USD']) : null;
  }
}

class USD {
  double price;
  double volume24h;
  double percentChange1h;
  double percentChange24h;
  double percentChange7d;
  double percentChange30d;
  Color changeColor;
  double marketCap;
  String lastUpdated;

  USD(
      {this.price,
      this.volume24h,
      this.percentChange1h,
      this.percentChange24h,
      this.percentChange7d,
      this.percentChange30d,
      this.changeColor,
      this.marketCap,
      this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    volume24h = json['volume_24h'];
    percentChange1h = json['percent_change_1h'];
    percentChange24h = json['percent_change_24h'];
    percentChange7d = json['percent_change_7d'];
    percentChange30d = json['percent_change_30d'];
    marketCap = json['market_cap'];
    lastUpdated = json['last_updated'];
    if(percentChange24h > 0) {
      changeColor = Colors.green;
    } else if(percentChange24h < 0) {
      changeColor = Colors.red;
    } else {
      changeColor = Colors.black;
    }
  }
}