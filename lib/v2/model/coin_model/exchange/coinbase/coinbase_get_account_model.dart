class CoinbaseGetAccountModel {  /// Repository not implemented yet
  String id;
  String currency;
  String balance;
  String available;
  String hold;
  String profileId;
  bool tradingEnabled;

  CoinbaseGetAccountModel(
      {this.id,
      this.currency,
      this.balance,
      this.available,
      this.hold,
      this.profileId,
      this.tradingEnabled});

  CoinbaseGetAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    balance = json['balance'];
    available = json['available'];
    hold = json['hold'];
    profileId = json['profile_id'];
    tradingEnabled = json['trading_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['currency'] = this.currency;
    data['balance'] = this.balance;
    data['available'] = this.available;
    data['hold'] = this.hold;
    data['profile_id'] = this.profileId;
    data['trading_enabled'] = this.tradingEnabled;
    return data;
  }
}