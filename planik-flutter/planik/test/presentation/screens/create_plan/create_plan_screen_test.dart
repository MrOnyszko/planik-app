import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/day_entry.dart';
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

void main() {
  group(
    'CreatePlanScreen',
    () {
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
        'Given loaded state it renders form',
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

          final mockCreatePlanBloc = MockCreatePlanBloc();
          final state = CreatePlanState.initial(argument: const CreatePlanArgument());
          when(() => mockCreatePlanBloc.state).thenReturn(
            state.copyWith(
              type: StateType.loaded,
              days: [tuesday],
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
              child: const Testable(
                child: CreatePlanScreen(),
              ),
            ),
          );
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
