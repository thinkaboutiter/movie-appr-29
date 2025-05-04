// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive_e.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveEAdapter extends TypeAdapter<UserHiveE> {
  @override
  final int typeId = 0;

  @override
  UserHiveE read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveE(
      id: fields[0] as String,
      name: fields[1] as String,
      avatarUrl: fields[2] as String?,
      watchlistIds: (fields[4] as List).cast<String>(),
      additionalData: (fields[5] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveE obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.avatarUrl)
      ..writeByte(4)
      ..write(obj.watchlistIds)
      ..writeByte(5)
      ..write(obj.additionalData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveEAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
