import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/components/pagination/pagination.dart';
import 'package:planik/presentation/screens/plan/plan_screen.dart';
import 'package:planik/presentation/screens/plans/bloc/plans_bloc.dart';
import 'package:planik/presentation/screens/plans/plans_argument.dart';
import 'package:planik/presentation/screens/plans/plans_screen.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

import '../../../testable.dart';

class MockPlansBloc extends MockBloc<PlansEvent, PlansState> implements PlansBloc {}

class MockPlansPaginationBloc extends MockBloc<PaginationEvent, PaginationState<Plan>>
    implements PaginationBloc<Plan> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  group(
    'PlansScreen',
    () {
      setUpAll(
        () {
          registerFallbackValue(FakeRoute());
        },
      );

      testWidgets(
        'Given loading state in PlansBloc it renders list view',
        (tester) async {
          // arrange
          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.loading));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial();
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: const Testable(child: PlansScreen()),
            ),
          );
          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
        },
      );

      testWidgets(
        'Given error state in PlansBloc it renders list view',
        (tester) async {
          // arrange
          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.error));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial();
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: const Testable(child: PlansScreen()),
            ),
          );
          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
        },
      );

      testWidgets(
        'Given loaded state in PlansBloc it renders list view',
        (tester) async {
          // arrange
          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.loaded));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial();
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: const Testable(child: PlansScreen()),
            ),
          );
          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
        },
      );

      testWidgets(
        'Given empty state in PlansBloc it renders list view',
        (tester) async {
          // arrange
          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.empty));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial();
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: const Testable(child: PlansScreen()),
            ),
          );
          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
        },
      );

      testWidgets(
        'Given loading state in PaginationBloc<Plan> it renders list view with loading page',
        (tester) async {
          // arrange
          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.loaded));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial().copyWith(isLoading: true);
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);
          final page = find.byType(LoadingPage);

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: const Testable(child: PlansScreen()),
            ),
          );
          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
          expect(page, findsOneWidget);
        },
      );

      testWidgets(
        'Given empty state in PaginationBloc<Plan> it renders list view with empty page',
        (tester) async {
          // arrange
          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.loaded));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial().copyWith(isLoading: false);
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);
          final page = find.byType(EmptyPage);

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: const Testable(child: PlansScreen()),
            ),
          );
          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
          expect(page, findsOneWidget);
        },
      );

      testWidgets(
        'Given error state in PaginationBloc<Plan> it renders list view with error page',
        (tester) async {
          // arrange
          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.loaded));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial().copyWith(hasError: true);
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);
          final page = find.byType(ErrorPage);

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: const Testable(child: PlansScreen()),
            ),
          );
          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
          expect(page, findsOneWidget);
        },
      );

      testWidgets(
        'Given loaded state in PaginationBloc<Plan> it renders list view with elements '
        'also it navigates to PlanScreen on ListTile tap event',
        (tester) async {
          // arrange
          final mockNavigatorObserver = MockNavigatorObserver();

          final mockPlansBloc = MockPlansBloc();
          final state = PlansState.initial(argument: const PlansArgument());
          when(() => mockPlansBloc.state).thenReturn(state.copyWith(type: StateType.loaded));

          final mockPlansPaginationBloc = MockPlansPaginationBloc();
          final plansPaginationState = PaginationState<Plan>.initial().copyWith(
            items: [
              Plan(
                id: 0,
                name: 'Plan 1',
                current: true,
                createdAt: DateTime(2022),
                updatedAt: DateTime(2022),
              ),
              Plan(
                id: 1,
                name: 'Plan 2',
                current: false,
                createdAt: DateTime(2022),
                updatedAt: DateTime(2022),
              ),
              Plan(
                id: 2,
                name: 'Plan 3',
                current: false,
                createdAt: DateTime(2022),
                updatedAt: DateTime(2022),
              ),
            ],
          );
          when(() => mockPlansPaginationBloc.state).thenReturn(plansPaginationState);

          // find
          final listView = find.byType(Pagination<Plan>);
          final listTile = find.byType(ListTile);
          final divider = find.byType(Divider);
          final firstPlanText = find.text('0 Plan 1');

          // test
          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider<PlansBloc>(create: (context) => mockPlansBloc),
                BlocProvider<PaginationBloc<Plan>>(create: (context) => mockPlansPaginationBloc),
              ],
              child: Testable(
                navigatorObservers: [mockNavigatorObserver],
                onGenerateRoute: (settings) {
                  if (settings.name == '/plan') {
                    return MaterialPageRoute(builder: (context) => const Scaffold());
                  }
                  return null;
                },
                child: const PlansScreen(),
              ),
            ),
          );
          await tester.pump();

          await tester.tap(listTile.first);

          verify(() => mockNavigatorObserver.didPush(any(), any()));

          await tester.pump();

          // expect
          expect(listView, findsOneWidget);
          expect(listTile, findsNWidgets(3));
          expect(divider, findsNWidgets(2));
          expect(firstPlanText, findsOneWidget);
        },
      );
    },
  );
}
