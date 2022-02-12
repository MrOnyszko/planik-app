import 'package:planik/local/app_database.dart';
import 'package:planik/local/dao/user_dao.dart';
import 'package:planik/local/entity/user_entity.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('UserDao', () {
    late AppDatabase database;
    late UserDao userDao;

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
      userDao = database.userDao;
    });

    tearDown(() async {
      await database.close();
    });

    group('change single item', () {
      test('insert', () async {
        await userDao.insertOne(user);

        final actual = await userDao.findAll();

        expect(actual, hasLength(1));
      });

      test('delete by id', () async {
        await userDao.insertOne(user);

        await userDao.deleteOneById(user.id!);

        final actual = await userDao.findAll();

        expect(actual, isEmpty);
      });

      test('update', () async {
        await userDao.insertOne(user);

        final updated = user.copyWith(nickname: 'XXXX');

        await userDao.updateOne(updated);

        final actual = await userDao.findOneById(user.id!);

        expect(actual, equals(updated));
      });
    });

    group('querying', () {
      test('find by id user', () async {
        await userDao.insertOne(user);

        final actual = await userDao.findOneById(user.id!);

        expect(actual, equals(user));
      });

      test('find by uid user', () async {
        await userDao.insertOne(user);

        final actual = await userDao.findOneByUid(user.uid);

        expect(actual, equals(user));
      });
    });
  });
}

final user = UserEntity(
  id: 1,
  uid: const Uuid().v4(),
  nickname: 'nickname',
  createdAt: DateTime.now().toIso8601String(),
  updatedAt: DateTime.now().toIso8601String(),
);
