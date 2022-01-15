import 'package:planik/domain/model/plan.dart';
import 'package:planik/local/entity/plan_entity.dart';
import 'package:planik/local/mapper/mapper.dart';

class PlanEntityToModelMapper implements Mapper<PlanEntity, Plan> {
  const PlanEntityToModelMapper();

  @override
  Plan map(PlanEntity value) {
    return Plan(
      id: value.id!,
      name: value.name,
      current: value.current,
      createdAt: DateTime.parse(value.createdAt),
      updatedAt: DateTime.tryParse(value.updatedAt ?? ''),
    );
  }
}
