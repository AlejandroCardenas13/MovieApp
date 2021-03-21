import 'dart:async';
import 'dart:convert';
import 'package:movies/src/models/movie_model.dart';

import 'package:http/http.dart' as http;

/**
 * StreamController<List<Movie>>(); solamente un Widget podría escuchar este Stream se le agrega el .broadcast() para que cualquier
 * Widget pueda escuchar el Stream 
 */

class MoviesProvider {
  String _apiKey = '';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularesPage = 0;
  bool _loading = false;

  List<Movie> _popularMovies = [];

  final _popularMoviesStreamController =
      StreamController<List<Movie>>.broadcast(); //

  Function(List<Movie>) get getPopularMoviesSink =>
      _popularMoviesStreamController.sink.add;

  Stream<List<Movie>> get getPopularMoviesStream =>
      _popularMoviesStreamController.stream;

  void disposeStreams() => _popularMoviesStreamController?.close();

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getOnMovies() async {
    final url = Uri.https(_url, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await _processResponse(url);
  }

  //Refactor usando Stream
  Future<List<Movie>> getPopularMovies() async {
    if (_loading) return [];

    _loading = true;

    _popularesPage++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    final resp = await _processResponse(url);
    _popularMovies.addAll(resp);
    getPopularMoviesSink(_popularMovies);
    _loading = false;
    return resp;
  }
}
