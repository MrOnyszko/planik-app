import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/plan.dart';

part 'full_plan.freezed.dart';

@freezed
class FullPlan with _$FullPlan {
  const factory FullPlan({
    required Plan plan,
    required List<Day> days,
  }) = _FullPlan;
}
