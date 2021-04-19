import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:coinsnap/v2/helpers/sizes_helper.dart';
import 'package:coinsnap/v2/ui/widgets/modal_widgets/link_api_helper_modal.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  final CarouselController buttonCarouselController = CarouselController();
  
  int exch = 0;
  // current page index used for page indicator
  int _curr = 0;

  @override
  Widget build(BuildContext context) {
    // total number of pages on this slider
    List<int> pageList = [1, 2, 3, 4, 5, 6, 7];

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          // background gradient
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF383640),
                  Color(0xFF282831),
                ],
              ),
              // without this it has a thin grey border for some reason D:<
              border: Border.all(width: 0)),

          child: 
            StatefulBuilder(builder: (context, setState) {
              return Stack(children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView(children: [
                        CarouselSlider(
                          // iterate through the list of page numbers to generate each page
                          items: pageList.map((p) {
                            return Container(
                              margin: EdgeInsets.all(4.0),
                              child: LinkAPIHelperModal(page: p, exch: exch, callback: _callbackSetState, indexCallback: _callbackSetCurr, navigatePageCallback: _callbackNavigateTo),
                            );
                          }).toList(),
                          carouselController: buttonCarouselController,

                          //Slider Container properties
                          options: CarouselOptions(
                            autoPlay: false,
                            height: displayHeight(context) - 90,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() => _curr = index);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  // page indicators at the bottom
                  alignment: Alignment.bottomCenter, 
                  padding: EdgeInsets.only(bottom: 40, top: 40),
                  child: PageIndicator(_curr)),
                ]
              );
            }
          ),
        ),
      ),
    );
  }
  void _callbackSetState(int selected) {
    setState(() {
      exch = selected;
    });
  }
  void _callbackSetCurr() {
    
    buttonCarouselController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
    // setState(() {
    //   _curr = index;
    // });
  }
  void _callbackNavigateTo(int page) {
    

    /// ### Navigate to specific page ### ///
    
    buttonCarouselController.jumpToPage(page);
    // setState(() {
    //   _curr = index;
    // });
  }
}

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
        effect: WormEffect(
            paintStyle: PaintingStyle.fill,
            dotWidth: 6,
            dotHeight: 6,
            spacing: 12,
            dotColor: Colors.grey[800],
            activeDotColor: Theme.of(context).accentColor
          ),
      ),
    );
  }
}
