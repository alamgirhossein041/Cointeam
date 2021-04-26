import 'dart:developer';

class GeckoGlobalStats {
  Map<String, dynamic> totalMarketCap;
  Map<String, dynamic> totalMarketCapPct;

  GeckoGlobalStats({this.totalMarketCap, this.totalMarketCapPct});

  GeckoGlobalStats.fromJson(Map<String, dynamic> json) {
		totalMarketCap = json['data']['total_market_cap'];
    totalMarketCapPct = json['data']['market_cap_percentage'];
	}
}