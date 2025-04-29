import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_app_e.dart';

class UserLocalDataSource {
  static const String _userKey = 'user_data';
  
  // Save user data to local storage
  Future<void> saveUser(UserAppE user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(user.toJson());
      await prefs.setString(_userKey, userData);
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }
  
  // Get user data from local storage
  Future<UserAppE?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(_userKey);
      
      if (userData != null) {
        return UserAppE.fromJson(json.decode(userData));
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }
  
  // Update user watchlist
  Future<UserAppE?> updateWatchlist(String movieId, bool add) async {
    try {
      final user = await getUser();
      if (user == null) return null;
      
      UserAppE updatedUser;
      if (add) {
        updatedUser = user.addToWatchlist(movieId);
      } else {
        updatedUser = user.removeFromWatchlist(movieId);
      }
      
      await saveUser(updatedUser);
      return updatedUser;
    } catch (e) {
      throw Exception('Failed to update watchlist: $e');
    }
  }
}
