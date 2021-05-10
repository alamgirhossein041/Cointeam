import 'package:flutter/material.dart';

Widget loadingTemplateWidget([double _size, double _strokeWidth]) {
  double size = 40;
  double strokeWidth = 4;
  if(_size != null) {
    size = _size;
  }
  if(_strokeWidth != null) {
    strokeWidth = _strokeWidth;
  }
  return Center(
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(strokeWidth: strokeWidth),
    ),
  );
}

Widget errorTemplateWidget(String errorMessage) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}