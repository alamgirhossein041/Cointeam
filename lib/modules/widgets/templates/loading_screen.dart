import 'package:flutter/material.dart';

Widget loadingTemplateWidget() {
  return Center(
    child: CircularProgressIndicator(),
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