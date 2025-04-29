import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/movie_app_e.dart';
import '../../domain/entities/movie_network_e.dart';


class MovieNetworkDataSource {
  final String apiUrl;
  
  MovieNetworkDataSource({required this.apiUrl});
  
  Future<List<MovieAppE>> getMovies() async {
    try {
      // Execute GET request
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        // Consume and parse JSON response
        final List<dynamic> jsonList = json.decode(response.body);
        
        // Parse to MovieNetworkE
        final List<MovieNetworkE> networkMovies = jsonList
            .map((json) => MovieNetworkE.fromJson(json))
            .toList();
        
        // Transform to MovieAppE
        return networkMovies
            .map((networkMovie) => MovieAppE.fromNetworkEntity(networkMovie))
            .toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get movies from network: $e');
    }
  }
}
