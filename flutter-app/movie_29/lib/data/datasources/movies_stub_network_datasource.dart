import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../domain/entities/movie_network_e.dart';
import 'movies_network_datasource_i.dart';

class MoviesStubNetworkDataSource extends MoviesNetworkDatasourceI {
  
  @override
  Future<List<MovieNetworkE>> getMovies() async {
    try {
      // Load the bundled JSON file
      final jsonString = await rootBundle.loadString('assets/movies.json');

      // Parse JSON string to List<dynamic>
      final List<dynamic> jsonList = json.decode(jsonString);

      // Convert to List<MovieNetworkE>
      final List<MovieNetworkE> networkMovies =
          jsonList.map((json) => MovieNetworkE.fromJson(json)).toList();

      return networkMovies;
    } catch (e) {
      throw Exception('Failed to load stub movies: $e');
    }
  }
}
