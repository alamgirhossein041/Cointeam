class GlobalCoinmarketcapStatsModel {
  Status status;
  Data data;

  GlobalCoinmarketcapStatsModel({this.status, this.data});

  GlobalCoinmarketcapStatsModel.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Status {
  String timestamp;
  int errorCode;
  Null errorMessage;
  int elapsed;
  int creditCount;
  Null notice;

  Status(
      {this.timestamp,
      this.errorCode,
      this.errorMessage,
      this.elapsed,
      this.creditCount,
      this.notice});

  Status.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    errorCode = json['error_code'];
    errorMessage = json['error_message'];
    elapsed = json['elapsed'];
    creditCount = json['credit_count'];
    notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['error_code'] = this.errorCode;
    data['error_message'] = this.errorMessage;
    data['elapsed'] = this.elapsed;
    data['credit_count'] = this.creditCount;
    data['notice'] = this.notice;
    return data;
  }
}

class Data {
  int activeCryptocurrencies;
  int totalCryptocurrencies;
  int activeMarketPairs;
  int activeExchanges;
  int totalExchanges;
  double ethDominance;
  double btcDominance;
  double defiVolume24h;
  double defiVolume24hReported;
  double defiMarketCap;
  double defi24hPercentageChange;
  double stablecoinVolume24h;
  double stablecoinVolume24hReported;
  double stablecoinMarketCap;
  double stablecoin24hPercentageChange;
  double derivativesVolume24h;
  double derivativesVolume24hReported;
  double derivatives24hPercentageChange;
  Quote quote;
  String lastUpdated;

  Data(
      {this.activeCryptocurrencies,
      this.totalCryptocurrencies,
      this.activeMarketPairs,
      this.activeExchanges,
      this.totalExchanges,
      this.ethDominance,
      this.btcDominance,
      this.defiVolume24h,
      this.defiVolume24hReported,
      this.defiMarketCap,
      this.defi24hPercentageChange,
      this.stablecoinVolume24h,
      this.stablecoinVolume24hReported,
      this.stablecoinMarketCap,
      this.stablecoin24hPercentageChange,
      this.derivativesVolume24h,
      this.derivativesVolume24hReported,
      this.derivatives24hPercentageChange,
      this.quote,
      this.lastUpdated});

  Data.fromJson(Map<String, dynamic> json) {
    activeCryptocurrencies = json['active_cryptocurrencies'];
    totalCryptocurrencies = json['total_cryptocurrencies'];
    activeMarketPairs = json['active_market_pairs'];
    activeExchanges = json['active_exchanges'];
    totalExchanges = json['total_exchanges'];
    ethDominance = json['eth_dominance'].toDouble();
    btcDominance = json['btc_dominance'].toDouble();
    defiVolume24h = json['defi_volume_24h'].toDouble();
    defiVolume24hReported = json['defi_volume_24h_reported'].toDouble();
    defiMarketCap = json['defi_market_cap'].toDouble();
    defi24hPercentageChange = json['defi_24h_percentage_change'].toDouble();
    stablecoinVolume24h = json['stablecoin_volume_24h'].toDouble();
    stablecoinVolume24hReported = json['stablecoin_volume_24h_reported'].toDouble();
    stablecoinMarketCap = json['stablecoin_market_cap'].toDouble();
    stablecoin24hPercentageChange = json['stablecoin_24h_percentage_change'].toDouble();
    derivativesVolume24h = json['derivatives_volume_24h'].toDouble();
    derivativesVolume24hReported = json['derivatives_volume_24h_reported'].toDouble();
    derivatives24hPercentageChange = json['derivatives_24h_percentage_change'].toDouble();
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_cryptocurrencies'] = this.activeCryptocurrencies;
    data['total_cryptocurrencies'] = this.totalCryptocurrencies;
    data['active_market_pairs'] = this.activeMarketPairs;
    data['active_exchanges'] = this.activeExchanges;
    data['total_exchanges'] = this.totalExchanges;
    data['eth_dominance'] = this.ethDominance;
    data['btc_dominance'] = this.btcDominance;
    data['defi_volume_24h'] = this.defiVolume24h;
    data['defi_volume_24h_reported'] = this.defiVolume24hReported;
    data['defi_market_cap'] = this.defiMarketCap;
    data['defi_24h_percentage_change'] = this.defi24hPercentageChange;
    data['stablecoin_volume_24h'] = this.stablecoinVolume24h;
    data['stablecoin_volume_24h_reported'] = this.stablecoinVolume24hReported;
    data['stablecoin_market_cap'] = this.stablecoinMarketCap;
    data['stablecoin_24h_percentage_change'] =
        this.stablecoin24hPercentageChange;
    data['derivatives_volume_24h'] = this.derivativesVolume24h;
    data['derivatives_volume_24h_reported'] = this.derivativesVolume24hReported;
    data['derivatives_24h_percentage_change'] =
        this.derivatives24hPercentageChange;
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    data['last_updated'] = this.lastUpdated;
    return data;
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
  double totalMarketCap;
  double totalVolume24h;
  double totalVolume24hReported;
  double altcoinVolume24h;
  double altcoinVolume24hReported;
  double altcoinMarketCap;
  String lastUpdated;

  USD(
      {this.totalMarketCap,
      this.totalVolume24h,
      this.totalVolume24hReported,
      this.altcoinVolume24h,
      this.altcoinVolume24hReported,
      this.altcoinMarketCap,
      this.lastUpdated});

  USD.fromJson(Map<String, dynamic> json) {
    totalMarketCap = json['total_market_cap'].toDouble();
    totalVolume24h = json['total_volume_24h'].toDouble();
    totalVolume24hReported = json['total_volume_24h_reported'].toDouble();
    altcoinVolume24h = json['altcoin_volume_24h'].toDouble();
    altcoinVolume24hReported = json['altcoin_volume_24h_reported'].toDouble();
    altcoinMarketCap = json['altcoin_market_cap'].toDouble();
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_market_cap'] = this.totalMarketCap;
    data['total_volume_24h'] = this.totalVolume24h;
    data['total_volume_24h_reported'] = this.totalVolume24hReported;
    data['altcoin_volume_24h'] = this.altcoinVolume24h;
    data['altcoin_volume_24h_reported'] = this.altcoinVolume24hReported;
    data['altcoin_market_cap'] = this.altcoinMarketCap;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}