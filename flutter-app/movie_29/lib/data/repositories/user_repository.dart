import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:movie_29/data/datasources/user_hive_datasource.dart';
import 'package:movie_29/domain/entities/user_app_e.dart';
import 'package:movie_29/domain/entities/user_hive_e.dart';

class UserRepository {
  static UserAppE userAppEntityFromHiveEntity(UserHiveE hiveUser) {
    return UserAppE(
      id: hiveUser.id,
      name: hiveUser.name,
      watchlistIds: hiveUser.watchlistIds,
    );
  }

  static UserHiveE userHiveEntityFromAppEntity(UserAppE appUser) {
    return UserHiveE(
      id: appUser.id,
      name: appUser.name,
      watchlistIds: appUser.watchlistIds,
    );
  }

  final UserHiveDatasource _hiveDatasource;
  UserRepository({UserHiveDatasource? datasource})
    : _hiveDatasource = datasource ?? UserHiveDatasource();

  // Controller for user updates
  final _userController = StreamController<UserAppE?>.broadcast();

  // Stream of user
  Stream<UserAppE?> get user => _userController.stream;

  Future<UserAppE?> fetchUser() async {
    try {
      final hiveUser = _hiveDatasource.getAllUsers().firstOrNull;
      if (hiveUser == null) {
        debugPrint('No user found in local storage');
        _userController.add(null);
        return null;
      }
      final appUser = userAppEntityFromHiveEntity(hiveUser);
      _userController.add(appUser);
      return appUser;
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }

  Future<void> saveUser(UserAppE user) async {
    final hiveUser = userHiveEntityFromAppEntity(user);
    await _hiveDatasource.addUser(hiveUser);
    _userController.add(user);
  }
}
