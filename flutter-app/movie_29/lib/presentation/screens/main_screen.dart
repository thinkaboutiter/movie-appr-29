import 'package:flutter/material.dart';
import '../../data/repositories/movies_repository.dart';
import '../../presentation/screens/movies_list_screen.dart';
import '../../presentation/screens/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final bool isUsingStubData = false;

class _MainScreenState extends State<MainScreen> {
  late final MoviesRepository _moviesRepository;
  late final UserLocalDataSource _userDataSource;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _moviesRepository = MoviesRepository();
    // _userDataSource = UserLocalDataSource();
  }

  @override
  void dispose() {
    _moviesRepository.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          MoviesListScreen(repository: _moviesRepository),
          UserScreen(
            userDataSource: _userDataSource,
            moviesRepository: _moviesRepository,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie),
            label: 'Movies',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
