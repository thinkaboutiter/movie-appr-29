import 'package:hive/hive.dart';

part 'user_hive_e.g.dart'; // This file will be auto-generated

@HiveType(typeId: 0)
class UserHiveE extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String? avatarUrl;
  
  @HiveField(4)
  List<String> watchlistIds;
  
  @HiveField(5)
  Map<String, dynamic>? additionalData;
  
  UserHiveE({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.watchlistIds = const [],
    this.additionalData,
  });
}