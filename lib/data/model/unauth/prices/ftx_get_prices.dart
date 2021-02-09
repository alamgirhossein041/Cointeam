class FtxGetPricesModel {
  List<Result> result;
  bool success;

  FtxGetPricesModel({this.result, this.success});

  FtxGetPricesModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(Result.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Result {
  double ask;
  String baseCurrency;
  double bid;
  double change1h;
  double change24h;
  double changeBod;
  bool enabled;
  bool highLeverageFeeExempt;
  double last;
  double minProvideSize;
  String name;
  bool postOnly;
  double price;
  double priceIncrement;
  String quoteCurrency;
  double quoteVolume24h;
  bool restricted;
  double sizeIncrement;
  String type;
  String underlying;
  double volumeUsd24h;
  bool tokenizedEquity;

  Result(
      {this.ask,
      this.baseCurrency,
      this.bid,
      this.change1h,
      this.change24h,
      this.changeBod,
      this.enabled,
      this.highLeverageFeeExempt,
      this.last,
      this.minProvideSize,
      this.name,
      this.postOnly,
      this.price,
      this.priceIncrement,
      this.quoteCurrency,
      this.quoteVolume24h,
      this.restricted,
      this.sizeIncrement,
      this.type,
      this.underlying,
      this.volumeUsd24h,
      this.tokenizedEquity});

  Result.fromJson(Map<String, dynamic> json) {
    ask = json['ask'];
    baseCurrency = json['baseCurrency'];
    bid = json['bid'];
    change1h = json['change1h'];
    change24h = json['change24h'];
    changeBod = json['changeBod'];
    enabled = json['enabled'];
    highLeverageFeeExempt = json['highLeverageFeeExempt'];
    last = json['last'];
    minProvideSize = json['minProvideSize'];
    name = json['name'];
    postOnly = json['postOnly'];
    price = json['price'];
    priceIncrement = json['priceIncrement'];
    quoteCurrency = json['quoteCurrency'];
    quoteVolume24h = json['quoteVolume24h'];
    restricted = json['restricted'];
    sizeIncrement = json['sizeIncrement'];
    type = json['type'];
    underlying = json['underlying'];
    volumeUsd24h = json['volumeUsd24h'];
    tokenizedEquity = json['tokenizedEquity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ask'] = this.ask;
    data['baseCurrency'] = this.baseCurrency;
    data['bid'] = this.bid;
    data['change1h'] = this.change1h;
    data['change24h'] = this.change24h;
    data['changeBod'] = this.changeBod;
    data['enabled'] = this.enabled;
    data['highLeverageFeeExempt'] = this.highLeverageFeeExempt;
    data['last'] = this.last;
    data['minProvideSize'] = this.minProvideSize;
    data['name'] = this.name;
    data['postOnly'] = this.postOnly;
    data['price'] = this.price;
    data['priceIncrement'] = this.priceIncrement;
    data['quoteCurrency'] = this.quoteCurrency;
    data['quoteVolume24h'] = this.quoteVolume24h;
    data['restricted'] = this.restricted;
    data['sizeIncrement'] = this.sizeIncrement;
    data['type'] = this.type;
    data['underlying'] = this.underlying;
    data['volumeUsd24h'] = this.volumeUsd24h;
    data['tokenizedEquity'] = this.tokenizedEquity;
    return data;
  }
}