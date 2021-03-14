import 'package:carousel_slider/carousel_slider.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/modal_widgets/link_api_helper_modal.dart';
import 'package:flutter/material.dart';

class CarouselDemo extends StatelessWidget {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connect API"),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: [
              //1st page - Explainer
              Container(
                margin: EdgeInsets.all(5.0),
                child: LinkAPIHelperModal(page: 1),
              ),

              //2nd Connect exchange
              Container(
                margin: EdgeInsets.all(5.0),
                child: LinkAPIHelperModal(page: 2),
              ),

              //3rd Image of Slider
              Container(
                margin: EdgeInsets.all(5.0),
                child: LinkAPIHelperModal(page: 3),
              ),

              //4th Image of Slider
              Container(
                margin: EdgeInsets.all(5.0),
                child: LinkAPIHelperModal(page: 4),
              ),

              //5th Image of Slider
              Container(
                margin: EdgeInsets.all(5.0),
                child: LinkAPIHelperModal(page: 5),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: displayHeight(context) * 0.87,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
          ),
        ],
      ),
    );
  }
}
