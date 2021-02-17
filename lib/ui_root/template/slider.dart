import 'dart:developer';

import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/bloc/logic/sell_portfolio_bloc/sell_portfolio_event.dart';
import 'package:coinsnap/resource/colors_helper.dart';
import 'package:coinsnap/resource/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:menu_button/menu_button.dart';

class ContainerSlider extends StatefulWidget {
  ContainerSlider({Key key}) : super(key: key);

  @override
  ContainerSliderState createState() => ContainerSliderState();
}

class ContainerSliderState extends State<ContainerSlider> {
  String selectedKey;
  double _value = 0.0;
  @override
  void initState() {
    selectedKey = "BTC";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget button = Container(
      decoration: BoxDecoration(
        color: Colors.blue[300],
        // border: Border.all(color: Colors.blue[300]),
        // borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 93,
      height: 31,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                selectedKey,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Row(
      children: <Widget> [
        SizedBox(width: displayWidth(context) * 0.07),
        Container(
          width: displayWidth(context) * 0.22, // items: ["BTC", "ETH", "USDT", "DOGE"],
          child: MenuButton(
            child: button,// Widget displayed as the button
            items: ["BTC", "ETH", "USDT", "DOGE"],// List of your items
            topDivider: true,
            popupHeight: 200, // This popupHeight is optional. The default height is the size of items
            scrollPhysics: AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
            itemBuilder: (value) => Container(
              width: 83,
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(value)
            ),// Widget displayed for each item
            toggledChild: Container(
              color: Colors.black,
              child: button,// Widget displayed as the button,
            ),
            divider: Container(
              height: 1,
              color: Colors.blue[900],
            ),
            onItemSelected: (value) {
            setState(() {
              selectedKey = value;
            });
          },
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue[300]),
              borderRadius: const BorderRadius.all(Radius.circular(3.0)),
              color: Colors.blue[300]
            ),
            onMenuButtonToggle: (isToggle) {
              print(isToggle);
              log(isToggle.toString());
            },
          ),
        ),
        SizedBox(width: displayWidth(context) * 0.05),
           
        
        //   child: SizedBox(
        //     // width: displayWidth(context) * 0.12,
        //     child: Center(
        //       child: DropdownSearch<String>(
        //         mode: Mode.MENU,
        //         showSelectedItem: true,
        //         items: ["BTC", "USDT", "ETH", "DOGE"],
        //         // label: "Menu mode",
        //         hint: "country in menu mode",
        //         popupItemDisabled: (String s) => s.startsWith('I'),
        //         onChanged: print,
        //         selectedItem: "BTC"),
        //     ),
        //   ),
        // ),
        Container(
          // child: Positioned(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: 
                MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.green;
                    return Colors.deepOrange[700]; // Use the component's default.
                  },
                ),
              ),
              child: Text("Sell All"),
              onPressed: () {
                BlocProvider.of<SellPortfolioBloc>(context).add(FetchSellPortfolioEvent(value: _value, coinTicker: selectedKey));
              },
            // ),
            // right: 0,
            // left: 0,
            // bottom: 50,
          ),
        ),
        Container(
          width: displayWidth(context) * 0.33,
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
              // minorTicksPerInterval: 1,
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                });
              }
            ),
          ),
        ),
      ],
    );
  }
}
