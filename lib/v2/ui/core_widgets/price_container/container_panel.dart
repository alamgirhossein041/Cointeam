import 'package:coinsnap/v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ContainerPanel extends StatefulWidget {
  ContainerPanel({Key key, this.panelVisibility}) : super(key: key);
  final bool panelVisibility;

  @override
  _ContainerPanelState createState() => _ContainerPanelState();
}

class _ContainerPanelState extends State<ContainerPanel> {

  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        child: Column(
         children: <Widget> [
           SizedBox(height: displayHeight(context) * 0.035),
           Row(
             /// ### Insert some logic getting value of portfolio divided by slider value ### ///
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget> [
               Padding(
                 padding: EdgeInsets.only(left: 30),
                 child: Text("Price", style: TextStyle(fontSize: 20, color: Colors.white)),
               ),
               Padding(
                 padding: EdgeInsets.only(right: 30),
                 child: Text("\$3,616.62", style: TextStyle(fontSize: 20, color: Colors.white)),
               ),               
             ],
           ),
           Row(
             children: <Widget> [
              Padding(
                padding: EdgeInsets.fromLTRB(20,10,0,0),
                child: Container(
                  width: displayWidth(context) * 0.60,
                  child: SfSliderTheme(
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
                      onChanged: (dynamic value) {
                        setState(() {
                          _value = value;
                        });
                      }
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,10,10,0),
                child: Container(
                  height: displayHeight(context) * 0.035,
                  width: displayWidth(context) * 0.09,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: _value.toString(),
                      labelStyle: TextStyle(color: Colors.white),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // filled: true,
                      // fillColor: Color(0xFF126FFF),
                      enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                      ),  
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<SellPortfolioBloc>(context).add(FetchSellPortfolioEvent(value: _value));
                    },
                    child: Text("Sell All"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Container(
                  // child: MenuButton(
                  //   child: 
                  //   itemBuilder:
                  //   items:
                  // ),
                ),
              ),
            ],
          ),
          SizedBox(),
          ]
        ),
        visible: widget.panelVisibility,
      ),
    );
  }
}




class ScalingAnimatedContainer extends StatefulWidget {
  ScalingAnimatedContainer({Key key, this.visibility}) : super(key: key);
  final bool visibility;

  @override
  _ScalingAnimatedContainerState createState() => _ScalingAnimatedContainerState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _ScalingAnimatedContainerState extends State<ScalingAnimatedContainer>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScaleTransition(
      scale: _animation,
      child: ContainerPanel(panelVisibility: widget.visibility),
    ));
  }
}
