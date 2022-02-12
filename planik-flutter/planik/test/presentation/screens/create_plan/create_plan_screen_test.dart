import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/create_plan/bloc/create_plan_bloc.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_name_form_widget.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_screen.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

import '../../../testable.dart';

class MockCreatePlanBloc extends MockBloc<CreatePlanEvent, CreatePlanState>
    implements CreatePlanBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

class FakeCreatePlanNameChanged extends Fake implements CreatePlanNameChanged {}

void main() {
  group(
    'CreatePlanScreen',
    () {
      setUpAll(
        () {
          registerFallbackValue(FakeRoute());
          registerFallbackValue(FakeCreatePlanNameChanged());
        },
      );

      testWidgets(
        'Given loading state it renders loading page',
        (tester) async {
          // arrange
          final mockCreatePlanBloc = MockCreatePlanBloc();
          final state = CreatePlanState.initial(argument: const CreatePlanArgument());
          when(() => mockCreatePlanBloc.state).thenReturn(state.copyWith(type: StateType.loading));

          // find
          final loadingPage = find.byType(LoadingPage);

          // test
          await tester.pumpWidget(
            BlocProvider<CreatePlanBloc>(
              create: (context) => mockCreatePlanBloc,
              child: const Testable(
                child: CreatePlanScreen(),
              ),
            ),
          );
          await tester.pump();

          // expect
          expect(loadingPage, findsOneWidget);
        },
      );

      testWidgets(
        'Given error state it renders error page',
        (tester) async {
          // arrange
          final mockCreatePlanBloc = MockCreatePlanBloc();
          final state = CreatePlanState.initial(argument: const CreatePlanArgument());
          when(() => mockCreatePlanBloc.state).thenReturn(state.copyWith(type: StateType.error));

          // find
          final loadingPage = find.byType(ErrorPage);

          // test
          await tester.pumpWidget(
            BlocProvider<CreatePlanBloc>(
              create: (context) => mockCreatePlanBloc,
              child: const Testable(
                child: CreatePlanScreen(),
              ),
            ),
          );
          await tester.pump();

          // expect
          expect(loadingPage, findsOneWidget);
        },
      );

      testWidgets(
        'Given empty state it renders empty page',
        (tester) async {
          // arrange
          final mockCreatePlanBloc = MockCreatePlanBloc();
          final state = CreatePlanState.initial(argument: const CreatePlanArgument());
          when(() => mockCreatePlanBloc.state).thenReturn(state.copyWith(type: StateType.empty));

          // find
          final emptyPage = find.byType(EmptyPage);

          // test
          await tester.pumpWidget(
            BlocProvider<CreatePlanBloc>(
              create: (context) => mockCreatePlanBloc,
              child: const Testable(
                child: CreatePlanScreen(),
              ),
            ),
          );
          await tester.pump();

          // expect
          expect(emptyPage, findsOneWidget);
        },
      );

      testWidgets(
        'Given loaded state it renders form and acts with WillPopScope correctly',
        (tester) async {
          // arrange
          final tuesday = Day(
            ordinal: 1,
            name: 'Tuesday',
            date: DateTime.utc(2020, 7, 6),
            entries: [
              DayEntry(
                id: 1,
                dayOfWeek: DateTime.tuesday,
                title: 'Math',
                start: DateTime.utc(2020, 7, 6, 8),
                end: DateTime.utc(2020, 7, 6, 8, 45),
                pauseMinutes: 15,
              )
            ],
          );

          final plan = Plan(
            id: 1,
            name: 'Name',
            current: true,
            createdAt: DateTime.utc(2022, 7, 6),
            updatedAt: DateTime.utc(2022, 7, 6),
          );

          final mockNavigatorObserver = MockNavigatorObserver();

          final mockCreatePlanBloc = MockCreatePlanBloc();
          final state = CreatePlanState.initial(argument: const CreatePlanArgument());
          when(() => mockCreatePlanBloc.state).thenReturn(
            state.copyWith(
              type: StateType.loaded,
              days: [tuesday],
              plan: plan,
            ),
          );

          // find
          final nameForm = find.byType(CreatePlanNameForm);
          final dayEntryItem = find.text('Math');
          final dayTab = find.text('Tuesday');

          // test
          await tester.pumpWidget(
            BlocProvider<CreatePlanBloc>(
              create: (context) => mockCreatePlanBloc,
              child: Testable(
                navigatorObservers: [mockNavigatorObserver],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(builder: (context) => const Scaffold());
                },
                child: const CreatePlanScreen(),
              ),
            ),
          );
          await tester.pump();

          final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
          await widgetsAppState.didPopRoute();

          verify(() => mockNavigatorObserver.didPop(any(), any()));

          await tester.pump();

          // expect
          expect(nameForm, findsOneWidget);
          expect(dayEntryItem, findsOneWidget);
          expect(dayTab, findsOneWidget);
        },
      );

      testWidgets(
        'Given loaded state it renders form and changes name correctly',
        (tester) async {
          // arrange
          final tuesday = Day(
            ordinal: 1,
            name: 'Tuesday',
            date: DateTime.utc(2020, 7, 6),
            entries: [
              DayEntry(
                id: 1,
                dayOfWeek: DateTime.tuesday,
                title: 'Math',
                start: DateTime.utc(2020, 7, 6, 8),
                end: DateTime.utc(2020, 7, 6, 8, 45),
                pauseMinutes: 15,
              )
            ],
          );

          final plan = Plan(
            id: 1,
            name: 'Name',
            current: true,
            createdAt: DateTime.utc(2022, 7, 6),
            updatedAt: DateTime.utc(2022, 7, 6),
          );

          final mockNavigatorObserver = MockNavigatorObserver();

          final mockCreatePlanBloc = MockCreatePlanBloc();
          final state = CreatePlanState.initial(argument: const CreatePlanArgument());
          when(() => mockCreatePlanBloc.state).thenReturn(
            state.copyWith(
              type: StateType.loaded,
              days: [tuesday],
              plan: plan,
            ),
          );

          // find
          final nameForm = find.byType(CreatePlanNameForm);
          final formTextFormField = find.byType(TextFormField);
          final allDoneIcon = find.byType(IconButton);
          final dayEntryItem = find.text('Math');
          final dayTab = find.text('Tuesday');

          // test
          await tester.pumpWidget(
            BlocProvider<CreatePlanBloc>(
              create: (context) => mockCreatePlanBloc,
              child: Testable(
                navigatorObservers: [mockNavigatorObserver],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(builder: (context) => const Scaffold());
                },
                child: const CreatePlanScreen(),
              ),
            ),
          );
          await tester.pump();

          await tester.enterText(formTextFormField, 'XXX');

          verify(() => mockCreatePlanBloc.add(any(that: isA<CreatePlanNameChanged>())));

          await tester.tap(allDoneIcon);

          verify(() => mockNavigatorObserver.didPop(any(), any()));

          await tester.pump();

          // expect
          expect(nameForm, findsOneWidget);
          expect(dayEntryItem, findsOneWidget);
          expect(dayTab, findsOneWidget);
        },
      );
    },
  );
}
