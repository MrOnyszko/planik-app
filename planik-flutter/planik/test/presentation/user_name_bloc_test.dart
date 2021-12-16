import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/user.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/user_name/bloc/user_name_bloc.dart';
import 'package:planik/presentation/screens/user_name/user_name_argument.dart';

import 'presentation_mocks.dart';

void main() {
  final UserNameArgument argument = UserNameArgument();
  final MockUserService mockUserService = MockUserService();
  late UserNameBloc userNameBloc;

  setUp(() {
    userNameBloc = UserNameBloc(
      userService: mockUserService,
      argument: argument,
    );
  });

  tearDown(
    () {
      userNameBloc.close();
    },
  );

  blocTest<UserNameBloc, UserNameState>(
    """
      emits UserNameState with name 
        when UserNameEvent.userNameChanged() is added
    """,
    build: () => userNameBloc,
    act: (bloc) {
      bloc
        ..add(const UserNameEvent.userNameChanged(name: 'a'))
        ..add(const UserNameEvent.userNameChanged(name: 'ab'))
        ..add(const UserNameEvent.userNameChanged(name: 'abc'))
        ..add(const UserNameEvent.userNameChanged(name: 'abcd'));
    },
    verify: (bloc) {
      expect(bloc.state.isConfirmEnabled, true);
    },
    expect: () => [
      UserNameState.initial(argument: argument).copyWith(name: 'a'),
      UserNameState.initial(argument: argument).copyWith(name: 'ab'),
      UserNameState.initial(argument: argument).copyWith(name: 'abc'),
      UserNameState.initial(argument: argument).copyWith(name: 'abcd'),
    ],
  );

  blocTest<UserNameBloc, UserNameState>(
    '''
      emits UserNameState with userHasBeenCreated set true
        when UserNameEvent.confirmed() is added
    ''',
    build: () => userNameBloc,
    setUp: () {
      when(() => mockUserService.createUser(nickname: any(named: 'nickname')))
          .thenAnswer((_) => TaskEither.right(_createUser(1, 'uid', 'nickname')));
    },
    seed: () => UserNameState.initial(argument: argument).copyWith(name: 'abcd'),
    act: (bloc) {
      bloc.add(const UserNameEvent.confirmed());
    },
    verify: (bloc) {
      expect(bloc.state.isConfirmEnabled, true);
    },
    expect: () => [
      UserNameState.initial(argument: argument).copyWith(name: 'abcd', type: StateType.loading),
      UserNameState.initial(argument: argument).copyWith(
        name: 'abcd',
        type: StateType.loaded,
        openCreatePlanIncentiveScreen: true,
      ),
      UserNameState.initial(argument: argument).copyWith(
        name: 'abcd',
        type: StateType.loaded,
        openCreatePlanIncentiveScreen: false,
      ),
    ],
  );

  blocTest<UserNameBloc, UserNameState>(
    '''
      emits UserNameState with StateType.error
        when UserNameEvent.confirmed() is added but user creation error occurred
    ''',
    build: () => userNameBloc,
    setUp: () {
      when(() => mockUserService.createUser(nickname: any(named: 'nickname')))
          .thenAnswer((_) => TaskEither.left(GeneralFailure.fatal));
    },
    seed: () => UserNameState.initial(argument: argument).copyWith(name: 'abcd'),
    act: (bloc) {
      bloc.add(const UserNameEvent.confirmed());
    },
    verify: (bloc) {
      expect(bloc.state.isConfirmEnabled, true);
    },
    expect: () => [
      UserNameState.initial(argument: argument).copyWith(name: 'abcd', type: StateType.loading),
      UserNameState.initial(argument: argument).copyWith(
        name: 'abcd',
        type: StateType.error,
        openCreatePlanIncentiveScreen: false,
      ),
    ],
  );

  blocTest<UserNameBloc, UserNameState>(
    '''
      emits UserNameState
        when UserNameEvent.confirmed() is added but name is empty
    ''',
    build: () => userNameBloc,
    setUp: () {
      when(() => mockUserService.createUser(nickname: any(named: 'nickname')))
          .thenAnswer((_) => TaskEither.left(GeneralFailure.fatal));
    },
    seed: () => UserNameState.initial(argument: argument).copyWith(name: ''),
    act: (bloc) {
      bloc.add(const UserNameEvent.confirmed());
    },
    verify: (bloc) {
      expect(bloc.state.isConfirmEnabled, false);
    },
    expect: () => [],
  );
}

User _createUser(int id, String uid, String nickname) {
  return User(
    id: id,
    uid: uid,
    nickname: nickname,
    createdAt: DateTime(2020, 2, 2, 1, 1, 1, 1),
    updatedAt: DateTime(2020, 2, 2, 1, 1, 1, 1),
  );
}
