// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coingecko_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinGeckoCoinList _$CoinGeckoCoinListFromJson(Map<String, dynamic> json) {
  return CoinGeckoCoinList(
    id: json['id'] as String,
    symbol: json['symbol'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CoinGeckoCoinListToJson(CoinGeckoCoinList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
    };

CoinGeckoExchangesList _$CoinGeckoExchangesListFromJson(
    Map<String, dynamic> json) {
  return CoinGeckoExchangesList(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$CoinGeckoExchangesListToJson(
        CoinGeckoExchangesList instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
