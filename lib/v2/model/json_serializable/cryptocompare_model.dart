import 'package:json_annotation/json_annotation.dart';
part 'cryptocompare_model.g.dart';

@JsonSerializable()
class CryptoCompareHistoHourData {
  //bool _aggregated;
  int timeFrom;
  int timeTo;
  List<CryptoCompareHistoHourDataArray> data;

  CryptoCompareHistoHourData({this.timeFrom, this.timeTo, this.data});

  factory CryptoCompareHistoHourData.fromJson(Map<String, dynamic> json) =>
      _$CryptoCompareHistoHourDataFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoCompareHistoHourDataToJson(this);
}

@JsonSerializable()
class CryptoCompareHistoHourDataArray {
  int time;
  double high;
  double low;
  double open;
  double volumefrom;
  double volumeto;
  double close;
  String conversionType;
  String conversionSymbol;

  CryptoCompareHistoHourDataArray(
      {this.time,
      this.high,
      this.low,
      this.open,
      this.volumefrom,
      this.volumeto,
      this.close,
      this.conversionType,
      this.conversionSymbol});

  factory CryptoCompareHistoHourDataArray.fromJson(Map<String, dynamic> json) =>
      _$CryptoCompareHistoHourDataArrayFromJson(json);
  Map<String, dynamic> toJson() =>
      _$CryptoCompareHistoHourDataArrayToJson(this);
}
