// import 'package:coinsnap/bloc/logic/get_price_info_bloc/get_price_info_bloc.dart';
// import 'package:coinsnap/resource/colors_helper.dart';
// import 'package:coinsnap/resource/sizes_helper.dart';
// import 'package:coinsnap/test/testjson/test_crypto_json.dart';
// import 'package:coinsnap/ui/template/small/card/.dart';
// import 'package:flutter/material.dart';

// class PortfolioListView extends StatelessWidget {

//   var cryptoData = CryptoData.getData;

//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       child: Column (
//         children: <Widget> [
//           Container(
//             child: SizedBox(
//               height: displayHeight(context) * 0.35,
//               width: displayWidth(context),
//               child: ListView.builder(
//                 itemCount: cryptoData.length,
//                 itemBuilder: (context, index) {
//                   return PortfolioListTile(cryptoData, index);
//                 }
//               ),
//             ),
//           ),
//         ]
//       ),
//       // child: PortfolioListTile(cryptoData),
//       // decoration: BoxDecoration(
//       //   gradient: LinearGradient(
//     );
//   }
// }