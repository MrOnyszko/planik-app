import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/service/plan_service.dart';
import 'package:planik/presentation/components/pagination/pagination.dart';
import 'package:planik/presentation/screens/plans/plan_pagination_manager.dart';

class MockPlanService extends Mock implements PlanService {}

void main() {
  late MockPlanService planServiceMock;
  late PlanPaginationManager planPaginationManager;

  setUp(
    () {
      planServiceMock = MockPlanService();
      planPaginationManager = PlanPaginationManager(planService: planServiceMock);
    },
  );

  tearDown(
    () {
      reset(planServiceMock);
    },
  );

  test(
    'PlanPaginationManager returns empty when there is no plans',
    () async {
      when(() => planServiceMock.getPlans(pageSize: 10, page: 1)).thenAnswer(
        (_) async => [],
      );

      final result = await planPaginationManager.getPages(
        filteringKey: null,
        paginationKey: 1,
        config: null,
        pageSize: 10,
      );

      expect(
        result,
        const PaginationResult<Plan>(
          items: <Plan>[],
          paginationKey: 1,
        ),
      );
    },
  );

  test(
    'PlanPaginationManager returns empty when there is no plans',
    () async {
      final plans = <Plan>[_createPlan()];

      when(() => planServiceMock.getPlans(pageSize: 10, page: 1)).thenAnswer(
        (_) async => plans,
      );

      final result = await planPaginationManager.getPages(
        filteringKey: null,
        paginationKey: 1,
        config: null,
        pageSize: 10,
      );

      expect(
        result,
        PaginationResult<Plan>(
          items: plans,
          paginationKey: 1,
        ),
      );
    },
  );
}

Plan _createPlan({
  int id = 1,
  String name = 'Plan',
  bool current = true,
}) {
  return Plan(
    id: id,
    name: name,
    current: current,
    createdAt: DateTime.utc(2022, 7, 6),
    updatedAt: DateTime.utc(2022, 7, 6),
  );
}
