import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:planik/local/entity/user_entity.dart';

@Entity(
  tableName: 'plans',
  foreignKeys: [
    ForeignKey(
      childColumns: ['user_id'],
      parentColumns: ['id'],
      entity: UserEntity,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
  indices: [
    Index(value: ['user_id'])
  ],
)
@immutable
class PlanEntity {
  const PlanEntity({
    required this.userId,
    required this.name,
    required this.current,
    required this.createdAt,
    required this.updatedAt,
    this.id,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'user_id')
  final int userId;
  final String name;
  final bool current;
  @ColumnInfo(name: 'created_at')
  final String createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          name == other.name &&
          current == other.current &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      current.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  PlanEntity copyWith({
    int? id,
    int? userId,
    String? name,
    bool? current,
    String? createdAt,
    String? updatedAt,
    bool? archived,
  }) {
    return PlanEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      current: current ?? this.current,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
