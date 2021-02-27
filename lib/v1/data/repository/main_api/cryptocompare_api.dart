import 'dart:convert';
import 'package:coinsnap/v1/data/model/internal/cryptocompare_model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:http/http.dart' as http;

part 'cryptocompare_api.g.dart';

@RestApi(baseUrl: "https://min-api.cryptocompare.com/data/v2")
abstract class CryptoCompareApiClient {
  factory CryptoCompareApiClient(Dio dio, {String baseUrl}) =
      _CryptoCompareApiClient;

  @GET("/histohour?fsym=BTC&tsym=USD&limit=10")
  Future<HttpResponse<CryptoCompareHistoHourData>> getCryptoCompareHistoHour(
      @Header("Authorization") String authorization,
      {@Header("Content-Type") String contentType = 'application/json'});
}
