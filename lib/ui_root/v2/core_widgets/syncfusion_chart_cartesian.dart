import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:coinsnap/data/model/internal/coin_data/chart/crypto_compare.dart';


class ChartOverall extends StatefulWidget {
  ChartOverall({Key key, this.priceList}) : super(key: key);

  final CryptoCompareHourlyModel priceList;

  @override
  _ChartOverallState createState() => _ChartOverallState();
}

class _ChartOverallState extends State<ChartOverall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),

            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                dataSource:  widget.priceList.salesDataList,
                  // widget.priceList.salesDataList.forEach((v) {
                  //   log("Hello");
                  // }
                
                xValueMapper: ( price, _) => price.time,
                yValueMapper: ( price, _) => price.price,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SalesData {
//   SalesData(this.time, this.price);
//   /// each time interval does separate API calls 30min ticks?
//   final String time;
//   final double price;
// }