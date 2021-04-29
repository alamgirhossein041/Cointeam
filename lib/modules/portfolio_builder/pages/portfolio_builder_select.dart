import 'package:coinsnap/modules/utils/sizes_helper.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/modules/utils/colors_helper.dart';

final double cardHeight = 180;

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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 70),
              child: Text(
                "Choose a build method",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            ClipPath(
              clipper: TrapeziumClipperRight(),
              child: QuickBuildButton(),
            ), 
            ClipPath(
              clipper: TrapeziumClipperLeft(),
              child: DefaultBuildButton(),
            ),
          ],
        )
      ),
    );
  }
}

class QuickBuildButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: SizedBox(
        height: cardHeight,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Quick Build',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    )
                  ),  
                  Flexible(
                    flex: 1,
                    child: Text(
                      'Fast, easy, no frills.',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ), 
                ],
              ),
            ),
            Ink.image(
              image: AssetImage("graphics/assets/coins_placeholder.jpg"),
              fit: BoxFit.cover,
              child: InkWell(
                splashColor: Colors.deepPurple[400].withAlpha(50),
                onTap: () {
                  print('quickbuild card tapped');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
class DefaultBuildButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: SizedBox(
        height: cardHeight,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Advanced Build',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    )
                  ),  
                  Flexible(
                    flex: 1,
                    child: Text(
                      'Everything under your countrol.',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ), 
                ],
              ),
            ),
            Ink.image(
              image: AssetImage("graphics/assets/coins_placeholder.jpg"),
              fit: BoxFit.cover,
              child: InkWell(
                splashColor: Colors.deepPurple[400].withAlpha(50),
                onTap: () {
                  print('advbuild card tapped');
                },
              ),
            ),
          ],
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

