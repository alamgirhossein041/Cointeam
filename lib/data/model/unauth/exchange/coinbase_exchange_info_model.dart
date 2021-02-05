class CoinbaseExchangeInfoModel {  /// Repository returns a List of this model
  String id;
  String baseCurrency;
  String quoteCurrency;
  String baseMinSize;
  String baseMaxSize;
  String quoteIncrement;
  String baseIncrement;
  String displayName;
  String minMarketFunds;
  String maxMarketFunds;
  bool marginEnabled;
  bool postOnly;
  bool limitOnly;
  bool cancelOnly;
  bool tradingDisabled;
  String status;
  String statusMessage;

  CoinbaseExchangeInfoModel(
      {this.id,
      this.baseCurrency,
      this.quoteCurrency,
      this.baseMinSize,
      this.baseMaxSize,
      this.quoteIncrement,
      this.baseIncrement,
      this.displayName,
      this.minMarketFunds,
      this.maxMarketFunds,
      this.marginEnabled,
      this.postOnly,
      this.limitOnly,
      this.cancelOnly,
      this.tradingDisabled,
      this.status,
      this.statusMessage});

  CoinbaseExchangeInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseCurrency = json['base_currency'];
    quoteCurrency = json['quote_currency'];
    baseMinSize = json['base_min_size'];
    baseMaxSize = json['base_max_size'];
    quoteIncrement = json['quote_increment'];
    baseIncrement = json['base_increment'];
    displayName = json['display_name'];
    minMarketFunds = json['min_market_funds'];
    maxMarketFunds = json['max_market_funds'];
    marginEnabled = json['margin_enabled'];
    postOnly = json['post_only'];
    limitOnly = json['limit_only'];
    cancelOnly = json['cancel_only'];
    tradingDisabled = json['trading_disabled'];
    status = json['status'];
    statusMessage = json['status_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['base_currency'] = this.baseCurrency;
    data['quote_currency'] = this.quoteCurrency;
    data['base_min_size'] = this.baseMinSize;
    data['base_max_size'] = this.baseMaxSize;
    data['quote_increment'] = this.quoteIncrement;
    data['base_increment'] = this.baseIncrement;
    data['display_name'] = this.displayName;
    data['min_market_funds'] = this.minMarketFunds;
    data['max_market_funds'] = this.maxMarketFunds;
    data['margin_enabled'] = this.marginEnabled;
    data['post_only'] = this.postOnly;
    data['limit_only'] = this.limitOnly;
    data['cancel_only'] = this.cancelOnly;
    data['trading_disabled'] = this.tradingDisabled;
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    return data;
  }
}