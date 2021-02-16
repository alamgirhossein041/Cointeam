import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ContainerSlider extends StatefulWidget {
  ContainerSlider({Key key}) : super(key: key);

  @override
  ContainerSliderState createState() => ContainerSliderState();
}

class ContainerSliderState extends State<ContainerSlider> {

  double _value = 0.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        tooltipBackgroundColor: Colors.red[500],
      ),
      child: SfSlider(
        min: 0.0,
        max: 100.0,
        value: _value,
        interval: 100,
        showTicks: false,
        showLabels: false,
        enableTooltip: true,
        // minorTicksPerInterval: 1,
        onChanged: (dynamic value) {
          setState(() {
            _value = value;
          });
        }
      ),
    );
  }
}