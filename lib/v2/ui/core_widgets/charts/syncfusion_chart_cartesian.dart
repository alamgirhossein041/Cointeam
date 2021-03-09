import 'dart:developer';

import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_state.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/cryptocompare/chart/chart_cryptocompare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';


class ChartOverall extends StatefulWidget {
  ChartOverall({Key key, this.priceList}) : super(key: key);

  final CryptoCompareHourlyModel priceList;

  @override
  _ChartOverallState createState() => _ChartOverallState();
}

class _ChartOverallState extends State<ChartOverall> {
  ZoomPanBehavior _zoomPanBehavior;
  TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
      shouldAlwaysShow: true,
      tooltipSettings: InteractiveTooltip(
        enable: true,
        color: Colors.red,
      ),
      tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      // Performs zooming on double tap & pinching
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
      // enableDoubleTapZooming: true,
      // enableSelectionZooming: true,
      // selectionRectBorderColor: Colors.red,
      // selectionRectBorderWidth: 1,
      // selectionRectColor: 
    );
    super.initState();
  }

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

    return BlocConsumer<BinanceGetChartBloc, BinanceGetChartState>(
      listener: (context, state) {
        if (state is BinanceGetChartErrorState) {
          log("error in GetTotalValueBloc in card_list_container.dart");
        }
      },
      builder: (context, state) {
        if (state is BinanceGetChartInitialState) {
          log("BinanceGetChartInitialState");
          return Container();
        } else if (state is BinanceGetChartLoadingState) {
          log("BinanceGetChartLoadingState");
          return Container();
        } else if (state is BinanceGetChartLoadedState) {
          log("BinanceGetChartLoadedState");
          return SizedBox(
            height: displayHeight(context) * 0.27,
            child: Scaffold(
              body: Center(
                child: Container(
                  child: SfCartesianChart(
                    zoomPanBehavior: _zoomPanBehavior,
                    trackballBehavior: _trackballBehavior,
                    /// Hack to render x axis (hourly labels) cleanly without messing up data points
                    /// https://www.syncfusion.com/forums/160066/display-minsecmillisec-on-y-axis /// Switch y and x
                    onAxisLabelRender: (args) {
                      log((args.text).toString());
                      if (args.axisName == 'primaryXAxis') {
                        args.text = 
                          DateFormat.j().format(DateTime.fromMillisecondsSinceEpoch((double.parse(args.text)*1000).toInt()));
                          // DateTime.fromMillisecondsSinceEpoch((double.parse(args.text) * 1000).toInt()).hour.toString() +
                          // ':' +
                          // DateTime.fromMillisecondsSinceEpoch((double.parse(args.text) * 1000).toInt()).minute.toStringAsFixed();
                      }
                    },
                    // Initialize category axis
                    backgroundColor: appBlack,

                    primaryXAxis: CategoryAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      // isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      // isVisible: false,
                    ),
                    

                    // series: <LineSeries<SalesData, String>>[
                    //   LineSeries<SalesData, String>(
                    //     // Bind data source
                        series: <ChartSeries> [
                          AreaSeries<SalesData, String> (
                        
                        // dataSource:  widget.priceList.salesDataList,
                        dataSource: state.binanceGetChartDataList,
                          // widget.priceList.salesDataList.forEach((v) {
                          //   log("Hello");
                          // }
                        
                        xValueMapper: ( price, _) => price.time.toString(),
                        // xValueMapper: ( price, _) => (DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(price.time)*1000))).toString(),
                        // xValueMapper: ( price, _) => DateTime.fromMillisecondsSinceEpoch(int.parse(price.time)*1000).toString(),
                        yValueMapper: ( price, _) => price.price,
                        gradient: gradientColors,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false, color: Colors.white)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      }
    );

    // return Scaffold(
    //   body: Center(
    //     child: Container(
    //       child: SfCartesianChart(
    //         zoomPanBehavior: _zoomPanBehavior,
    //         trackballBehavior: _trackballBehavior,
    //         /// Hack to render x axis (hourly labels) cleanly without messing up data points
    //         /// https://www.syncfusion.com/forums/160066/display-minsecmillisec-on-y-axis /// Switch y and x
    //         onAxisLabelRender: (args) {
    //           log((args.text).toString());
    //           if (args.axisName == 'primaryXAxis') {
    //             args.text = 
    //               DateFormat.j().format(DateTime.fromMillisecondsSinceEpoch((double.parse(args.text)*1000).toInt()));
    //               // DateTime.fromMillisecondsSinceEpoch((double.parse(args.text) * 1000).toInt()).hour.toString() +
    //               // ':' +
    //               // DateTime.fromMillisecondsSinceEpoch((double.parse(args.text) * 1000).toInt()).minute.toStringAsFixed();
    //           }
    //         },
    //         // Initialize category axis
    //         backgroundColor: appBlack,

    //         primaryXAxis: CategoryAxis(
    //           majorGridLines: MajorGridLines(width: 0),
    //           // isVisible: false,
    //         ),
    //         primaryYAxis: NumericAxis(
    //           majorGridLines: MajorGridLines(width: 0),
    //           // isVisible: false,
    //         ),
            

    //         // series: <LineSeries<SalesData, String>>[
    //         //   LineSeries<SalesData, String>(
    //         //     // Bind data source
    //             series: <ChartSeries> [
    //               AreaSeries<SalesData, double> (
                
    //             dataSource:  widget.priceList.salesDataList,
    //               // widget.priceList.salesDataList.forEach((v) {
    //               //   log("Hello");
    //               // }
                
    //             xValueMapper: ( price, _) => double.parse(price.time),
    //             // xValueMapper: ( price, _) => (DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(price.time)*1000))),
    //             // xValueMapper: ( price, _) => DateTime.fromMillisecondsSinceEpoch(int.parse(price.time)*1000).toString(),
    //             yValueMapper: ( price, _) => price.price,
    //             gradient: gradientColors,
    //             // Enable data label
    //             dataLabelSettings: DataLabelSettings(isVisible: false, color: Colors.white)
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

// class SalesData {
//   SalesData(this.time, this.price);
//   /// each time interval does separate API calls 30min ticks?
//   final String time;
//   final double price;
// }