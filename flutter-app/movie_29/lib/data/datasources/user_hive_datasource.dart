import 'package:hive/hive.dart';
import 'package:movie_29/domain/entities/user_hive_e.dart';

class UserHiveDatasource {
  // Get the box
  Box<UserHiveE> get userBox => Hive.box<UserHiveE>('UserHiveEBox');

  // Add a user
  Future<void> addUser(UserHiveE user) async {
    await clearAllUsers();
    await userBox.put(user.id, user);
  }

  // Update a user
  Future<void> updateUser(UserHiveE user) async {
    await userBox.put(user.id, user);
  }

  // Delete a user
  Future<void> deleteUser(String id) async {
    await userBox.delete(id);
  }

  // Clear all users
  Future<void> clearAllUsers() async {
    await userBox.clear();
  }

  // Get all users
  List<UserHiveE> getAllUsers() {
    return userBox.values.toList();
  }
}
