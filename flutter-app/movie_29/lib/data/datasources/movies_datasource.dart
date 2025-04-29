import 'package:movie_29/domain/entities/movie_app_e.dart';

abstract class MoviesDatasource {
  Future<List<MovieAppE>> getMovies();
}
