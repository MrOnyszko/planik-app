import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/user.dart';
import 'package:planik/domain/source/user_local_source.dart';
import 'package:planik/local/entity/user_entity.dart';
import 'package:planik/local/mapper/user_entity_to_model_mapper.dart';
import 'package:planik/local/source/user_local_source_impl.dart';
import 'package:uuid/uuid.dart';

import '../../mocks.dart';
import 'local_mocks.dart';

void main() {
  group(
    "UserLocalSource",
    () {
      final MockDates datesMock = MockDates();
      final MockUserDao userDaoMock = MockUserDao();
      final MockUserStore userStoreMock = MockUserStore();

      final UserLocalSource userLocalSource = UserLocalSourceImpl(
        dates: datesMock,
        userDao: userDaoMock,
        userStore: userStoreMock,
        userMapper: UserEntityToModelMapper(),
      );

      setUpAll(
        () {
          registerFallbackValue(_createUserEntity('', ''));
        },
      );

      test(
        'gets current user id with success',
        () async {
          const userId = 1;
          when(userStoreMock.getId).thenAnswer((_) async => userId);

          final result = await userLocalSource.currentUserId().run();

          final id = result.getRight().getOrElse(() => -1);

          expect(id, userId);
          expect(result.isRight(), true);
        },
      );

      test(
        'do not get current user id with success',
        () async {
          const userId = null;
          when(userStoreMock.getId).thenAnswer((_) async => userId);

          final result = await userLocalSource.currentUserId().run();

          final failure = result.getLeft().getOrElse(() => GeneralFailure.fatal);

          expect(failure, GeneralFailure.notFound);
          expect(result.isLeft(), true);
        },
      );

      test(
        'gets has plan id with success',
        () async {
          when(userStoreMock.getHasPlan).thenAnswer((_) async => true);

          final result = await userLocalSource.hasPlan().run();

          final hasPlan = result.getRight().getOrElse(() => false);

          expect(hasPlan, true);
          expect(result.isRight(), true);
        },
      );

      test(
        'do not get has plan with success',
        () async {
          when(userStoreMock.getHasPlan).thenAnswer((_) async => false);

          final result = await userLocalSource.hasPlan().run();

          final hasPlan = result.getRight().getOrElse(() => false);

          expect(hasPlan, false);
          expect(result.isRight(), true);
        },
      );

      test(
        'sets has plan with success',
        () async {
          when(() => userStoreMock.putHasPlan(hasPlan: true)).thenAnswer((_) async {});

          final result = await userLocalSource.setHasPlan(hasPlan: true).run();

          final value = result.getRight().getOrElse(() => unit);

          expect(value, unit);
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

          final entity = _createUserEntity(
            userUid,
            nickname,
          ).copyWith(createdAt: now.toIso8601String());

          final user = _createUser(
            userId,
            userUid,
            nickname,
          ).copyWith(createdAt: now);

          when(userStoreMock.getUid).thenAnswer((_) async => userUid);
          when(() => userDaoMock.findOneByUid(userUid)).thenAnswer((_) async => entity);

          final result = await userLocalSource.getCurrentUser().run();

          final value = result.getRight();

          expect(value, Option.fromNullable(user));
          expect(result.isRight(), true);
        },
      );

      test(
        'creates user with success',
        () async {
          const userId = 1;
          final userUid = const Uuid().v4();
          const nickname = 'User';
          final now = DateTime(2020, 2, 2, 1, 1, 1, 1);

          final entity = _createUserEntity(
            userUid,
            nickname,
          ).copyWith(createdAt: now.toIso8601String());

          final user = _createUser(
            userId,
            userUid,
            nickname,
          ).copyWith(createdAt: now);

          when(() => userStoreMock.putId(id: userId)).thenAnswer((_) async {});
          when(() => userStoreMock.putUid(uid: userUid)).thenAnswer((_) async {});
          when(userStoreMock.getUid).thenAnswer((_) async => userUid);
          when(datesMock.now).thenAnswer((_) => now);
          when(() => userDaoMock.insertOne(any())).thenAnswer((_) async => userId);
          when(() => userDaoMock.findOneByUid(userUid)).thenAnswer((_) async => entity);

          final result = await userLocalSource.create(nickname: nickname, uid: userUid).run();

          final value = result.getRight();

          expect(value, Option.fromNullable(user));
          expect(result.isRight(), true);

          verify(() => userStoreMock.putId(id: userId)).called(1);
          verify(() => userStoreMock.putUid(uid: userUid)).called(1);
        },
      );
    },
  );
}

UserEntity _createUserEntity(String uid, String nickname) {
  return UserEntity(
    id: 1,
    uid: uid,
    nickname: nickname,
    createdAt: DateTime(2020, 2, 2, 1, 1, 1, 1).toIso8601String(),
    updatedAt: DateTime(2020, 2, 2, 1, 1, 1, 1).toIso8601String(),
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
