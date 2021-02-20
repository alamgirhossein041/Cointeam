class FirestoreGetUserDataModel {
  Map portfolioMap;

  FirestoreGetUserDataModel({this.portfolioMap});

  FirestoreGetUserDataModel.fromJson(Map<String, dynamic> json) {
    portfolioMap = json['PortfolioMap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['PortfolioMap'] = this.portfolioMap;
    return data;
  }
}