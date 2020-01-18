import 'package:dio/dio.dart';
import 'package:news_app/models/SearchResponse.dart';
import 'package:retrofit/http.dart';

part 'ApiClient.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2/everything")
abstract class ApiClient {

  factory ApiClient(Dio dio) = _ApiClient;

  @GET("")
  Future<SearchResponse> getSearchResults(
      @Query("q") String searchKey, @Query("apiKey") String apikey);

}
