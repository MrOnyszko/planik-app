import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/user_name/bloc/user_name_bloc.dart';
import 'package:planik/presentation/screens/user_name/user_name_argument.dart';
import 'package:planik/presentation/screens/user_name/user_name_screen.dart';
import 'package:planik/presentation/widgets/empty_page_widget.dart';
import 'package:planik/presentation/widgets/error_page_widget.dart';
import 'package:planik/presentation/widgets/loading_page_widget.dart';

import '../../../testable.dart';

class MockUserNameBloc extends MockBloc<UserNameEvent, UserNameState> implements UserNameBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeUserNameEvent extends Fake implements UserNameEvent {}

class FakeRoute extends Fake implements Route {}

void main() {
  group(
    'UserNameScreen',
    () {
      setUpAll(
        () {
          registerFallbackValue(FakeUserNameEvent());
          registerFallbackValue(FakeRoute());
        },
      );

      testWidgets(
        'Given loading state it renders loading page',
        (tester) async {
          // arrange

          final mockUserNameBloc = MockUserNameBloc();
          final state = UserNameState.initial(argument: UserNameArgument());
          when(() => mockUserNameBloc.state).thenReturn(state.copyWith(type: StateType.loading));

          // find
          final page = find.byType(LoadingPage);
          final title = find.text('Planik');

          // test
          await tester.pumpWidget(
            BlocProvider<UserNameBloc>(
              create: (context) => mockUserNameBloc,
              child: const Testable(
                child: UserNameScreen(),
              ),
            ),
          );
          await tester.pump();

          // expect
          expect(page, findsOneWidget);
          expect(title, findsOneWidget);
        },
      );

      testWidgets(
        'Given empty state it renders empty page',
        (tester) async {
          // arrange
          final mockUserNameBloc = MockUserNameBloc();
          final state = UserNameState.initial(argument: UserNameArgument());
          when(() => mockUserNameBloc.state).thenReturn(state.copyWith(type: StateType.empty));

          // find
          final page = find.byType(EmptyPage);
          final title = find.text('Planik');

          // test
          await tester.pumpWidget(
            BlocProvider<UserNameBloc>(
              create: (context) => mockUserNameBloc,
              child: const Testable(
                child: UserNameScreen(),
              ),
            ),
          );
          await tester.pump();

          // expect
          expect(page, findsOneWidget);
          expect(title, findsOneWidget);
        },
      );

      testWidgets(
        'Given error state it renders error page',
        (tester) async {
          // arrange
          final mockUserNameBloc = MockUserNameBloc();
          final state = UserNameState.initial(argument: UserNameArgument());
          when(() => mockUserNameBloc.state).thenReturn(state.copyWith(type: StateType.error));

          // find
          final page = find.byType(ErrorPage);
          final title = find.text('Planik');

          // test
          await tester.pumpWidget(
            BlocProvider<UserNameBloc>(
              create: (context) => mockUserNameBloc,
              child: const Testable(
                child: UserNameScreen(),
              ),
            ),
          );
          await tester.pump();

          // expect
          expect(page, findsOneWidget);
          expect(title, findsOneWidget);
        },
      );

      testWidgets(
        'Given loaded state it renders form',
        (tester) async {
          // arrange
          final mockUserNameBloc = MockUserNameBloc();
          final state = UserNameState.initial(argument: UserNameArgument());
          when(() => mockUserNameBloc.state).thenReturn(state.copyWith(type: StateType.loaded));

          // find
          final input = find.byType(TextFormField);
          final button = find.byType(ElevatedButton);
          final title = find.text('Planik');

          // test
          await tester.pumpWidget(
            BlocProvider<UserNameBloc>(
              create: (context) => mockUserNameBloc,
              child: const Testable(
                child: UserNameScreen(),
              ),
            ),
          );
          await tester.pump();

          // expect
          expect(input, findsOneWidget);
          expect(button, findsOneWidget);
          expect(title, findsOneWidget);
        },
      );

      testWidgets(
        'Given loaded state it renders form and acts properly',
        (tester) async {
          // arrange
          final mockUserNameBloc = MockUserNameBloc();
          final state = UserNameState.initial(argument: UserNameArgument());
          when(() => mockUserNameBloc.state)
              .thenReturn(state.copyWith(type: StateType.loaded, name: 'User'));

          // find
          final input = find.byType(TextFormField);
          final button = find.byType(ElevatedButton);
          final title = find.text('Planik');

          // test
          await tester.pumpWidget(
            BlocProvider<UserNameBloc>(
              create: (context) => mockUserNameBloc,
              child: const Testable(
                child: UserNameScreen(),
              ),
            ),
          );
          await tester.pump();

          await tester.enterText(input, 'User');

          verify(
            () => mockUserNameBloc.add(
              any(that: isA<UserNameChanged>().having((it) => it.name, 'name', 'User')),
            ),
          );

          await tester.tap(button);

          verify(
            () => mockUserNameBloc.add(
              any(that: isA<UserNameConfirmed>()),
            ),
          );

          // expect
          expect(input, findsOneWidget);
          expect(button, findsOneWidget);
          expect(title, findsOneWidget);
        },
      );

      testWidgets(
        'Given action has been dispatched it navigates to CreatePlanIncentiveScreen',
        (tester) async {
          // arrange
          final mockNavigatorObserver = MockNavigatorObserver();

          final mockUserNameBloc = MockUserNameBloc();
          final state = UserNameState.initial(argument: UserNameArgument());

          whenListen(
            mockUserNameBloc,
            Stream<UserNameState>.fromIterable(
              [
                state.copyWith(type: StateType.loading),
                state.copyWith(type: StateType.loaded),
                state.copyWith(type: StateType.loaded, openCreatePlanIncentiveScreen: true),
              ],
            ),
            initialState: state,
          );

          // find
          final input = find.byType(TextFormField);
          final button = find.byType(ElevatedButton);
          final title = find.text('Planik');

          // test
          await tester.pumpWidget(
            BlocProvider<UserNameBloc>(
              create: (context) => mockUserNameBloc,
              child: Testable(
                navigatorObservers: [mockNavigatorObserver],
                onGenerateRoute: (settings) {
                  if (settings.name == '/create-plan-incentive') {
                    return MaterialPageRoute(builder: (context) => const Scaffold());
                  }
                  return null;
                },
                child: const UserNameScreen(),
              ),
            ),
          );
          await tester.pump();

          verify(() => mockNavigatorObserver.didPush(any(), any()));

          await tester.pump();

          // expect
          expect(input, findsOneWidget);
          expect(button, findsOneWidget);
          expect(title, findsOneWidget);
        },
      );
    },
  );
}
