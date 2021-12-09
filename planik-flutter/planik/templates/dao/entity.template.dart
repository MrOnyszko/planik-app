import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:local/db/_SNAKE_CASE_NAME_/_SNAKE_CASE_NAME__document.dart';

@Entity(
  tableName: '_SNAKE_CASE_NAME_',
)
class _UPPER_CAMEL_CASE_NAME_Entity {
  const _UPPER_CAMEL_CASE_NAME_Entity({
    required this.id,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final bool archived;
  @ColumnInfo(name: 'created_at')
  final String createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  _UPPER_CAMEL_CASE_NAME_Entity copyWith({
    int? id,
    bool? archived,
    String? createdAt,
    String? updatedAt,
  }) {
    return _UPPER_CAMEL_CASE_NAME_Entity(
      id: id ?? this.id,
      document: documentJson ?? this.document,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
