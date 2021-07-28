class CoingeckoCoin {
  final String id;
  final String symbol;
  final String name;

  CoingeckoCoin({this.id, this.symbol, this.name});

  CoingeckoCoin.fromJson(Map json)
      : id = json['id'],
        symbol = json['symbol'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    return data;
  }
}
