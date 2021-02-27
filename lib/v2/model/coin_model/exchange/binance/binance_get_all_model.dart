class BinanceGetAllModel {  /// Repository returns a List of this model
  String coin;
  bool depositAllEnable;
  bool withdrawAllEnable;
  String name;
  double free;
  double locked;
  double freeze;
  double withdrawing;
  double ipoing;
  double ipoable;
  double storage;
  bool isLegalMoney;
  bool trading;
  List<dynamic> networkList;

  BinanceGetAllModel(
      {this.coin,
      this.depositAllEnable,
      this.withdrawAllEnable,
      this.name,
      this.free,
      this.locked,
      this.freeze,
      this.withdrawing,
      this.ipoing,
      this.ipoable,
      this.storage,
      this.isLegalMoney,
      this.trading,
      this.networkList});

BinanceGetAllModel.fromJson(Map<String, dynamic> json) {
    if(double.parse(json['free']) > 0 || double.parse(json['locked']) > 0) {
      coin = json['coin'].toString();
      depositAllEnable = json['depositAllEnable'];
      withdrawAllEnable = json['withdrawAllEnable'];
      name = json['name'].toString();
      free = double.parse(json['free']);
      locked = double.parse(json['locked']);
      freeze = double.parse(json['freeze']);
      withdrawing = double.parse(json['withdrawing']);
      ipoing = double.parse(json['ipoing']);
      ipoable = double.parse(json['ipoable']);
      storage = double.parse(json['storage']);
      isLegalMoney = json['isLegalMoney'];
      trading = json['trading'];
      networkList = json['networkList'].toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['coin'] = this.coin;
    data['depositAllEnable'] = this.depositAllEnable;
    data['withdrawAllEnable'] = this.withdrawAllEnable;
    data['name'] = this.name;
    data['free'] = this.free;
    data['locked'] = this.locked;
    data['freeze'] = this.freeze;
    data['withdrawing'] = this.withdrawing;
    data['ipoing'] = this.ipoing;
    data['ipoable'] = this.ipoable;
    data['storage'] = this.storage;
    data['isLegalMoney'] = this.isLegalMoney;
    data['trading'] = this.trading;
    if (this.networkList != null) {
    }
    return data;
  }
}