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
import '../local_mocks.dart';

void main() {
  group(
    "UserLocalSource",
    () {
      late MockDates datesMock;
      late MockUserDao userDaoMock;
      late MockUserStore userStoreMock;
      late UserLocalSource userLocalSource;

      setUp(
        () {
          datesMock = MockDates();
          userDaoMock = MockUserDao();
          userStoreMock = MockUserStore();

          userLocalSource = UserLocalSourceImpl(
            dates: datesMock,
            userDao: userDaoMock,
            userStore: userStoreMock,
            userMapper: UserEntityToModelMapper(),
          );

          registerFallbackValue(_createUserEntity('', ''));
        },
      );

      tearDown(
        () {
          reset(datesMock);
          reset(userDaoMock);
          reset(userStoreMock);
        },
      );

      group(
        'call currentUserId',
        () {
          test(
            'gets current user id with success',
            () async {
              const userId = 1;
              when(userStoreMock.getId).thenAnswer((_) => userId);

              final result = await userLocalSource.currentUserId().run();

              expect(result, const Right(userId));
            },
          );

          test(
            'gets current user id with GeneralFailure.notFound',
            () async {
              const userId = null;
              when(userStoreMock.getId).thenAnswer((_) => userId);

              final result = await userLocalSource.currentUserId().run();

              expect(result, const Left(GeneralFailure.notFound));
            },
          );

          test(
            'gets current user id with GeneralFailure.fatal',
            () async {
              when(userStoreMock.getId).thenThrow(Exception(''));

              final result = await userLocalSource.currentUserId().run();

              expect(result, const Left(GeneralFailure.fatal));
            },
          );
        },
      );

      group(
        'call currentPlanId',
        () {
          test(
            'gets current plan id with success',
            () async {
              const planId = 1;
              when(userStoreMock.getCurrentPlanId).thenAnswer((_) => planId);

              final result = await userLocalSource.currentPlanId().run();

              expect(result, const Right<GeneralFailure, int>(planId));
            },
          );

          test(
            'gets current plan id with GeneralFailure.notFound',
            () async {
              const planId = null;
              when(userStoreMock.getCurrentPlanId).thenAnswer((_) => planId);

              final result = await userLocalSource.currentPlanId().run();

              expect(result, const Left<GeneralFailure, int>(GeneralFailure.notFound));
            },
          );

          test(
            'gets current plan id with GeneralFailure.fatal',
            () async {
              when(userStoreMock.getCurrentPlanId).thenThrow(Exception(''));

              final result = await userLocalSource.currentPlanId().run();

              expect(result, const Left<GeneralFailure, int>(GeneralFailure.fatal));
            },
          );
        },
      );

      group(
        'call setCurrentPlanId',
        () {
          test(
            'sets current plan id with success',
            () async {
              when(() => userStoreMock.putCurrentPlanId(id: 1)).thenAnswer((_) async {});

              final result = await userLocalSource.setCurrentPlanId(id: 1).run();

              expect(result, const Right(1));
            },
          );

          test(
            'sets current plan id GeneralFailure.fatal',
            () async {
              when(() => userStoreMock.putCurrentPlanId(id: 1)).thenThrow(Exception('error'));

              final result = await userLocalSource.setCurrentPlanId(id: 1).run();

              expect(result, const Left(GeneralFailure.fatal));
            },
          );
        },
      );

      group(
        'call hasPlan',
        () {
          test(
            'gets has plan id with success',
            () async {
              when(userStoreMock.getHasPlan).thenAnswer((_) => true);

              final result = await userLocalSource.hasPlan().run();

              expect(result, const Right(true));
            },
          );

          test(
            'gets has plan with value false',
            () async {
              when(userStoreMock.getHasPlan).thenAnswer((_) => false);

              final result = await userLocalSource.hasPlan().run();

              expect(result, const Right(false));
            },
          );

          test(
            'gets has plan with GeneralFailure.fatal',
            () async {
              when(userStoreMock.getHasPlan).thenThrow(Exception('error'));

              final result = await userLocalSource.hasPlan().run();

              expect(result, const Left(GeneralFailure.fatal));
            },
          );
        },
      );

      group(
        'call hasUser',
        () {
          test(
            'gets has user id with success',
            () async {
              when(userStoreMock.getUid).thenAnswer((_) => '');

              final result = await userLocalSource.hasUser().run();

              expect(result, const Right(true));
            },
          );

          test(
            'gets has user with value false',
            () async {
              when(userStoreMock.getUid).thenAnswer((_) => null);

              final result = await userLocalSource.hasUser().run();

              expect(result, const Right(false));
            },
          );

          test(
            'gets has user with GeneralFailure.fatal',
            () async {
              when(userStoreMock.getUid).thenThrow(Exception('error'));

              final result = await userLocalSource.hasUser().run();

              expect(result, const Left(GeneralFailure.fatal));
            },
          );
        },
      );

      group(
        'call setHasPlan',
        () {
          test(
            'sets has plan with success',
            () async {
              when(() => userStoreMock.putHasPlan(hasPlan: true)).thenAnswer((_) async {});

              final result = await userLocalSource.setHasPlan(hasPlan: true).run();

              expect(result, const Right(unit));
            },
          );

          test(
            'sets has plan with GeneralFailure.fatal',
            () async {
              when(() => userStoreMock.putHasPlan(hasPlan: true)).thenThrow(Exception('error'));

              final result = await userLocalSource.setHasPlan(hasPlan: true).run();

              expect(result, const Left(GeneralFailure.fatal));
            },
          );
        },
      );

      group(
        'call getCurrentUser',
        () {
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

              when(userStoreMock.getUid).thenAnswer((_) => userUid);
              when(() => userDaoMock.findOneByUid(userUid)).thenAnswer((_) async => entity);

              final result = await userLocalSource.getCurrentUser().run();

              expect(result, Right(user));
            },
          );

          test(
            'gets current user with GeneralFailure.notFound because findOneByUid returns null',
            () async {
              final userUid = const Uuid().v4();

              when(userStoreMock.getUid).thenAnswer((_) => userUid);
              when(() => userDaoMock.findOneByUid(userUid)).thenAnswer((_) async => null);

              final result = await userLocalSource.getCurrentUser().run();

              expect(result, const Left(GeneralFailure.notFound));
            },
          );

          test(
            'gets current user with GeneralFailure.notFound because getUid returns null',
            () async {
              when(userStoreMock.getUid).thenAnswer((_) => null);

              final result = await userLocalSource.getCurrentUser().run();

              expect(result, const Left(GeneralFailure.notFound));
            },
          );

          test(
            'gets current user with GeneralFailure.fatal',
            () async {
              when(userStoreMock.getUid).thenThrow(Exception('error'));

              final result = await userLocalSource.getCurrentUser().run();

              expect(result, const Left(GeneralFailure.fatal));
            },
          );
        },
      );

      group(
        'call create',
        () {
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
              when(userStoreMock.getUid).thenAnswer((_) => userUid);
              when(datesMock.now).thenAnswer((_) => now);
              when(() => userDaoMock.insertOne(any())).thenAnswer((_) async => userId);
              when(() => userDaoMock.findOneByUid(userUid)).thenAnswer((_) async => entity);

              final result = await userLocalSource.create(nickname: nickname, uid: userUid).run();

              expect(result, Right(user));

              verify(() => userStoreMock.putId(id: userId)).called(1);
              verify(() => userStoreMock.putUid(uid: userUid)).called(1);
            },
          );

          test(
            'creates user with GeneralFailure.fatal because insertOne throws',
            () async {
              final userUid = const Uuid().v4();
              const nickname = 'User';

              when(() => userDaoMock.insertOne(any())).thenThrow(Exception(''));

              final result = await userLocalSource.create(nickname: nickname, uid: userUid).run();

              expect(result, const Left(GeneralFailure.fatal));
            },
          );
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
