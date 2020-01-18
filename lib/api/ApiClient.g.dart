// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://newsapi.org/v2/everything';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getSearchResults(searchKey, apikey) async {
    ArgumentError.checkNotNull(searchKey, 'searchKey');
    ArgumentError.checkNotNull(apikey, 'apikey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'q': searchKey, 'apiKey': apikey};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchResponse.fromJson(_result.data);
    return Future.value(value);
  }
}
