import 'package:flutter/material.dart';

class BinanceGetChartModel {  /// Repository returns 1 of this object which has List result
  List<BinanceGetChartData> kLineList;
  String coinTicker;

  BinanceGetChartModel(
      {this.kLineList, this.coinTicker});

  BinanceGetChartModel.fromJson(var json, String _coinTicker) {
    coinTicker = _coinTicker;
    if (json != null) {
      kLineList = [];
      json.forEach((v) {
        kLineList.add(BinanceGetChartData.fromJson(v));
      });
    }
  }
}

class BinanceGetChartData {
  int openTimestamp;
  String open;
  String high;
  String low;
  String close;
  String volume;
  int closeTimestamp;
  String quoteVolume;
  int numberOfTrades;
  String takerBuyBaseVolume;
  String takerBuyQuoteVolume;
  String ignore;

  BinanceGetChartData(
    {
      this.openTimestamp,
      this.open,
      this.high,
      this.low,
      this.close,
      this.volume,
      this.closeTimestamp,
      this.quoteVolume,
      this.numberOfTrades,
      this.takerBuyBaseVolume,
      this.takerBuyQuoteVolume,
      this.ignore,
    }
  );
    BinanceGetChartData.fromJson(var json) {
    openTimestamp = json[0];
    open = json[1];
    high = json[2];
    low = json[3];
    close = json[4];
    volume = json[5];
    closeTimestamp = json[6];
    quoteVolume = json[7];
    numberOfTrades = json[8];
    takerBuyBaseVolume = json[9];
    takerBuyQuoteVolume = json[10];
    ignore = json[11];
  }
}