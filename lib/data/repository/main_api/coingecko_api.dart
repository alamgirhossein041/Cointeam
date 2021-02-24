import 'dart:convert';
import 'package:coinsnap/data/model/internal/coingecko_model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

part 'coingecko_api.g.dart';

@RestApi(baseUrl: "https://api.coingecko.com/api/v3")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/coins/list")
  Future<List<CoinGeckoCoinList>> getCoinGeckoCoinList();

  @GET("/exchanges/list")
  Future<List<CoinGeckoExchangesList>> getCoinGeckoExchangesList();
}
