import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/cryptocompare/chart/chart_cryptocompare.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


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
            backgroundColor: appBlack,
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
                dataLabelSettings: DataLabelSettings(isVisible: false, color: Colors.white)
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