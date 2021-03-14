class DummyPortfolioModel {
  List<Data> data;

  DummyPortfolioModel({this.data});

  DummyPortfolioModel.fromJson(json) {
    if(json['data'] != null) {
      data = List<Data>();
      json['data'].forEach((k,v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String coinName;
  String coinTicker;
  double quantity;
  bool isFavourite;

  Data(
    {this.coinName,
    this.coinTicker,
    this.quantity,
    this.isFavourite,
    });

  /// ### UNCOMMENT WHEN REAL DB IS UP ### ///
  /// Data.fromJson(Map<String, dynamic> json) {
  ///   coinName = json['coinName'];
  ///   coinTicker = json['coinTicker'];
  ///   quantity = json['quantity'].toDouble();
  ///   isFavourite = json['isFavourite'].toLowerCase();
  /// }
  /// ### UNCOMMENT WHEN REAL DB IS UP ### ///
   
  Data.fromJson(dummy) {
    coinName = dummy['coinName'];
    coinTicker = dummy['coinTicker'];
    quantity = dummy['quantity'];
    isFavourite = dummy['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['coinName'] = this.coinName;
    data['coinTicker'] = this.coinTicker;
    data['quantity'] = this.quantity;
    data['isFavourite'] = this.isFavourite;
    return data;
  }
}