import 'dart:developer';

class FtxGetBalanceModel {
  // Result result;
  Map<String, dynamic> data = {};

  // FtxGetBalanceModel();

  FtxGetBalanceModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      json['result'].forEach((object) {
        data[object['coin']] = FtxCoinData.fromJson(object);
      });
      log(data.toString());
    }
  }
}

class FtxCoinData {
  double available;
  // double free;
  double total;
  double usdValue;

  FtxCoinData({
    this.available,
    this.total,
    this.usdValue
  });

  FtxCoinData.fromJson(Map<String, dynamic> json) {
    available = json['availableWithoutBorrow'] ?? 0;
    total = json['total'] ?? 0;
    usdValue = json['usdValue'] ?? 0;
  }
}




// class FtxGetBalanceModel1{  /// Repository returns 1 of this object which has List result
//   List<Result> result;
//   bool success;

//   FtxGetBalanceModel1({this.result, this.success});

//   FtxGetBalanceModel1.fromJson(Map<String, dynamic> json) {
//     if (json['result'] != null) {
//       result = [];
//       json['result'].forEach((v) {
//         result.add(Result.fromJson(v));
//       });
//     }
//     success = json['success'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result.map((v) => v.toJson()).toList();
//     }
//     data['success'] = this.success;
//     return data;
//   }
// }

// class Result {
//   double availableWithoutBorrow;
//   String coin;
//   double free;
//   double spotBorrow;
//   double total;
//   double usdValue;

//   Result(
//       {this.availableWithoutBorrow,
//       this.coin,
//       this.free,
//       this.spotBorrow,
//       this.total,
//       this.usdValue});

//   Result.fromJson(Map<String, dynamic> json) {
//     availableWithoutBorrow = json['availableWithoutBorrow'];
//     coin = json['coin'];
//     free = json['free'];
//     spotBorrow = json['spotBorrow'];
//     total = json['total'];
//     usdValue = json['usdValue'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['availableWithoutBorrow'] = this.availableWithoutBorrow;
//     data['coin'] = this.coin;
//     data['free'] = this.free;
//     data['spotBorrow'] = this.spotBorrow;
//     data['total'] = this.total;
//     data['usdValue'] = this.usdValue;
//     return data;
//   }
// }