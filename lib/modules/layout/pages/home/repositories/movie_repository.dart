import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieRepository {
  final String baseUrl;

  MovieRepository({this.baseUrl = 'https://yts.mx/api/v2/list_movies.json'});
  Future<List<Movie>> fetchMovies({int limit = 50}) async {
    final uri = Uri.parse('$baseUrl?limit=$limit');
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Failed to load movies');
    }
    final Map<String, dynamic> jsonData = json.decode(res.body);
    final moviesJson = (jsonData['data']?['movies'] as List<dynamic>?) ?? [];
    final movies = moviesJson.map((e) => Movie.fromJson(e)).toList();
    return movies;
  }
  Map<String, List<Movie>> groupByGenre(List<Movie> movies) {
    final Map<String, List<Movie>> map = {};
    for (final m in movies) {
      for (final g in m.genres ?? []) {
        map.putIfAbsent(g, () => []).add(m);
      }
    }
    map.forEach((key, list) {
      list.sort((a, b) => b.dateUploadedUnix.compareTo(a.dateUploadedUnix));
    });
    return map;
  }
}
