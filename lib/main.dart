import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:coinsnap/data/model/internal/coingecko_model.dart';
import 'package:coinsnap/data/repository/main_api/coingecko_api.dart';

final logger = Logger();
void main(List<String> args) {
  final dio = Dio(); // Provide a dio instance
  dio.options.headers["Demo-Header"] =
      "demo header"; // config your dio headers globally
  final client = RestClient(dio);

  client.getCoinGeckoCoinList().then((it) => logger.i(it));
}
