import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/service/plan_service.dart';

import 'domain_mocks.dart';

void main() {
  group(
    'PlanService',
    () {
      late MockPlanLocalSource planLocalSourceMock;
      late MockUserLocalSource userLocalSourceMock;
      late PlanService planService;

      setUp(
        () {
          planLocalSourceMock = MockPlanLocalSource();
          userLocalSourceMock = MockUserLocalSource();
          planService = PlanService(
            planLocalSource: planLocalSourceMock,
            userLocalSource: userLocalSourceMock,
          );
        },
      );

      tearDown(
        () {
          reset(planLocalSourceMock);
          reset(userLocalSourceMock);
        },
      );

      test(
        'gets plans with success',
        () async {
          final fullPlan = _createFullPlan();

          when(
            () => planLocalSourceMock.getPlans(
              pageSize: any(named: 'pageSize', that: equals(1)),
              page: any(named: 'page', that: equals(1)),
            ),
          ).thenAnswer((_) => TaskEither<GeneralFailure, List<Plan>>.right([fullPlan.plan]));

          final result = await planService.getPlans(pageSize: 1, page: 1);

          verify(
            () => planLocalSourceMock.getPlans(
              pageSize: any(named: 'pageSize', that: equals(1)),
              page: any(named: 'page', that: equals(1)),
            ),
          ).called(1);

          expect(result, [fullPlan.plan]);
        },
      );

      test(
        'gets plans and returns empty list on failure',
        () async {
          when(
            () => planLocalSourceMock.getPlans(
              pageSize: any(named: 'pageSize', that: equals(1)),
              page: any(named: 'page', that: equals(1)),
            ),
          ).thenAnswer((_) => TaskEither<GeneralFailure, List<Plan>>.left(GeneralFailure.fatal));

          final result = await planService.getPlans(pageSize: 1, page: 1);

          verify(
            () => planLocalSourceMock.getPlans(
              pageSize: any(named: 'pageSize', that: equals(1)),
              page: any(named: 'page', that: equals(1)),
            ),
          ).called(1);

          expect(result, []);
        },
      );

      test(
        'gets current plan with success',
        () async {
          final fullPlan = _createFullPlan();

          when(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(fullPlan.plan.id))),
          ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(fullPlan));

          when(() => userLocalSourceMock.currentPlanId())
              .thenAnswer((invocation) => TaskEither<GeneralFailure, int>.right(fullPlan.plan.id));

          final result = await planService.getCurrentPlan().run();

          verify(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(fullPlan.plan.id))),
          ).called(1);

          expect(result, Right<GeneralFailure, FullPlan>(fullPlan));
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

          when(() => userLocalSourceMock.currentUserId())
              .thenAnswer((invocation) => TaskEither<GeneralFailure, int>.right(userId));

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
          final fullPlan = _createFullPlan();

          when(
            () => planLocalSourceMock.createPlan(
              userId: any(named: 'userId', that: equals(userId)),
              name: any(named: 'name', that: equals('Plan')),
              current: any(named: 'current', that: equals(true)),
            ),
          ).thenAnswer((_) => TaskEither<GeneralFailure, int>.right(1));

          when(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(fullPlan));

          when(() => userLocalSourceMock.currentUserId())
              .thenAnswer((invocation) => TaskEither<GeneralFailure, int>.right(userId));

          when(
            () => userLocalSourceMock.setCurrentPlanId(
              id: any(named: 'id', that: equals(fullPlan.plan.id)),
            ),
          ).thenAnswer((invocation) => TaskEither<GeneralFailure, int>.right(fullPlan.plan.id));

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
            () => userLocalSourceMock.setCurrentPlanId(
              id: any(named: 'id', that: equals(fullPlan.plan.id)),
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

          expect(result, Right<GeneralFailure, FullPlan>(fullPlan));
        },
      );

      test(
        'updates plan changing current plan with, success',
        () async {
          const id = 1;
          final fullPlan = _createFullPlan();

          when(
            () => planLocalSourceMock.updatePlan(
              id: any(named: 'id', that: equals(id)),
              name: any(named: 'name', that: equals('Plan')),
              current: any(named: 'current', that: equals(true)),
            ),
          ).thenAnswer((_) => TaskEither<GeneralFailure, int>.right(1));

          when(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(fullPlan));

          when(
            () => userLocalSourceMock.setCurrentPlanId(
              id: any(named: 'id', that: equals(fullPlan.plan.id)),
            ),
          ).thenAnswer((invocation) => TaskEither<GeneralFailure, int>.right(fullPlan.plan.id));

          final result = await planService.updatePlan(id: id, name: 'Plan', current: true).run();

          verify(
            () => planLocalSourceMock.updatePlan(
              id: any(named: 'id', that: equals(id)),
              name: any(named: 'name', that: equals('Plan')),
              current: any(named: 'current', that: equals(true)),
            ),
          ).called(1);

          verify(
            () => userLocalSourceMock.setCurrentPlanId(
              id: any(named: 'id', that: equals(fullPlan.plan.id)),
            ),
          ).called(1);

          verify(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).called(1);

          expect(result, Right<GeneralFailure, FullPlan>(fullPlan));
        },
      );

      test(
        'updates plan not changing current plan, with success',
        () async {
          const id = 1;
          final fullPlan = _createFullPlan();

          when(
            () => planLocalSourceMock.updatePlan(
              id: any(named: 'id', that: equals(id)),
              name: any(named: 'name', that: equals('Plan')),
              current: any(named: 'current', that: equals(false)),
            ),
          ).thenAnswer((_) => TaskEither<GeneralFailure, int>.right(1));

          when(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(fullPlan));

          when(
            () => userLocalSourceMock.setCurrentPlanId(
              id: any(named: 'id', that: equals(fullPlan.plan.id)),
            ),
          ).thenAnswer((invocation) => TaskEither<GeneralFailure, int>.right(fullPlan.plan.id));

          final result = await planService.updatePlan(id: id, name: 'Plan', current: false).run();

          verify(
            () => planLocalSourceMock.updatePlan(
              id: any(named: 'id', that: equals(id)),
              name: any(named: 'name', that: equals('Plan')),
              current: any(named: 'current', that: equals(false)),
            ),
          ).called(1);

          verifyNever(
            () => userLocalSourceMock.setCurrentPlanId(
              id: any(named: 'id', that: equals(fullPlan.plan.id)),
            ),
          );

          verify(
            () => planLocalSourceMock.getPlan(id: any(named: 'id', that: equals(1))),
          ).called(1);

          expect(result, Right<GeneralFailure, FullPlan>(fullPlan));
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
