import 'package:carousel_slider/carousel_slider.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/modal_widgets/link_api_helper_modal.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselDemo extends StatelessWidget {
  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {

    // total number of pages on this slider
    List<int> pageList = [1,2,3,4,5,6,7];

    return Scaffold(
      body:SafeArea(
        child: Container(
        // color: Colors.black,
        decoration: bgColor,
        child: Stack(
          
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      CarouselSlider(
                        // iterate through the list of page numbers to generate each page
                        items: pageList.map((p) {
                            return Container(
                              margin: EdgeInsets.all(5.0),
                              child: LinkAPIHelperModal(page: p),
                            );
                          }
                        ).toList(),

                        //Slider Container properties
                        options: CarouselOptions(
                          height: displayHeight(context) * 0.94,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                        ),
                      ),
                    ],
                  ),
                ),
                Container (
                  height: 100,
                  // Smooth page indicator
                  child: PageIndicator(1)
                ),
              ],
            )
          ]
        ),
      ),
      ),
    );
  }
}

// Helper variables

// background colour
var bgColor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment(-1.08, -1.08),
    end: Alignment(1, 1.06),
    colors: [
      Color(0xFF443E48),
      Color(0xFF1B1F2D),
    ],
  ),
);

// Helper Widgets

class PageIndicator extends StatelessWidget {
  PageIndicator(this.page);

  final int page;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSmoothIndicator(
        activeIndex: page,
        count: 7,
      effect: WormEffect(),
      ),
    );
  }
}