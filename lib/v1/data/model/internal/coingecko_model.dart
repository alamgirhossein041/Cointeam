import 'package:json_annotation/json_annotation.dart';
part 'coingecko_model.g.dart';

@JsonSerializable()
class CoinGeckoCoinList {
  String id;
  String symbol;
  String name;

  CoinGeckoCoinList({this.id, this.symbol, this.name});

  factory CoinGeckoCoinList.fromJson(Map<String, dynamic> json) =>
      _$CoinGeckoCoinListFromJson(json);
  Map<String, dynamic> toJson() => _$CoinGeckoCoinListToJson(this);
}

@JsonSerializable()
class CoinGeckoExchangesList {
  String id;
  //String name;

  CoinGeckoExchangesList({this.id});

  factory CoinGeckoExchangesList.fromJson(Map<String, dynamic> json) =>
      _$CoinGeckoExchangesListFromJson(json);
  Map<String, dynamic> toJson() => _$CoinGeckoExchangesListToJson(this);
}
