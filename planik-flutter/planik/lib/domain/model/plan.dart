import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/model/pageable.dart';

part 'plan.freezed.dart';

@freezed
class Plan extends Pageable with _$Plan {
  const factory Plan({
    required int id,
    required String name,
    required bool current,
    required DateTime createdAt,
    required DateTime? updatedAt,
  }) = _Plan;
}
