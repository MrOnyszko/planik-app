import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/service/plan_service.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/create_plan/bloc/create_plan_bloc.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';

class MockPlanService extends Mock implements PlanService {}

void main() {
  late MockPlanService mockPlanService;

  setUp(
    () {
      mockPlanService = MockPlanService();
    },
  );

  tearDown(
    () {
      reset(mockPlanService);
    },
  );

  CreatePlanBloc _build({required int? id}) {
    return CreatePlanBloc(
      argument: CreatePlanArgument(id: id),
      planService: mockPlanService,
    );
  }

  blocTest<CreatePlanBloc, CreatePlanState>(
    'On CreatePlanEvent.started() it creates plan when id is not provided in argument',
    build: () => _build(id: null),
    setUp: () {
      when(
        () => mockPlanService.addPlan(
          name: any(named: 'name', that: equals("")),
          current: any(named: 'current', that: equals(true)),
        ),
      ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(_createFullPlan()));
    },
    act: (bloc) {
      bloc.add(const CreatePlanEvent.started());
    },
    verify: (bloc) {
      verify(
        () => mockPlanService.addPlan(
          name: any(named: 'name', that: equals("")),
          current: any(named: 'current', that: equals(true)),
        ),
      ).called(1);
    },
    expect: () => [
      CreatePlanState.initial(argument: const CreatePlanArgument()).copyWith(
        type: StateType.loading,
      ),
      CreatePlanState.initial(argument: const CreatePlanArgument()).copyWith(
        type: StateType.loaded,
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
      )
    ],
  );

  blocTest<CreatePlanBloc, CreatePlanState>(
    'On CreatePlanEvent.started() it reads plan when id not provided in argument',
    build: () => _build(id: 1),
    setUp: () {
      when(
        () => mockPlanService.getPlan(
          id: any(named: 'id', that: equals(1)),
        ),
      ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.right(_createFullPlan()));
    },
    act: (bloc) {
      bloc.add(const CreatePlanEvent.started());
    },
    verify: (bloc) {
      verify(
        () => mockPlanService.getPlan(
          id: any(named: 'id', that: equals(1)),
        ),
      ).called(1);
    },
    expect: () => [
      CreatePlanState.initial(argument: const CreatePlanArgument(id: 1)).copyWith(
        type: StateType.loading,
      ),
      CreatePlanState.initial(argument: const CreatePlanArgument(id: 1)).copyWith(
        type: StateType.loaded,
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
      )
    ],
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