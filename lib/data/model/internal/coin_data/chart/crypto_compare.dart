import 'dart:developer';

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

  PriceClose priceClose;
  CryptoCompareHourlyModel({this.priceClose});
  CryptoCompareHourlyModel.fromJsonToChart(Map<String, dynamic> json) {
    try {
      if (json['Data']['Data'] != null) {
        List<double> _priceClose = [];
        json['Data']['Data'].forEach((v) {
          log("hello world");
          _priceClose.add(double.parse(v['close'].toString()));
        });
        priceClose = PriceClose.priceClose(_priceClose);
      }
    } catch (e) {
      log("Error in crypto_compare.fromJsonToChart");
      log(e.toString());
      return;
    }
  }
}



// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['Response'] = this.response;
// 		data['Message'] = this.message;
// 		data['HasWarning'] = this.hasWarning;
// 		data['Type'] = this.type;
// 		if (this.rateLimit != null) {
//       data['RateLimit'] = this.rateLimit.toJson();
//     }
// 		if (this.data != null) {
//       data['Data'] = this.data.toJson();
//     }
// 		return data;
// 	}
// }

// class RateLimit {


// 	RateLimit({});

// 	RateLimit.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
// }

// class Data {
// 	bool aggregated;
// 	int timeFrom;
// 	int timeTo;
// 	List<Data> data;

// 	Data({this.aggregated, this.timeFrom, this.timeTo, this.data});

// 	Data.fromJson(Map<String, dynamic> json) {
// 		aggregated = json['Aggregated'];
// 		timeFrom = json['TimeFrom'];
// 		timeTo = json['TimeTo'];
// 		if (json['Data'] != null) {
// 			data = new List<Data>();
// 			json['Data'].forEach((v) { data.add(new Data.fromJson(v)); });
// 		}
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['Aggregated'] = this.aggregated;
// 		data['TimeFrom'] = this.timeFrom;
// 		data['TimeTo'] = this.timeTo;
// 		if (this.data != null) {
//       data['Data'] = this.data.map((v) => v.toJson()).toList();
//     }
// 		return data;
// 	}
// }

// class Data {
	// int time;
	// double high;
	// double low;
	// double open;
	// double volumefrom;
	// double volumeto;
	// double close;
	// String conversionType;
	// String conversionSymbol;

// 	Data({this.time, this.high, this.low, this.open, this.volumefrom, this.volumeto, this.close, this.conversionType, this.conversionSymbol});

// 	Data.fromJson(Map<String, dynamic> json) {
// 		time = json['time'];
// 		high = json['high'];
// 		low = json['low'];
// 		open = json['open'];
// 		volumefrom = json['volumefrom'];
// 		volumeto = json['volumeto'];
// 		close = json['close'];
// 		conversionType = json['conversionType'];
// 		conversionSymbol = json['conversionSymbol'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['time'] = this.time;
// 		data['high'] = this.high;
// 		data['low'] = this.low;
// 		data['open'] = this.open;
// 		data['volumefrom'] = this.volumefrom;
// 		data['volumeto'] = this.volumeto;
// 		data['close'] = this.close;
// 		data['conversionType'] = this.conversionType;
// 		data['conversionSymbol'] = this.conversionSymbol;
// 		return data;
// 	}
// }