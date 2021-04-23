class BinanceExchangeInfoModel {  /// Repository returns 1 of this object which has List result
  String timezone;
  int serverTime;
  List<RateLimits> rateLimits;
  List<Null> exchangeFilters;
  List<Symbols> symbols;

  BinanceExchangeInfoModel(
      {this.timezone,
      this.serverTime,
      this.rateLimits,
      this.exchangeFilters,
      this.symbols});

  BinanceExchangeInfoModel.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    serverTime = json['serverTime'];
    if (json['rateLimits'] != null) {
      rateLimits = [];
      json['rateLimits'].forEach((v) {
        rateLimits.add(RateLimits.fromJson(v));
      });
    }
    if (json['exchangeFilters'] != null) {
      exchangeFilters = [];
    }
    if (json['symbols'] != null) {
      symbols = [];
      json['symbols'].forEach((v) {
        symbols.add(Symbols.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['timezone'] = this.timezone;
    data['serverTime'] = this.serverTime;
    if (this.rateLimits != null) {
      data['rateLimits'] = this.rateLimits.map((v) => v.toJson()).toList();
    }
    if (this.symbols != null) {
      data['symbols'] = this.symbols.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RateLimits {
  String rateLimitType;
  String interval;
  int intervalNum;
  int limit;

  RateLimits({this.rateLimitType, this.interval, this.intervalNum, this.limit});

  RateLimits.fromJson(Map<String, dynamic> json) {
    rateLimitType = json['rateLimitType'];
    interval = json['interval'];
    intervalNum = json['intervalNum'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rateLimitType'] = this.rateLimitType;
    data['interval'] = this.interval;
    data['intervalNum'] = this.intervalNum;
    data['limit'] = this.limit;
    return data;
  }
}

class Symbols {
  String symbol;
  String status;
  String baseAsset;
  int baseAssetPrecision;
  String quoteAsset;
  int quotePrecision;
  int quoteAssetPrecision;
  int baseCommissionPrecision;
  int quoteCommissionPrecision;
  List<String> orderTypes;
  bool icebergAllowed;
  bool ocoAllowed;
  bool quoteOrderQtyMarketAllowed;
  bool isSpotTradingAllowed;
  bool isMarginTradingAllowed;
  List<Filters> filters;
  List<String> permissions;

  Symbols(
      {this.symbol,
      this.status,
      this.baseAsset,
      this.baseAssetPrecision,
      this.quoteAsset,
      this.quotePrecision,
      this.quoteAssetPrecision,
      this.baseCommissionPrecision,
      this.quoteCommissionPrecision,
      this.orderTypes,
      this.icebergAllowed,
      this.ocoAllowed,
      this.quoteOrderQtyMarketAllowed,
      this.isSpotTradingAllowed,
      this.isMarginTradingAllowed,
      this.filters,
      this.permissions});

  Symbols.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    status = json['status'];
    baseAsset = json['baseAsset'];
    baseAssetPrecision = json['baseAssetPrecision'];
    quoteAsset = json['quoteAsset'];
    quotePrecision = json['quotePrecision'];
    quoteAssetPrecision = json['quoteAssetPrecision'];
    baseCommissionPrecision = json['baseCommissionPrecision'];
    quoteCommissionPrecision = json['quoteCommissionPrecision'];
    orderTypes = json['orderTypes'].cast<String>();
    icebergAllowed = json['icebergAllowed'];
    ocoAllowed = json['ocoAllowed'];
    quoteOrderQtyMarketAllowed = json['quoteOrderQtyMarketAllowed'];
    isSpotTradingAllowed = json['isSpotTradingAllowed'];
    isMarginTradingAllowed = json['isMarginTradingAllowed'];
    if (json['filters'] != null) {
      filters = [];
      json['filters'].forEach((v) {
        filters.add(Filters.fromJson(v));
      });
    }
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['status'] = this.status;
    data['baseAsset'] = this.baseAsset;
    data['baseAssetPrecision'] = this.baseAssetPrecision;
    data['quoteAsset'] = this.quoteAsset;
    data['quotePrecision'] = this.quotePrecision;
    data['quoteAssetPrecision'] = this.quoteAssetPrecision;
    data['baseCommissionPrecision'] = this.baseCommissionPrecision;
    data['quoteCommissionPrecision'] = this.quoteCommissionPrecision;
    data['orderTypes'] = this.orderTypes;
    data['icebergAllowed'] = this.icebergAllowed;
    data['ocoAllowed'] = this.ocoAllowed;
    data['quoteOrderQtyMarketAllowed'] = this.quoteOrderQtyMarketAllowed;
    data['isSpotTradingAllowed'] = this.isSpotTradingAllowed;
    data['isMarginTradingAllowed'] = this.isMarginTradingAllowed;
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    data['permissions'] = this.permissions;
    return data;
  }
}

class Filters {
  String filterType;
  String minPrice;
  String maxPrice;
  String tickSize;
  String multiplierUp;
  String multiplierDown;
  int avgPriceMins;
  String minQty;
  String maxQty;
  String stepSize;
  String minNotional;
  bool applyToMarket;
  int limit;
  int maxNumOrders;
  int maxNumAlgoOrders;

  Filters(
      {this.filterType,
      this.minPrice,
      this.maxPrice,
      this.tickSize,
      this.multiplierUp,
      this.multiplierDown,
      this.avgPriceMins,
      this.minQty,
      this.maxQty,
      this.stepSize,
      this.minNotional,
      this.applyToMarket,
      this.limit,
      this.maxNumOrders,
      this.maxNumAlgoOrders});

  Filters.fromJson(Map<String, dynamic> json) {
    filterType = json['filterType'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    tickSize = json['tickSize'];
    multiplierUp = json['multiplierUp'];
    multiplierDown = json['multiplierDown'];
    avgPriceMins = json['avgPriceMins'];
    minQty = json['minQty'];
    maxQty = json['maxQty'];
    stepSize = json['stepSize'];
    minNotional = json['minNotional'];
    applyToMarket = json['applyToMarket'];
    limit = json['limit'];
    maxNumOrders = json['maxNumOrders'];
    maxNumAlgoOrders = json['maxNumAlgoOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['filterType'] = this.filterType;
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    data['tickSize'] = this.tickSize;
    data['multiplierUp'] = this.multiplierUp;
    data['multiplierDown'] = this.multiplierDown;
    data['avgPriceMins'] = this.avgPriceMins;
    data['minQty'] = this.minQty;
    data['maxQty'] = this.maxQty;
    data['stepSize'] = this.stepSize;
    data['minNotional'] = this.minNotional;
    data['applyToMarket'] = this.applyToMarket;
    data['limit'] = this.limit;
    data['maxNumOrders'] = this.maxNumOrders;
    data['maxNumAlgoOrders'] = this.maxNumAlgoOrders;
    return data;
  }
}