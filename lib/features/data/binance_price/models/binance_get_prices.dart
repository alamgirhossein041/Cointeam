class BinanceGetPricesModel {
  String symbol;
  double price;

  BinanceGetPricesModel({this.symbol, this.price});

  BinanceGetPricesModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    price = double.parse(json['price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['price'] = this.price;
    return data;
  }
}