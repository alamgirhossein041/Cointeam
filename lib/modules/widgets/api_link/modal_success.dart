import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// End screen for Modal when action was successful
/// 
/// {@icon Icon to display}
/// {@title Title text}
/// {@body body Widget to display}
/// {@actionButton Next action to take from this end screen, usually "ok" or "return to dash" etc.}
class ModalSuccess extends StatelessWidget {
  
  final Icon icon;
  final String title;
  final Widget body;
  final Widget actionButton;

  const ModalSuccess({this.icon, this. title, this.body, this.actionButton});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: <Widget> [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: icon,
          ),
          Flexible(
            flex: 1,
            // fit: FlexFit.tight,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline1
            ),
          ),
          Flexible(
            flex: 2,
            // fit: FlexFit.tight,
            child: body,
          ),
          Flexible(
            flex: 1,
            // fit: FlexFit.tight,
            child: actionButton,
          ),
        ]
      )
    );
  }
}