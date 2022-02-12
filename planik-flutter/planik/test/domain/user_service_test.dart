import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/user.dart';
import 'package:planik/domain/service/user_service.dart';
import 'package:uuid/uuid.dart';

import 'domain_mocks.dart';

void main() {
  group(
    "UserService",
    () {
      late MockUserLocalSource mockUserLocalSource;
      late UserService userService;

      setUp(
        () {
          mockUserLocalSource = MockUserLocalSource();
          userService = UserService(
            userLocalSource: mockUserLocalSource,
          );
        },
      );

      tearDown(
        () {
          reset(mockUserLocalSource);
        },
      );

      test(
        'gets has user id with success',
        () async {
          when(mockUserLocalSource.hasUser).thenAnswer((_) => TaskEither.right(true));

          final result = await userService.hasUser().run();

          expect(result, const Right(true));
        },
      );

      test(
        'do not get has user with success',
        () async {
          when(mockUserLocalSource.hasUser).thenAnswer((_) => TaskEither.left(GeneralFailure.fatal));

          final result = await userService.hasUser().run();

          expect(result, const Left(GeneralFailure.fatal));
        },
      );

      test(
        'gets has plan id with success',
        () async {
          when(mockUserLocalSource.hasPlan).thenAnswer((_) => TaskEither.right(true));

          final result = await userService.hasPlan().run();

          final hasPlan = result.getRight().getOrElse(() => false);

          expect(hasPlan, true);
          expect(result.isRight(), true);
        },
      );

      test(
        'do not get has plan with success',
        () async {
          when(mockUserLocalSource.hasPlan).thenAnswer((_) => TaskEither.right(false));

          final result = await userService.hasPlan().run();

          final hasPlan = result.getRight().getOrElse(() => false);

          expect(hasPlan, false);
          expect(result.isRight(), true);
        },
      );

      test(
        'gets current user with success',
        () async {
          const userId = 1;
          final userUid = const Uuid().v4();
          const nickname = 'User';
          final now = DateTime(2020, 2, 2, 1, 1, 1, 1);

          final user = _createUser(
            userId,
            userUid,
            nickname,
          ).copyWith(createdAt: now);

          when(mockUserLocalSource.getCurrentUser).thenAnswer((_) => TaskEither.right(user));

          final result = await userService.getCurrentUser().run();

          final value = result.getRight();

          expect(value, Option.fromNullable(user));
          expect(result.isRight(), true);
        },
      );

      test(
        'creates user with success',
        () async {
          const userId = 1;
          const nickname = 'User';
          final userUid = Uuid(
            options: {'seedBytes': nickname.codeUnits},
          ).v4();
          final now = DateTime(2020, 2, 2, 1, 1, 1, 1);

          final user = _createUser(
            userId,
            userUid,
            nickname,
          ).copyWith(createdAt: now);

          when(() => mockUserLocalSource.create(
                  nickname: any(named: 'nickname'), uid: any(named: 'uid')))
              .thenAnswer((_) => TaskEither<GeneralFailure, User>.right(user));

          final result = await userService.createUser(nickname: nickname).run();

          final value = result.getRight();

          expect(value, Option.fromNullable(user));
          expect(result.isRight(), true);
        },
      );
    },
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
