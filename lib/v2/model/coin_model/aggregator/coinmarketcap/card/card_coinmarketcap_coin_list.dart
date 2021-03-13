import 'dart:convert';

class CardCoinmarketcapListModel {
  Status status;
  List<Data> data;

  CardCoinmarketcapListModel({this.status, this.data});

  CardCoinmarketcapListModel.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['data'] != null) {
      data = List<Data>();
      json['data'].forEach((k,v) {
        data.add(Data.fromJson(v));
      });
    }
  }
}

class Status {
  String timestamp;

  Status(
      {this.timestamp});

  Status.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
  }
}

class Data {
  String name;
  Quote quote;
  int cmcRank;
  /// TODO: Add Icon here?

  Data({this.name, this.quote});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quote = json['quote'] != null ? Quote.fromJson(json['quote']) : null;
    cmcRank = json['cmc_rank'];
  }
}

class Quote {
  USD uSD;

  Quote({this.uSD});

  Quote.fromJson(Map<String, dynamic> json) {
    uSD = json['USD'] != null ? new USD.fromJson(json['USD']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSD != null) {
      data['USD'] = this.uSD.toJson();
    }
    return data;
  }
}

class USD {
  double price;
  double volume24h;
  double percentChange1h;
  double percentChange24h;
  double percentChange7d;
  double percentChange30d;
  double percentChange60d;
  double percentChange90d;
  double marketCap;
  String lastUpdated;

  USD(
      {this.price,
      this.volume24h,
      this.percentChange1h,
      this.percentChange24h,
      this.percentChange7d,
      this.percentChange30d,
      this.percentChange60d,
      this.percentChange90d,
      this.marketCap,
      this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) {
    price = json['price'].toDouble();
    volume24h = json['volume_24h'].toDouble();
    percentChange1h = json['percent_change_1h'].toDouble();
    percentChange24h = json['percent_change_24h'].toDouble();
    percentChange7d = json['percent_change_7d'].toDouble();
    percentChange30d = json['percent_change_30d'].toDouble();
    percentChange60d = json['percent_change_60d'].toDouble();
    percentChange90d = json['percent_change_90d'].toDouble();
    marketCap = json['market_cap'].toDouble();
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['volume_24h'] = this.volume24h;
    data['percent_change_1h'] = this.percentChange1h;
    data['percent_change_24h'] = this.percentChange24h;
    data['percent_change_7d'] = this.percentChange7d;
    data['percent_change_30d'] = this.percentChange30d;
    data['percent_change_60d'] = this.percentChange60d;
    data['percent_change_90d'] = this.percentChange90d;
    data['market_cap'] = this.marketCap;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}