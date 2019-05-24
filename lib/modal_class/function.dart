import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:startup_name/api/endpoints.dart';
import 'package:startup_name/modal_class/credits.dart';
import 'package:startup_name/modal_class/genres.dart';
import 'package:startup_name/modal_class/movie.dart';

Future<List<Movie>> fetchMovies(String api) async {
  MovieList movieList;
  var res = await http.get(api);
  var decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies;
}

Future<Credits> fetchCredits(String api) async {
  Credits credits;
  var res = await http.get(api);
  var decodeRes = jsonDecode(res.body);
  credits = Credits.fromJson(decodeRes);
  return credits;
}

Future<GenresList> fetchGenres() async {
  GenresList genresList;
  var res = await http.get(Endpoints.genresUrl());
  var decodeRes = jsonDecode(res.body);
  genresList = GenresList.fromJson(decodeRes);
  return genresList;
}