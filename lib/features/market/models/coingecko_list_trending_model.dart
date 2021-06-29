class CoingeckoListTrendingModel {
  String id;
  int coinId;
  String name;
  String symbol;
  int marketCapRank;
  String thumb;
  String small;
  String large;
  String image;
  String slug;
  double priceBtc;
  int score;


  CoingeckoListTrendingModel(
      {this.id,
      this.coinId,
      this.symbol,
      this.name,    
      this.marketCapRank,
      this.thumb,
      this.small,
      this.large,
      this.image,
      this.slug,
      this.priceBtc,
      this.score});

  CoingeckoListTrendingModel.fromJson(Map<String, dynamic> json) {
    id = json['item']['id'];
    symbol = json['item']['symbol'].toUpperCase();
    name = json['item']['name'];
    coinId = json['item']['coin_id'];
    thumb = json['item']['thumb'];
    small = json['item']['small'];
    large = json['item']['large'];
    image = json['item']['large'];
    slug = json['item']['slug'];
    priceBtc = json['item']['price_btc'];
    score = json['item']['score'];
  }
}