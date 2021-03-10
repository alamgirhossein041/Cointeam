import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/modal_widgets/modal_popup.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                child: ModalPopup(),
              ),

              //2nd Connect exchange
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('graphics/assets/placeholder_modal.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //3rd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('graphics/assets/placeholder_modal.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //4th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('graphics/assets/placeholder_modal.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              //5th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('graphics/assets/placeholder_modal.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],

            //Slider Container properties
            options: CarouselOptions(
              height: displayHeight(context) * 0.85,
              enlargeCenterPage: true,
              initialPage: 0,
              // autoPlay: true,
              aspectRatio: 16 / 9,
              // autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              // autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
          ),
        ],
      ),
    );
  }
}
