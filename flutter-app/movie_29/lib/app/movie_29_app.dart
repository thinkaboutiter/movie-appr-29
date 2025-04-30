import 'package:flutter/material.dart';
import 'package:movie_29/presentation/screens/main_screen.dart';

class Movie29App extends StatelessWidget {
  const Movie29App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
