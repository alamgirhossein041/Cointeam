class CoingeckoListTop100Model {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  double marketCap;
  double marketCapRank;
  // int fullyDilutedValuation;
  // int totalVolume;
  // int high24h;
  // int low24h;
  double priceChange24h;
  double priceChangePercentage24h;
  // int marketCapChange24h;
  // double marketCapChangePercentage24h;
  double circulatingSupply;
  double totalSupply;
  // int maxSupply;
  double ath;
  // double athChangePercentage;
  String athDate;
  double atl;
  // double atlChangePercentage;
  String atlDate;
  // Null roi;
  String lastUpdated;
  double priceChangePercentage1hInCurrency;
  double priceChangePercentage24hInCurrency;
  double priceChangePercentage7dInCurrency;

  CoingeckoListTop100Model(
      {this.id,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.marketCap,
      this.marketCapRank,
      // this.fullyDilutedValuation,
      // this.totalVolume,
      // this.high24h,
      // this.low24h,
      this.priceChange24h,
      this.priceChangePercentage24h,
      // this.marketCapChange24h,
      // this.marketCapChangePercentage24h,
      this.circulatingSupply,
      this.totalSupply,
      // this.maxSupply,
      this.ath,
      // this.athChangePercentage,
      this.athDate,
      this.atl,
      // this.atlChangePercentage,
      this.atlDate,
      // this.roi,
      this.lastUpdated,
      this.priceChangePercentage1hInCurrency,
      this.priceChangePercentage24hInCurrency,
      this.priceChangePercentage7dInCurrency});

  CoingeckoListTop100Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'].toUpperCase();
    name = json['name'];
    image = json['image'];
    if (json['current_price'] != null) {
      currentPrice = json['current_price'].toDouble();
    }
    if (json['market_cap'] != null) {
      marketCap = json['market_cap'].toDouble();
    }
    if (json['market_cap_rank'] != null) {
      marketCapRank = json['market_cap_rank'].toDouble();
    }
    if (json['circulating_supply'] != null) {
      circulatingSupply = json['circulating_supply'].toDouble();
    }
    if (json['total_supply'] != null) {
      totalSupply = json['total_supply'].toDouble();
    }
    if (json['ath'] != null) {
      ath = json['ath'].toDouble();
    }

    
    
    
    // fullyDilutedValuation = json['fully_diluted_valuation'];
    // totalVolume = json['total_volume'];
    // high24h = json['high_24h'];
    // low24h = json['low_24h'];
    // priceChange24h = json['price_change_24h'];
    if (json['price_change_percentage_24h'] != null) {
      priceChangePercentage24h = json['price_change_percentage_24h'].toDouble();
    }
    // marketCapChange24h = json['market_cap_change_24h'];
    // marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];
    
    
    // maxSupply = json['max_supply'];
    
    // athChangePercentage = json['ath_change_percentage'];
    athDate = json['ath_date'];
    if (json['atl'] != null) {
      atl = json['atl'].toDouble();
    }
    // atlChangePercentage = json['atl_change_percentage'];
    atlDate = json['atl_date'];
    // roi = json['roi'];
    lastUpdated = json['last_updated'];
    if (json['price_change_24h'] != null) {
      priceChange24h = json['price_change_24h'].toDouble();
    }
    if (json['price_change_percentage_1h_in_currency'] != null) {
      priceChangePercentage1hInCurrency = json['price_change_percentage_1h_in_currency'].toDouble();
    }
    if (json['price_change_percentage_7d_in_currency'] != null) {
      priceChangePercentage7dInCurrency = json['price_change_percentage_7d_in_currency'].toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap'] = this.marketCap;
    data['market_cap_rank'] = this.marketCapRank;
    // data['fully_diluted_valuation'] = this.fullyDilutedValuation;
    // data['total_volume'] = this.totalVolume;
    // data['high_24h'] = this.high24h;
    // data['low_24h'] = this.low24h;
    // data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    // data['market_cap_change_24h'] = this.marketCapChange24h;
    data['market_cap_change_percentage_24h'] =
        // this.marketCapChangePercentage24h;
    data['circulating_supply'] = this.circulatingSupply;
    data['total_supply'] = this.totalSupply;
    // data['max_supply'] = this.maxSupply;
    data['ath'] = this.ath;
    // data['ath_change_percentage'] = this.athChangePercentage;
    data['ath_date'] = this.athDate;
    data['atl'] = this.atl;
    // data['atl_change_percentage'] = this.atlChangePercentage;
    data['atl_date'] = this.atlDate;
    // data['roi'] = this.roi;
    data['last_updated'] = this.lastUpdated;
    data['price_change_percentage_1h_in_currency'] =
        this.priceChangePercentage1hInCurrency;
    data['price_change_percentage_24h_in_currency'] =
        this.priceChangePercentage24hInCurrency;
    data['price_change_percentage_7d_in_currency'] =
        this.priceChangePercentage7dInCurrency;
    return data;
  }
}