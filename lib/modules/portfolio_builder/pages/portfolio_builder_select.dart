import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';


class PortfolioBuilderSelect extends StatefulWidget {
  PortfolioBuilderSelect();

  @override
  _PortfolioBuilderSelectState createState() => _PortfolioBuilderSelectState();
}

class _PortfolioBuilderSelectState extends State<PortfolioBuilderSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bgGrad1, bgGrad2],
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Build new Portfolio'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: TrapeziumClipperRight(),
              child: QuickBuildButton(),
            ), 
            ClipPath(
              clipper: TrapeziumClipperLeft(),
              child: defaultBuildButton(),
            ),
          ],
        )
      ),
    );
  }

  defaultBuildButton() {
    return Container(
      color: Colors.blue,
      height: 200,
      width: displayWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 2,
            child: Text('bleh')
          ),  
          Flexible(
            flex: 1,
            child: Text('blaaah')
          ),  
        ],
      ), 
    );
  }

}

class QuickBuildButton extends StatelessWidget{
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
        child: SizedBox(
          height: 200,
          child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {
          print('quickbuild card tapped');
        },
        child:
          Stack(
            children: [
              Positioned(
                right:0,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("graphics/assets/coins_placeholder.jpg")
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text('Quick Build')
                    ),  
                    Flexible(
                      flex: 1,
                      child: Text('Fast, easy, no frills.')
                    ), 
                  ],
                ),
              ),

          ],),
        ),
      ), 
    );
  }
}

class TrapeziumClipperRight extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // trapezium
    Path path = Path()
    ..lineTo(size.width, 0)
    ..lineTo(size.width * 0.85, size.height)
    ..lineTo(0, size.height)
    ..close();
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}

class TrapeziumClipperLeft extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // trapezium
    Path path = Path()
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width * 0.15, size.height)
    ..close();
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}

