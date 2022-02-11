import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/service/plan_service.dart';
import 'package:planik/presentation/components/pagination/pagination.dart';

class PlanPaginationManager implements PaginationManager<Plan> {
  static const String name = 'Plan';

  const PlanPaginationManager({
    required PlanService planService,
  }) : _planService = planService;

  final PlanService _planService;

  @override
  Future<PaginationResult<Plan>> getPages({
    required Object? filteringKey,
    required int paginationKey,
    // ignore: avoid_annotating_with_dynamic
    required dynamic config,
    required int pageSize,
  }) =>
      _planService
          .getPlans(pageSize: pageSize, page: paginationKey)
          .onError((error, stackTrace) => <Plan>[])
          .then(
        (plans) {
          if (plans.isEmpty) {
            return PaginationResult(items: const <Plan>[], paginationKey: paginationKey);
          } else {
            return PaginationResult(items: plans, paginationKey: plans.last.id);
          }
        },
      );
}
