import 'package:coinsnap/v1/bloc/logic/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v1/bloc/logic/get_total_value_bloc/get_total_value_event.dart';
import 'package:coinsnap/v1/bloc/logic/get_total_value_bloc/get_total_value_state.dart';
import 'package:coinsnap/v1/ui_root/template/loading.dart';
import 'package:coinsnap/v1/ui_root/template/slider.dart';
import 'package:coinsnap/v2/helpers/colors_helper.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'dart:developer';

class PriceContainer extends StatefulWidget {
  PriceContainer({Key key}) : super(key: key);

  @override
  PriceContainerState createState() => PriceContainerState();
}

class PriceContainerState extends State<PriceContainer> {

  GetTotalValueBloc getTotalValueBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    log("PRINT ME TWICE (PRICE_CONTAINER)");
    getTotalValueBloc = BlocProvider.of<GetTotalValueBloc>(context);
    getTotalValueBloc.add(FetchGetTotalValueEvent());
    super.didChangeDependencies();
  }

  double _height = 125.0;
  Widget _widget = Container();

  @override
  Widget build(BuildContext context) {
    
    double tmpBtcSpecial = 0;
    // double _value = 40.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, appPurple],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: displayWidth(context) * 0.85,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                child: IconButton(
                  icon: Icon(Icons.flag),
                  onPressed: () {
                    setState(() {
                      _height = displayHeight(context) * 0.17;
                      _widget = ContainerSlider();
                    });
                  }
                ),
              ),
            ),
            Column(
              children: <Widget> [
                AnimatedContainer(
                  duration: Duration(seconds: 2),
                  // height: displayHeight(context) * 0.17,
                  height: _height,
                  width: displayWidth(context) * 0.65,
                  child: BlocListener<GetTotalValueBloc, GetTotalValueState>(
                    listener: (context, state) {
                      if (state is GetTotalValueErrorState) {
                        log("error in GetTotalValueErrorState in price_container.dart");
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text(state.errorMessage)),
                        // );
                      }
                    },
                    child: BlocBuilder<GetTotalValueBloc, GetTotalValueState>( /// Both bloc types to be built (refactor existing controllers)
                      builder: (context, state) {
                        if (state is GetTotalValueInitialState) {
                          log("GetTotalValueInitialState");
                          return buildLoadingTemplate();
                        } else if (state is GetTotalValueLoadingState) {
                          log("GetTotalValueLoadingState");
                          // return buildLoadingTemplate();
                          // return buildGetTotalValue(tmpTotalValue, tmpBtcSpecial);
                          return buildGetTotalValue(0, 0);
                        } else if (state is GetTotalValueLoadedState) {
                          log("GetTotalValueLoadedState");
                          // tmpTotalValue = state.totalValue;
                          tmpBtcSpecial = state.btcSpecial;
                          return Container(
                            child: buildGetTotalValue(state.totalValue, state.btcSpecial)
                            // child: Row(
                            //   children: <Widget> [
                            //     // SizedBox(width: displayWidth(context) * 0.1),
                            //     buildGetTotalValue(state.totalValue, state.btcSpecial),
                            //     Column( /// refactor into a function like buildGetTotalValue
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.end,
                            //       children: <Widget> [
                            //         buildTicker(context, tmpBtcSpecial),
                            //       ]
                            //     ),
                            //   ]
                            // ),
                          );
                        } else if (state is GetTotalValueErrorState) {
                          log("GetTotalValueErrorState");
                          return buildErrorTemplate(state.errorMessage);
                        } else {
                          return null;
                        }
                      }
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 2),
                  width: displayWidth(context) * 0.65,
                  height: displayHeight(context) * 0.03,
                  // child: ContainerSlider(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget> [
                      Positioned(
                        left: -40,
                        child: _widget,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
          // child: Text("helloWorld"),
    );
  }
    
  Widget buildGetTotalValue(double totalValue, double btcSpecial) {
    // final ValueNotifier<Size> _size = ValueNotifier<Size>(const Size(200.0, 100.0));
    double dollarValue = btcSpecial * totalValue;
    log("Hello World");
    return Stack(
      children: <Widget> [
            // SizedBox(width: displayWidth(context) * 0.22),
        Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Positioned(
              left: 77,
              top: 5,
              child: Column(
                children: <Widget> [
                  SizedBox(height: displayHeight(context) * 0.02),
                  Image(image: AssetImage('graphics/icons/crypto/bitcoin_white_2.png')),  
                  SizedBox(height: displayHeight(context) * 0.015),
                  Text(
                    "B: " + totalValue.toStringAsFixed(8),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    "\$" + dollarValue.toStringAsFixed(2),
                    style: TextStyle(fontSize: 25, color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
            // Container(
            //   alignment: Alignment.topCenter,
            //   child: buildTicker(btcSpecial),
            // ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: <Widget> [
            //     buildTicker(btcSpecial),
            //   ]
            // ),
            ]
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 0,
          child: buildTicker(btcSpecial),
        ),
      ],
    );
  }
  // Widget buildGetTotalValue(double totalValue, double btcSpecial) {
  //   double dollarValue = btcSpecial * totalValue;
  //   return Column(
  //     children: <Widget> [
  //       SizedBox(height: displayHeight(context) * 0.02),
  //       Image(image: AssetImage('graphics/icons/crypto/bitcoin_white_2.png')),  
  //       SizedBox(height: displayHeight(context) * 0.015),
  //       Text(
  //         "B: " + totalValue.toStringAsFixed(8),
  //         style: TextStyle(fontSize: 14, color: Colors.white),
  //       ),
  //       Text(
  //         "\$" + dollarValue.toStringAsFixed(2),
  //         style: TextStyle(fontSize: 25, color: Colors.white,
  //           fontWeight: FontWeight.bold),
  //       ),
  //     ],
  //   );
  // }

  Widget buildTicker(double btcSpecial) { /// refactor into an actual column like buildGetTotalValue()
  log("Hello World");
    bool visibility = true;
    if (btcSpecial != 0.0) {
      visibility = true;
    }
    return Visibility(
      visible: visibility,
      child: Container(
        height: displayHeight(context) * 0.02,
        child: Text("BTC: \$" + btcSpecial.toInt().toString(),
                  style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
  // class CustomLayoutDelegate extends SingleChildLayoutDelegate {
  
  //   CustomLayoutDelegate(this.size) : super(relayout: size);
  
  //   final ValueNotifier<Size> size;
  
  //   @override
  //   Size getSize(BoxConstraints constraints) {
  //     return size.value;
  //   }
  
  //   @override
  //   BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
  //     return BoxConstraints.tight(size.value / 2);
  //   }
  
  //   @override
  //   Offset getPositionForChild(Size size, Size childSize) {
  //     return Offset(size.width / 4, size.height / 4);
  //   }
  
  //   @override
  //   bool shouldRelayout(CustomLayoutDelegate oldDelegate) {
  //     return size != oldDelegate.size;
  //   }
  // }

  