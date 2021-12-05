import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:planik/local/entity/plan_entity.dart';

@Entity(
  tableName: 'plan_day_entries',
  foreignKeys: [
    ForeignKey(
      childColumns: ['plan_id'],
      parentColumns: ['id'],
      entity: PlanEntity,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
)
@immutable
class PlanDayEntryEntity {
  const PlanDayEntryEntity({
    required this.id,
    required this.planId,
    required this.dayOfWeek,
    required this.name,
    required this.start,
    required this.end,
    required this.createdAt,
    required this.updatedAt,
  });

  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'plan_id')
  final int planId;
  @ColumnInfo(name: 'day_of_week')
  final int dayOfWeek;
  final String name;
  final String start;
  final String end;
  @ColumnInfo(name: 'created_at')
  final String createdAt;
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanDayEntryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          planId == other.planId &&
          dayOfWeek == other.dayOfWeek &&
          name == other.name &&
          start == other.start &&
          end == other.end &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      planId.hashCode ^
      dayOfWeek.hashCode ^
      name.hashCode ^
      start.hashCode ^
      end.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  PlanDayEntryEntity copyWith({
    int? id,
    int? planId,
    int? dayOfWeek,
    String? name,
    String? start,
    String? end,
    String? createdAt,
    String? updatedAt,
  }) {
    return PlanDayEntryEntity(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      name: name ?? this.name,
      start: start ?? this.start,
      end: end ?? this.end,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
