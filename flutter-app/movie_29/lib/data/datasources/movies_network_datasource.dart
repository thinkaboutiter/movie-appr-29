import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/movie_app_e.dart';
import '../../domain/entities/movie_network_e.dart';
import 'movies_network_datasource_i.dart';

class MoviesNetworkDataSource extends MoviesNetworkDatasourceI {
  final String apiUrl;

  MoviesNetworkDataSource({required this.apiUrl});
  
  @override
  Future<List<MovieNetworkE>> getMovies() async {
    try {
      // Execute GET request
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Consume and parse JSON response
        final List<dynamic> jsonList = json.decode(response.body);

        // Parse to MovieNetworkE
        final List<MovieNetworkE> networkMovies =
            jsonList.map((json) => MovieNetworkE.fromJson(json)).toList();

        return networkMovies;
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get movies from network: $e');
    }
  }
}
