import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/service/plan_service.dart';

import '../local/local_mocks.dart';
import 'domain_mocks.dart';

void main() {
  group(
    'PlanService',
    () {
      late MockPlanLocalSource planLocalSourceMock;
      late MockUserLocalSource userLocalSourceMock;
      late MockUserStore userStoreMock;
      late PlanService planService;

      setUp(
        () {
          planLocalSourceMock = MockPlanLocalSource();
          userLocalSourceMock = MockUserLocalSource();
          userStoreMock = MockUserStore();
          planService = PlanService(
            planLocalSource: planLocalSourceMock,
            userLocalSource: userLocalSourceMock,
            userStore: userStoreMock,
          );
        },
      );

      tearDown(
        () {
          reset(planLocalSourceMock);
          reset(userStoreMock);
        },
      );

      test(
        'gets plan with success',
        () async {
          const userId = 1;
          final plan = _createFullPlan();

          when(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(plan));

          when(() => userStoreMock.getId()).thenReturn(userId);

          final result = await planService.getPlan(id: 1).run();

          verify(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).called(1);

          expect(result, Right<GeneralFailure, FullPlan>(plan));
        },
      );

      test(
        'adds plan with success',
        () async {
          const userId = 1;
          final plan = _createFullPlan();

          when(
            () => planLocalSourceMock.createPlan(
              userId: any(named: 'userId', that: equals(userId)),
              name: any(named: 'name', that: equals('Plan')),
              current: any(named: 'current', that: equals(true)),
            ),
          ).thenAnswer((_) => TaskEither<GeneralFailure, int>.right(1));

          when(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(plan));

          when(() => userStoreMock.getId()).thenReturn(userId);

          when(
            () => userLocalSourceMock.setHasPlan(
              hasPlan: any(named: 'hasPlan', that: equals(true)),
            ),
          ).thenAnswer((invocation) => TaskEither<GeneralFailure, Unit>.right(unit));

          final result = await planService.addPlan(name: 'Plan').run();

          verify(
            () => planLocalSourceMock.createPlan(
              userId: any(named: 'userId', that: equals(userId)),
              name: any(named: 'name', that: equals('Plan')),
              current: any(named: 'current', that: equals(true)),
            ),
          ).called(1);

          verify(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).called(1);

          verify(
            () => userLocalSourceMock.setHasPlan(
              hasPlan: any(named: 'hasPlan', that: equals(true)),
            ),
          ).called(1);

          expect(result, Right<GeneralFailure, FullPlan>(plan));
        },
      );
    },
  );
}

FullPlan _createFullPlan([int id = 1, String name = 'Plan']) {
  return FullPlan(
    plan: Plan(
      id: id,
      name: name,
      current: true,
      createdAt: DateTime.utc(2022, 7, 6),
      updatedAt: DateTime.utc(2022, 7, 6),
    ),
    days: [
      Day(
        ordinal: 1,
        name: 'Monday',
        date: DateTime.utc(2022, 7, 6),
        entries: [
          DayEntry(
            id: 1,
            dayOfWeek: DateTime.monday,
            title: 'Math',
            start: DateTime.utc(2022, 7, 6, 8),
            end: DateTime.utc(2022, 7, 6, 8, 45),
            pauseMinutes: 15,
          ),
          DayEntry(
            id: 2,
            dayOfWeek: DateTime.monday,
            title: 'History',
            start: DateTime.utc(2022, 7, 6, 9),
            end: DateTime.utc(2022, 7, 6, 9, 45),
            pauseMinutes: 5,
          ),
        ],
      ),
    ],
  );
}
