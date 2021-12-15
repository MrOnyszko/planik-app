import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/presentation/navigation_hub/bloc/navigation_hub_bloc.dart';

import 'presentation_mocks.dart';

///
/// when hasUser is true and hasPlan is true then openPlanScreen is true
/// when hasUser is true and hasPlan is false then openCreatePlanIncentiveScreen is true
/// when hasUser is false then openUserNameScreen is true
/// when failure is raised then emit initial state
void main() {
  final MockUserService mockUserService = MockUserService();
  late NavigationHubBloc navigationHubBloc;

  setUp(
    () {
      navigationHubBloc = NavigationHubBloc(
        userService: mockUserService,
      );
    },
  );

  tearDown(
    () async {
      await navigationHubBloc.close();
    },
  );

  blocTest<NavigationHubBloc, NavigationHubState>(
    "when hasUser is true and hasPlan is true then openPlanScreen is true",
    build: () => navigationHubBloc,
    setUp: () {
      when(mockUserService.hasUser).thenAnswer((_) => TaskEither.right(true));
      when(mockUserService.hasPlan).thenAnswer((_) => TaskEither.right(true));
    },
    act: (bloc) {
      bloc.add(const NavigationHubEvent.started());
    },
    verify: (bloc) {
      expect(bloc.state.openPlanScreen, true);
      expect(bloc.state.hasUser, true);
      expect(bloc.state.hasPlan, true);
    },
    expect: () => [
      const NavigationHubState(hasUser: true, hasPlan: true),
    ],
  );

  blocTest<NavigationHubBloc, NavigationHubState>(
    "when hasUser is true and hasPlan is false then openCreatePlanIncentiveScreen is true",
    build: () => navigationHubBloc,
    setUp: () {
      when(mockUserService.hasUser).thenAnswer((_) => TaskEither.right(true));
      when(mockUserService.hasPlan).thenAnswer((_) => TaskEither.right(false));
    },
    act: (bloc) {
      bloc.add(const NavigationHubEvent.started());
    },
    verify: (bloc) {
      expect(bloc.state.openCreatePlanIncentiveScreen, true);
      expect(bloc.state.hasUser, true);
      expect(bloc.state.hasPlan, false);
    },
    expect: () => [
      const NavigationHubState(hasUser: true, hasPlan: false),
    ],
  );

  blocTest<NavigationHubBloc, NavigationHubState>(
    "when hasUser is false then openUserNameScreen is true",
    build: () => navigationHubBloc,
    setUp: () {
      when(mockUserService.hasUser).thenAnswer((_) => TaskEither.right(false));
      when(mockUserService.hasPlan).thenAnswer((_) => TaskEither.right(false));
    },
    act: (bloc) {
      bloc.add(const NavigationHubEvent.started());
    },
    verify: (bloc) {
      expect(bloc.state.openUserNameScreen, true);
      expect(bloc.state.hasUser, false);
      expect(bloc.state.hasPlan, false);
    },
    expect: () => [
      const NavigationHubState(hasUser: false, hasPlan: false),
    ],
  );

  blocTest<NavigationHubBloc, NavigationHubState>(
    "when failure is raised then emit current state",
    build: () => navigationHubBloc,
    setUp: () {
      when(mockUserService.hasUser).thenAnswer((_) => TaskEither.left(GeneralFailure.fatal));
      when(mockUserService.hasPlan).thenAnswer((_) => TaskEither.left(GeneralFailure.fatal));
    },
    act: (bloc) {
      bloc.add(const NavigationHubEvent.started());
    },
    verify: (bloc) {
      expect(bloc.state.hasUser, false);
      expect(bloc.state.hasPlan, false);
    },
    expect: () => [
      const NavigationHubState(hasUser: false, hasPlan: false),
    ],
  );
}
