import 'package:movie_29/domain/entities/movie_app_e.dart';
import 'package:movie_29/domain/entities/movie_network_e.dart';

abstract class MoviesNetworkDatasourceI {
  Future<List<MovieNetworkE>> getMovies();
}
