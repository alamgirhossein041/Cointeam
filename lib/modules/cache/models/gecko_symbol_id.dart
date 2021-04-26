class GeckoSymbolIdMap {
  Map<String, dynamic> data;

	GeckoSymbolIdMap({this.data});

	GeckoSymbolIdMap.fromJson(List json) {
    /// Iterates through list of json objects and
    /// creates symbol: id mapping
    json.forEach((v) {
      if(data[v['symbol']] == null) {
        data[v['symbol']] = v['id'];
      } else {
        /// Replaces id -> list of id instead
        /// if multiple coins share the same symbol
        List tmp = [];
        tmp.add(data[v['symbol']]);
        tmp.add(v['id']);
        data[v['symbol']] = tmp;
      }
    });
	}
}