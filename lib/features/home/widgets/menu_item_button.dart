import 'package:flutter/material.dart';
import 'package:coinsnap/features/utils/sizes_helper.dart';

class MenuItemButton extends StatelessWidget {
  const MenuItemButton({Key key, this.buttonText, this.dir}) : super(key: key);

  final String buttonText;
  final String dir;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: displayHeight(context) * 0.05,
        width: displayWidth(context) * 0.2,
        child: Align(
            alignment: Alignment.center,
            child:
                Text(buttonText, style: TextStyle(fontWeight: FontWeight.w500))),
      ),
      onTap: () => {
        Navigator.pushNamed(context, dir),
      },
    );
  }
}
