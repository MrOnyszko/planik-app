import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@Entity(
  tableName: 'users',
)
@immutable
class UserEntity {
  const UserEntity({
    required this.id,
    required this.uid,
    required this.nickname,
    required this.createdAt,
    required this.updatedAt,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String uid;
  final String nickname;
  @ColumnInfo(name: 'created_at')
  final String createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          nickname == other.nickname &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^ uid.hashCode ^ nickname.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;

  UserEntity copyWith({
    int? id,
    String? uid,
    String? nickname,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
