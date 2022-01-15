import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/source/plan_local_source.dart';
import 'package:planik/local/entity/plan_day_entry_entity.dart';
import 'package:planik/local/entity/plan_entity.dart';
import 'package:planik/local/mapper/plan_day_entry_entity_to_model_mapper.dart';
import 'package:planik/local/mapper/plan_entity_to_model_mapper.dart';
import 'package:planik/local/source/plan_local_source_impl.dart';

import '../../mocks.dart';
import '../local_mocks.dart';

void main() {
  group(
    'PlanLocalSource',
    () {
      late MockDates datesMock;
      late MockPlanDao planDaoMock;
      late MockPlanDayEntryDao planDayEntryDaoMock;
      late PlanLocalSource planLocalSource;
      late PlanEntityToModelMapper planEntityToModelMapper;
      late PlayDayEntryEntityToModelMapper playDayEntryEntityToModelMapper;

      setUp(
        () {
          datesMock = MockDates();
          planDaoMock = MockPlanDao();
          planDayEntryDaoMock = MockPlanDayEntryDao();
          planEntityToModelMapper = const PlanEntityToModelMapper();
          playDayEntryEntityToModelMapper = const PlayDayEntryEntityToModelMapper();
          planLocalSource = PlanLocalSourceImpl(
            dates: datesMock,
            planDao: planDaoMock,
            planDayEntryDao: planDayEntryDaoMock,
            planEntityToModelMapper: planEntityToModelMapper,
            playDayEntryEntityToModelMapper: playDayEntryEntityToModelMapper,
          );

          registerFallbackValue(_createPlanEntity());
        },
      );

      tearDown(
        () {
          reset(datesMock);
          reset(planDaoMock);
          reset(planDayEntryDaoMock);
        },
      );

      test(
        'gets plan with success',
        () async {
          const planId = 1;
          final planEntity = _createPlanEntity();
          final fullPlan = _createFullPlan();

          when(() => datesMock.now()).thenReturn(DateTime.utc(2022, 7, 6));
          when(() => planDaoMock.findOneById(any())).thenAnswer((_) async => planEntity);
          when(() => planDayEntryDaoMock.findManyByPlanId(any()))
              .thenAnswer((_) async => _createPlanDayEntryEntities());

          final result = await planLocalSource.getPlan(id: planId).run();

          verify(() => datesMock.now()).called(1);
          verify(() => planDaoMock.findOneById(any())).called(1);
          verify(() => planDayEntryDaoMock.findManyByPlanId(any())).called(1);

          expect(result, Right<GeneralFailure, FullPlan>(fullPlan));
        },
      );

      test(
        'gets plan with failure when plan is absent',
        () async {
          const planId = 1;
          when(() => datesMock.now()).thenReturn(DateTime.utc(2022, 7, 6));
          when(() => planDaoMock.findOneById(any())).thenAnswer((_) async => null);

          final result = await planLocalSource.getPlan(id: planId).run();

          verify(() => datesMock.now()).called(1);
          verify(() => planDaoMock.findOneById(any())).called(1);
          verifyNever(() => planDayEntryDaoMock.findManyByPlanId(any()));

          expect(result, const Left<GeneralFailure, FullPlan>(GeneralFailure.notFound));
        },
      );

      test(
        'gets plan with failure when error occurs',
        () async {
          const planId = 1;
          when(() => datesMock.now()).thenReturn(DateTime.utc(2022, 7, 6));
          when(() => planDaoMock.findOneById(any())).thenThrow(Exception('error'));

          final result = await planLocalSource.getPlan(id: planId).run();

          verify(() => datesMock.now()).called(1);
          verify(() => planDaoMock.findOneById(any())).called(1);
          verifyNever(() => planDayEntryDaoMock.findManyByPlanId(any()));

          expect(result, const Left<GeneralFailure, FullPlan>(GeneralFailure.fatal));
        },
      );

      test(
        'creates plan with success',
        () async {
          when(() => datesMock.now()).thenReturn(DateTime.utc(2022, 7, 6));
          when(() => planDaoMock.insertOne(any())).thenAnswer((_) async => 1);
          when(() => planDayEntryDaoMock.insertMany(any()))
              .thenAnswer((_) async => [1, 2, 3, 4, 5, 6, 7]);

          final result = await planLocalSource
              .createPlan(
                userId: 1,
                name: 'Plan',
                current: true,
              )
              .run();

          verify(() => datesMock.now()).called(1);
          verify(() => planDaoMock.insertOne(any())).called(1);
          verify(() => planDayEntryDaoMock.insertMany(any())).called(1);

          expect(result, const Right<GeneralFailure, int>(1));
        },
      );

      test(
        'creates plan with failure',
        () async {
          when(() => datesMock.now()).thenReturn(DateTime.utc(2022, 7, 6));
          when(() => planDaoMock.insertOne(any())).thenThrow(Exception('error'));

          final result = await planLocalSource
              .createPlan(
                userId: 1,
                name: 'Plan',
                current: true,
              )
              .run();

          verify(() => datesMock.now()).called(1);
          verify(() => planDaoMock.insertOne(any())).called(1);
          verifyNever(() => planDayEntryDaoMock.insertMany(any()));

          expect(result, const Left<GeneralFailure, int>(GeneralFailure.fatal));
        },
      );
    },
  );
}

PlanEntity _createPlanEntity([int id = 1, String name = 'Plan', bool current = true]) {
  return PlanEntity(
    id: id,
    userId: 1,
    name: name,
    current: current,
    createdAt: DateTime.utc(2022, 7, 6).toIso8601String(),
    updatedAt: DateTime.utc(2022, 7, 6).toIso8601String(),
  );
}

List<PlanDayEntryEntity> _createPlanDayEntryEntities([int planId = 1]) {
  return [
    PlanDayEntryEntity(
      id: 1,
      planId: planId,
      dayOfWeek: DateTime.monday,
      name: 'Math',
      start: DateTime.utc(2022, 7, 6, 8).toIso8601String(),
      end: DateTime.utc(2022, 7, 6, 8, 45).toIso8601String(),
      createdAt: DateTime.utc(2022, 7, 6).toIso8601String(),
      updatedAt: DateTime.utc(2022, 7, 6).toIso8601String(),
    ),
    PlanDayEntryEntity(
      id: 2,
      planId: planId,
      dayOfWeek: DateTime.monday,
      name: 'History',
      start: DateTime.utc(2022, 7, 6, 9).toIso8601String(),
      end: DateTime.utc(2022, 7, 6, 9, 45).toIso8601String(),
      createdAt: DateTime.utc(2022, 7, 6).toIso8601String(),
      updatedAt: DateTime.utc(2022, 7, 6).toIso8601String(),
    ),
  ];
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
        date: DateTime.utc(2022, 7, 4),
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
            pauseMinutes: 0,
          ),
        ],
      ),
    ],
  );
}
