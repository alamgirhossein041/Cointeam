class BinancePortfolioModel {  /// Repository returns a List of this model
  Map<String, dynamic> data = {};

  BinancePortfolioModel.fromJson(List json) {
    if (json != null) {
      json.forEach((object) {
        data[object['coin']] = BinanceCoinData.fromJson(object);
      });
    }
  }
}

class BinanceCoinData {
  String name;
  double free;
  double locked;
  double freeze;
  double storage;
  bool isLegalMoney;
  bool trading;
  double total;
  double usdValue;
  double btcValue;
  double totalUsdValue;

  BinanceCoinData({
    this.name,
    this.free,
    this.locked,
    this.freeze,
    this.storage,
    this.isLegalMoney,
    this.trading
  });

  BinanceCoinData.fromJson(Map<String, dynamic> json) {
  // json.forEach((k,v) => {
      name = json['name']?.toString();
      free = double.parse(json['free'] ?? 0);
      locked = double.parse(json['locked'] ?? 0);
      freeze = double.parse(json['freeze'] ?? 0);
      storage = double.parse(json['storage'] ?? 0);
      isLegalMoney = json['isLegalMoney'];
      trading = json['trading'];
      total = free + locked + freeze + storage;
  // });
}


  // BinanceGetAllModel.addPriceFromJson(Map<String, dynamic> json) {
  //   /// some logic
  //   if(json.name == )
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['coin'] = this.coin;
  //   data['depositAllEnable'] = this.depositAllEnable;
  //   data['withdrawAllEnable'] = this.withdrawAllEnable;
  //   data['name'] = this.name;
  //   data['free'] = this.free;
  //   data['locked'] = this.locked;
  //   data['freeze'] = this.freeze;
  //   data['withdrawing'] = this.withdrawing;
  //   data['ipoing'] = this.ipoing;
  //   data['ipoable'] = this.ipoable;
  //   data['storage'] = this.storage;
  //   data['isLegalMoney'] = this.isLegalMoney;
  //   data['trading'] = this.trading;
  //   if (this.networkList != null) {
  //   }
  //   return data;
  // }
}