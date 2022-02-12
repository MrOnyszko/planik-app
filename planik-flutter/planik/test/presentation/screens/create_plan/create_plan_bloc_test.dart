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
        days: [_createDay()],
        plan: _createPlan(),
      )
    ],
  );

  blocTest<CreatePlanBloc, CreatePlanState>(
    'On CreatePlanEvent.started() it creates plan when id is not provided in argument it emits error',
    build: () => _build(id: null),
    setUp: () {
      when(
        () => mockPlanService.addPlan(
          name: any(named: 'name', that: equals("")),
          current: any(named: 'current', that: equals(true)),
        ),
      ).thenAnswer((_) => TaskEither<GeneralFailure, FullPlan>.left(GeneralFailure.fatal));
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
        type: StateType.error,
      )
    ],
  );

  blocTest<CreatePlanBloc, CreatePlanState>(
    'On CreatePlanEvent.started() it reads plan when id is not provided in argument',
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
        days: [_createDay()],
        plan: _createPlan(),
      )
    ],
  );

  blocTest<CreatePlanBloc, CreatePlanState>(
    'On CreatePlanEvent.planNameChanged(name: XXX) it updates plan name',
    build: () => _build(id: 1),
    setUp: () {
      when(
        () => mockPlanService.updatePlan(
          id: any(named: 'id', that: equals(1)),
          name: any(named: 'name', that: equals('XXX')),
          current: any(named: 'current', that: equals(null)),
        ),
      ).thenAnswer((invocation) => TaskEither.right(_createFullPlan(name: 'XXX')));
    },
    seed: () => CreatePlanState.initial(argument: const CreatePlanArgument(id: 1)).copyWith(
      type: StateType.loaded,
      days: [_createDay()],
      plan: _createPlan(),
    ),
    act: (bloc) {
      bloc.add(const CreatePlanEvent.planNameChanged(name: 'XXX'));
    },
    verify: (bloc) {
      verify(
        () => mockPlanService.updatePlan(
          id: any(named: 'id', that: equals(1)),
          name: any(named: 'name', that: equals('XXX')),
          current: any(named: 'current', that: equals(null)),
        ),
      ).called(1);
    },
    expect: () => [
      CreatePlanState.initial(argument: const CreatePlanArgument(id: 1)).copyWith(
        type: StateType.loaded,
        days: [_createDay()],
        plan: _createPlan(name: 'XXX'),
      )
    ],
  );

  blocTest<CreatePlanBloc, CreatePlanState>(
    'On CreatePlanEvent.planNameChanged(name: XXX) it emits error',
    build: () => _build(id: 1),
    setUp: () {
      when(
        () => mockPlanService.updatePlan(
          id: any(named: 'id', that: equals(1)),
          name: any(named: 'name', that: equals('XXX')),
          current: any(named: 'current', that: equals(null)),
        ),
      ).thenAnswer((invocation) => TaskEither.left(GeneralFailure.fatal));
    },
    seed: () => CreatePlanState.initial(argument: const CreatePlanArgument(id: 1)).copyWith(
      type: StateType.loaded,
      days: [_createDay()],
      plan: _createPlan(),
    ),
    act: (bloc) {
      bloc.add(const CreatePlanEvent.planNameChanged(name: 'XXX'));
    },
    verify: (bloc) {
      verify(
        () => mockPlanService.updatePlan(
          id: any(named: 'id', that: equals(1)),
          name: any(named: 'name', that: equals('XXX')),
          current: any(named: 'current', that: equals(null)),
        ),
      ).called(1);
    },
    expect: () => [
      CreatePlanState.initial(argument: const CreatePlanArgument(id: 1)).copyWith(
        type: StateType.error,
        days: [_createDay()],
        plan: _createPlan(),
      )
    ],
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

Day _createDay() {
  return Day(
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
  );
}

FullPlan _createFullPlan({
  int id = 1,
  String name = 'Plan',
  bool current = true,
}) {
  return FullPlan(
    plan: _createPlan(id: id, name: name, current: current),
    days: [
      _createDay(),
    ],
  );
}
