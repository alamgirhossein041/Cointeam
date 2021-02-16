import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartOverall extends StatelessWidget {

  /// example data
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
                dataSource:  <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData price, _) => price.time,
                yValueMapper: (SalesData price, _) => price.price,
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

class SalesData {
  SalesData(this.time, this.price);
  /// each time interval does separate API calls 30min ticks?
  final String time;
  final double price;
}