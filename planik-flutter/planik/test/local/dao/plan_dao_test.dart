import 'package:planik/local/app_database.dart';
import 'package:planik/local/dao/plan_dao.dart';
import 'package:planik/local/entity/plan_entity.dart';
import 'package:planik/local/entity/user_entity.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('PlanDao', () {
    late AppDatabase database;
    late PlanDao planDao;

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
      planDao = database.planDao;

      await database.userDao.insertOne(user);
    });

    tearDown(() async {
      await database.close();
    });

    group('change single item', () {
      test('insert plan', () async {
        await planDao.insertOne(plan);

        final actual = await planDao.findAll();

        expect(actual, hasLength(1));
      });

      test('insert or update plan', () async {
        await planDao.insertOrUpdateOne(plan);

        final actual = await planDao.findAll();

        expect(actual, hasLength(1));
      });

      test('delete plan', () async {
        await planDao.insertOne(plan);

        await planDao.deleteOneById(plan.id!);

        final actual = await planDao.findAll();

        expect(actual, isEmpty);
      });

      test('update entity', () async {
        await planDao.insertOne(plan);

        final updated = plan.copyWith(name: 'Planik');

        await planDao.updateOne(updated);

        final actual = await planDao.findOneById(plan.id!);

        expect(actual, equals(updated));
      });
    });

    group('change multiple items', () {
      test('insert plans', () async {
        await planDao.insertMany(plans);

        final actual = await planDao.findAll();

        expect(actual, equals(plans));
      });

      test('insert or update plans', () async {
        await planDao.insertOrUpdateMany(plans);

        final actual = await planDao.findAll();

        expect(actual, equals(plans));
      });

      test('delete plans', () async {
        await planDao.insertMany(plans);

        await planDao.deleteMany(plans);

        final actual = await planDao.findAll();

        expect(actual, isEmpty);
      });

      test('update plans', () async {
        await planDao.insertMany(plans);

        final updated = plans
            .map(
              (plan) => plan.copyWith(name: plan.name.hashCode.toString()),
            )
            .toList();

        await planDao.updateMany(updated);

        final actual = await planDao.findAll();

        expect(actual, equals(updated));
      });
    });

    group('querying', () {
      test('find current plan', () async {
        await planDao.insertOne(plan);
        await planDao.insertMany(plans);

        final actual = await planDao.findCurrent();

        expect(actual, equals(plan));
      });

      test('paginate', () async {
        final plans = List.generate(
          100,
          (index) => PlanEntity(
            id: index,
            userId: 1,
            name: '$index',
            current: index == 0,
            createdAt: DateTime.now().toIso8601String(),
            updatedAt: null,
          ),
        );

        await planDao.insertMany(plans);

        final actual = await planDao.findManyBy(10, 10);

        expect(actual, equals(plans.sublist(11, 21)));
      });
    });
  });
}

final user = UserEntity(
  id: null,
  uid: const Uuid().v4(),
  nickname: 'nickname',
  createdAt: DateTime.now().toIso8601String(),
  updatedAt: DateTime.now().toIso8601String(),
);

final plan = PlanEntity(
  id: 1,
  userId: 1,
  name: 'Plan',
  current: true,
  createdAt: DateTime.now().toIso8601String(),
  updatedAt: DateTime.now().toIso8601String(),
);

final plans = [
  PlanEntity(
    id: 2,
    userId: 1,
    name: 'Plan A',
    current: false,
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
  ),
  PlanEntity(
    id: 3,
    userId: 1,
    name: 'Plan B',
    current: false,
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
  )
];
