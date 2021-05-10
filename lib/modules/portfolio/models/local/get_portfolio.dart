class GetPortfolioModel {
  Map<String, dynamic> data = {};

  GetPortfolioModel({this.data});

  GetPortfolioModel.fromJson(json) {
    json.forEach((k,v) {
      data[k] = v;
    });
  }
}