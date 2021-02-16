import 'package:flutter/material.dart';

Widget buildLoadingTemplate() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorTemplate(String errorMessage) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}