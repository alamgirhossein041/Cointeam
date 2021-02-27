// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptocompare_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCompareHistoHourData _$CryptoCompareHistoHourDataFromJson(
    Map<String, dynamic> json) {
  return CryptoCompareHistoHourData(
    timeFrom: json['timeFrom'] as int,
    timeTo: json['timeTo'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CryptoCompareHistoHourDataArray.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CryptoCompareHistoHourDataToJson(
        CryptoCompareHistoHourData instance) =>
    <String, dynamic>{
      'timeFrom': instance.timeFrom,
      'timeTo': instance.timeTo,
      'data': instance.data,
    };

CryptoCompareHistoHourDataArray _$CryptoCompareHistoHourDataArrayFromJson(
    Map<String, dynamic> json) {
  return CryptoCompareHistoHourDataArray(
    time: json['time'] as int,
    high: (json['high'] as num)?.toDouble(),
    low: (json['low'] as num)?.toDouble(),
    open: (json['open'] as num)?.toDouble(),
    volumefrom: (json['volumefrom'] as num)?.toDouble(),
    volumeto: (json['volumeto'] as num)?.toDouble(),
    close: (json['close'] as num)?.toDouble(),
    conversionType: json['conversionType'] as String,
    conversionSymbol: json['conversionSymbol'] as String,
  );
}

Map<String, dynamic> _$CryptoCompareHistoHourDataArrayToJson(
        CryptoCompareHistoHourDataArray instance) =>
    <String, dynamic>{
      'time': instance.time,
      'high': instance.high,
      'low': instance.low,
      'open': instance.open,
      'volumefrom': instance.volumefrom,
      'volumeto': instance.volumeto,
      'close': instance.close,
      'conversionType': instance.conversionType,
      'conversionSymbol': instance.conversionSymbol,
    };
