import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';

class CryptoCompareModel {
	String response;
	String message;
	bool hasWarning;
	int type;
	// RateLimit rateLimit; /// property
  DataClass data; /// shape

	CryptoCompareModel(
      {this.response,
      this.message,
      this.hasWarning,
      this.type,
      // this.rateLimit,
      this.data});

  CryptoCompareModel.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    message = json['Message'];
    hasWarning = json['HasWarning'];
    type = json['Type'];
    data = json['Data'] != null ? DataClass.fromJson(json['Data']) : null;
  }
}

class DataClass {

  DataClass(
    {this.aggregated,
    this.timeFrom,
    this.timeTo,
    this.data});

  bool aggregated;
  int timeFrom;
  int timeTo;
  List<dynamic> data;

  factory DataClass.fromJson(Map<String, dynamic> json) {
    return DataClass(
      aggregated: json['Aggregated'],
      timeFrom: json['TimeFrom'],
      timeTo: json['TimeTo'],
      data: json['Data']
    );
  }
}

class DataList {

  DataList(
    {this.time,
    this.high,
    this.low,
    this.open,
    this.volumefrom,
    this.volumeto,
    this.close,
    this.conversionType,
    this.conversionSymbol});

	int time;
	double high;
	double low;
	double open;
	double volumefrom;
	double volumeto;
	double close;
	String conversionType;
	String conversionSymbol;

  factory DataList.fromJson(Map<String, dynamic> json) {
    return DataList(
      time: json['time'],
      high: json['high'],
      low: json['low'],
      open: json['open'],
      volumefrom: json['volumefrom'],
      volumeto: json['volumeto'],
      close: json['close'],
      conversionType: json['conversionType'],
      conversionSymbol: json['conversionSymbol']);
  }
}

/// ############################################################################ ///

// class PriceClose {
//   List<SalesData> salesData;

//   PriceClose({this.salesData});

//   factory PriceClose.priceClose(List<double> _priceClose, List<int> _timestamp) {
//     return PriceClose(
      
//       salesData: _priceClose,
//       timestamp: _timestamp,
//     );
//   }
// }

class PriceClose {
  List<double> priceClose;

  PriceClose({this.priceClose});

  factory PriceClose.priceClose(List<double> _priceClose) {
    return PriceClose(
      priceClose: _priceClose,
    );
  }
}

class CryptoCompareHourlyModel {

/// ########################################################################### ///
/// Returns an array of prices - do not inquire further ///
  // PriceClose priceClose;
  List<SalesData> salesDataList = [];
  // CryptoCompareHourlyModel({this.priceClose});
  CryptoCompareHourlyModel.fromJsonToChart(Map<String, dynamic> json) {
    try {
      if (json['Data']['Data'] != null) {
        List<double> _priceClose = [];
        List<String> _timestamp = [];
        json['Data']['Data'].forEach((v) {
          _priceClose.add(double.parse(v['close'].toString()));
          _timestamp.add((v['time'].toString()));
          salesDataList.add(SalesData(time: v['time'].toString(), price: v['close']));

          /// ### We are making the timestamp conversion here for now ### ///
          ///     TODO: Decouple the conversion, make a new method    ### ///
          ///                                                             /// 
          /// salesDataList.add(SalesData(time: v['time'].toString(), price: v['close']));
          
          // final localizations = MaterialLocalizations.of(context);
          /// ### Timestamp needs localizations and context therefore needs to occur on UI side ### ///
          // salesDataList.add(SalesData(time: MaterialLocalizations.formatTimeOfDay(TimeOfDay.fromDateTime((v['time'] * 1000)), alwaysUse24HourFormat: false), price: v['close']));
          // salesDataList.add(SalesData(time: );
          
        });
        /// We really need to think about stuff
        // priceClose = PriceClose.priceClose(_priceClose, _timestamp);
        
      }
    } catch (e) {
      log("Error in crypto_compare.fromJsonToChart");
      log(e.toString());
      return;
    }
  }
/// ########################################################################### ///

}

// class SalesData {
//   SalesData({this.time, this.price});
//   /// each time interval does separate API calls 30min ticks?
//   String time;
//   double price;

// }