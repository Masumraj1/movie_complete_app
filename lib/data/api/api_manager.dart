import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/api/api_constant.dart';
import 'package:movies_app/data/models/movie_model.dart';

class ApiManager {

  static Future<MoviesModel> getPopularMovies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url =
    Uri.https(ApiConstant.baseUrl, ApiConstant.popularApi, {
    });
    try {
      var response = await http.get(url, headers: requestHeaders);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel> getNewReleasesMovies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url =
    Uri.https(ApiConstant.baseUrl, ApiConstant.upComingApi, {});
    try {
      var response = await http.get(url, headers: requestHeaders);
       var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel> getTopRatedMovies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url =
    Uri.https(ApiConstant.baseUrl, ApiConstant.recommendedApi, {
    });
    try {
      var response = await http.get(url, headers: requestHeaders);
       var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel> getCategoryMovies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.categoryMoviesApi, {});
    try {
      var response = await http.get(url, headers: requestHeaders);
       var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel> getCategoryMoviesList(int? categoryId) async {
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': ApiConstant.tokenAuth,
    // };
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=${ApiConstant.apiKey}&language=en-US&sort_by=popularity.desc&include_adult='
        'false&include_video=false&page=1&with_genres=$categoryId&with_watch_monetization_types=flatrate'));
    var responseBody = response.body;
    var json = jsonDecode(responseBody);
    MoviesModel categorylist = MoviesModel.fromJson(json);
    return categorylist;
  }

  static Future<MoviesModel> getSearchMovies(String? query) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url =
        Uri.https(ApiConstant.baseUrl, ApiConstant.searchApi, {'query': query});
    try {
      var response = await http.get(url, headers: requestHeaders);
       var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel> getSimilarMovies(num? movieId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url = Uri.https(ApiConstant.baseUrl, "/3/movie/$movieId/similar", {});
    try {
      var response = await http.get(url, headers: requestHeaders);
       var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
