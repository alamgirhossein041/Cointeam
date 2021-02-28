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

    final List<Color> color = <Color>[];
        color.add(Colors.blue[50]);
        color.add(Colors.blue[200]);
        color.add(Colors.blue);

        final List<double> stops = <double>[];
        stops.add(0.0);
        stops.add(0.5);
        stops.add(1.0);

        final LinearGradient gradientColors =
            LinearGradient(colors: color, stops: stops);

   return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            // Initialize category axis
            backgroundColor: appBlack,

            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              // isVisible: false,
            ),
            primaryYAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              // isVisible: false,
            ),

            // series: <LineSeries<SalesData, String>>[
            //   LineSeries<SalesData, String>(
            //     // Bind data source
                series: <ChartSeries> [
                  AreaSeries<SalesData, double> (
                
                dataSource:  widget.priceList.salesDataList,
                  // widget.priceList.salesDataList.forEach((v) {
                  //   log("Hello");
                  // }
                
                xValueMapper: ( price, _) => double.parse(price.time),
                yValueMapper: ( price, _) => price.price,
                gradient: gradientColors,
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