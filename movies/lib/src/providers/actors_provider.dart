import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'common_provider.dart';
import 'package:movies/src/models/actor_model.dart';

class ActorProvider {
  final UtilProvider _utilProvider = UtilProvider();

  Future<List<Actor>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final actors = Actors.fromJsonList(decodedData['cast']);
    return actors.items;
  }

  Future<List<Actor>> getActors(int movieId) async {
    final url = Uri.https(_utilProvider.url, '3/movie/$movieId/credits',
        {'api_key': _utilProvider.apiKey, 'language': _utilProvider.language});
    return await _processResponse(url);
  }
}
