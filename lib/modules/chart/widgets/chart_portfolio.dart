import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_bloc.dart';
import 'package:coinsnap/modules/chart/bloc/portfolio/binance_get_chart_state.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';
import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:coinsnap/modules/utils/global_library.dart' as globals;


class ChartOverall extends StatefulWidget {
  ChartOverall({Key key}) : super(key: key);

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
        color: Colors.black54,
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
    color.add(Colors.deepPurpleAccent[400]);
    color.add(Colors.deepPurpleAccent);
    color.add(Colors.indigoAccent);


    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.4);
    stops.add(1.0);

    final LinearGradient gradientColors =
      LinearGradient(
      colors: color, 
      stops: stops
    );

    // chart body gradient
    // final LinearGradient chartGradient = 
    //   LinearGradient(
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //     colors: [Colors.black.withOpacity(0.0), Colors.deepPurpleAccent.withOpacity(0.3)],
    //     stops: [0.2, 1.0],
    //   );

    return BlocConsumer<BinanceGetChartBloc, BinanceGetChartState>(
      listener: (context, state) {
        if (state is BinanceGetChartErrorState) {
          debugPrint("error in syncfusioncharts");
        }
      },
      builder: (context, state) {
        if (state is BinanceGetChartInitialState) {
          debugPrint("BinanceGetChartInitialState");
          return Container();
        } else if (state is BinanceGetChartLoadingState) {
          debugPrint("BinanceGetChartLoadingState");
          return Container();
        } else if (state is BinanceGetChartLoadedState) {
          debugPrint("BinanceGetChartLoadedState");
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
                      if (args.axisName == 'primaryXAxis') {
                        if(state.timeSelection == globals.Status.weekly) {
                          args.text = 
                            DateFormat.MMMd().format(DateTime.fromMillisecondsSinceEpoch((double.parse(args.text)).toInt()));
                        } else if (state.timeSelection == globals.Status.monthly) {
                          args.text = 
                            DateFormat.MMMd().format(DateTime.fromMillisecondsSinceEpoch((double.parse(args.text)).toInt()));
                        } else if (state.timeSelection == globals.Status.yearly) {
                          args.text = 
                            DateFormat.MMM().format(DateTime.fromMillisecondsSinceEpoch((double.parse(args.text)).toInt()));
                        } else {
                          args.text = 
                            DateFormat.j().format(DateTime.fromMillisecondsSinceEpoch((double.parse(args.text)).toInt()));
                        }
                      }
                    },
                    // Initialize category axis
                    backgroundColor: appBlack,

                    borderWidth: 0,
                    plotAreaBorderWidth: 0,

                    primaryXAxis: CategoryAxis(
                      axisLine: AxisLine(color: Colors.white24, width: 1),
                      labelStyle: TextStyle(color: Colors.white70),
                      majorGridLines: MajorGridLines(width: 0),
                      // isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: AxisLine(color: Colors.white24, width: 1),
                      labelStyle: TextStyle(color: Colors.white70),
                      majorGridLines: MajorGridLines(width: 0),
                      // isVisible: false,
                    ),

                    

                    // series: <LineSeries<SalesData, String>>[
                    //   LineSeries<SalesData, String>(
                    //     // Bind data source
                    series: <ChartSeries> [
                      AreaSeries<SalesData, String> (
                        borderWidth: 1,
                        borderGradient: gradientColors,
                        // uncomment line below to get purple gradient in chart body
                        // gradient: chartGradient,
                        color: Colors.black,

                        // dataSource:  widget.priceList.salesDataList,
                        dataSource: state.binanceGetChartDataList,
                        
                        xValueMapper: ( price, _) => price.time.toString(),
                        yValueMapper: ( price, _) => price.price,
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
  }
}