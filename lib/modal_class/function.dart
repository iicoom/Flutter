import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:startup_name/api/endpoints.dart';
import 'package:movies/modal_class/credits.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:startup_name/modal_class/movie.dart';

Future<List<Movie>> fetchMovies(String api) async {
  MovieList movieList;
  var res = await http.get(api);
  var decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies;
}