// Using a class with static constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Movie 29';
  static const String appVersion = '1.0.0';

  static const int connectionTimeout = 30000; // in milliseconds
  static const int receiveTimeout = 15000;
}

class ApiEndpoints {
  ApiEndpoints._();
  static const String movies =
      'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-coming-soon.json';
}
