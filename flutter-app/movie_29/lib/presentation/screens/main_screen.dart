import 'package:flutter/material.dart';
import 'package:movie_29/data/repositories/user_repository.dart';
import '../../data/repositories/movies_repository.dart';
import '../../presentation/screens/movies_list_screen.dart';
import '../../presentation/screens/user_screen.dart';
import 'package:movie_29/domain/entities/user_app_e.dart';
import '../../utils/watchlist_support.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final bool isUsingStubData = false;

class _MainScreenState extends State<MainScreen> {
  late final MoviesRepository _moviesRepository;
  late final UserRepository _userRepository;
  late final WatchlistSupport _watchlistSupport;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _moviesRepository = MoviesRepository();
    _userRepository = UserRepository();
    _watchlistSupport = WatchlistSupport(
      moviesRepository: _moviesRepository,
      userRepository: _userRepository,
    );
    _createDefaultUser();
  }

  void _createDefaultUser() async {
    debugPrint('Creating default user');

    final defaultUser = await _userRepository.fetchUser();
    if (defaultUser != null) {
      return;
    }
    final newUser = UserAppE(id: '1', name: 'Hello Movie Fan 1', watchlistIds: []);
    await _userRepository.saveUser(newUser);
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
          MoviesListScreen(
            moviesRepository: _moviesRepository,
            userRepository: _userRepository,
          ),
          UserScreen(
            userRepository: _userRepository,
            moviesRepository: _moviesRepository,
            watchlistSupport: _watchlistSupport,
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
