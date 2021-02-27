// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptocompare_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CryptoCompareApiClient implements CryptoCompareApiClient {
  _CryptoCompareApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://min-api.cryptocompare.com/data/v2';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<HttpResponse<CryptoCompareHistoHourData>> getCryptoCompareHistoHour(
      authorization,
      {contentType = 'application/json'}) async {
    ArgumentError.checkNotNull(authorization, 'authorization');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/histohour?fsym=BTC&tsym=USD&limit=10',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Authorization': authorization,
              r'Content-Type': contentType
            },
            extra: _extra,
            contentType: contentType,
            baseUrl: baseUrl),
        data: _data);
    final value = CryptoCompareHistoHourData.fromJson(_result.data);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }
}
