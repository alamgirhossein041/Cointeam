import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key key,
    @required this.title
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          )
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text(title)
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox()
        )
      ]
    );
  }
}