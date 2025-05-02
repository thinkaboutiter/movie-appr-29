import 'package:flutter/material.dart';
import 'package:movie_29/app/movie_29_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_29/domain/entities/user_hive_e.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveEAdapter());
  await Hive.openBox<UserHiveE>('UserHiveEBox');
 
  runApp(const Movie29App());
}
