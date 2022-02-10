import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/presentation/components/navigation_hub/bloc/navigation_hub_bloc.dart';

import '../presentation_mocks.dart';

///
/// when hasUser is true and hasPlan is true then openPlanScreen is true
/// when hasUser is true and hasPlan is false then openCreatePlanIncentiveScreen is true
/// when hasUser is false then openUserNameScreen is true
/// when failure is raised then hasError is true
void main() {
  late MockUserService mockUserService;
  late NavigationHubBloc navigationHubBloc;

  setUp(
    () {
      mockUserService = MockUserService();
      navigationHubBloc = NavigationHubBloc(
        userService: mockUserService,
      );
    },
  );

  tearDown(
    () {
      reset(mockUserService);
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
      expect(bloc.state.hasError, false);
    },
    expect: () => [
      const NavigationHubState(hasUser: true, hasPlan: true, hasError: false),
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
      expect(bloc.state.hasError, false);
    },
    expect: () => [
      const NavigationHubState(hasUser: true, hasPlan: false, hasError: false),
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
      expect(bloc.state.hasError, false);
    },
    expect: () => [
      const NavigationHubState(hasUser: false, hasPlan: false, hasError: false),
    ],
  );

  blocTest<NavigationHubBloc, NavigationHubState>(
    "when failure is raised then hasError is true",
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
      expect(bloc.state.hasError, true);
    },
    expect: () => [
      const NavigationHubState(hasUser: false, hasPlan: false, hasError: true),
    ],
  );
}
