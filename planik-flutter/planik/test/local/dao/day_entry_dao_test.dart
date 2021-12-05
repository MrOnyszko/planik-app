import 'package:planik/local/app_database.dart';
import 'package:planik/local/dao/plan_dao.dart';
import 'package:planik/local/dao/plan_day_entry_dao.dart';
import 'package:planik/local/entity/plan_day_entry_entity.dart';
import 'package:planik/local/entity/plan_entity.dart';
import 'package:planik/local/entity/user_entity.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('PlanDayEntryDao', () {
    late AppDatabase database;
    late PlanDao planDao;
    late PlanDayEntryDao planDayEntryDao;

    setUp(() async {
      database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
      planDao = database.planDao;
      planDayEntryDao = database.planDayEntryDao;

      await database.userDao.insertOne(user);
      await planDao.insertOne(plan);
    });

    tearDown(() async {
      await database.close();
    });

    group('change single item', () {
      test('insert day entry', () async {
        await planDayEntryDao.insertOne(dayEntry);

        final actual = await planDayEntryDao.findAll();

        expect(actual, hasLength(1));
      });

      test('insert or update day entry', () async {
        await planDayEntryDao.insertOrUpdateOne(dayEntry);

        final actual = await planDayEntryDao.findAll();

        expect(actual, hasLength(1));
      });

      test('delete day entry', () async {
        await planDayEntryDao.insertOne(dayEntry);

        await planDayEntryDao.deleteOneById(dayEntry.id!);

        final actual = await planDayEntryDao.findAll();

        expect(actual, isEmpty);
      });

      test('update day entry', () async {
        await planDayEntryDao.insertOne(dayEntry);

        final updated = dayEntry.copyWith(name: 'History');

        await planDayEntryDao.updateOne(updated);

        final actual = await planDayEntryDao.findOneById(dayEntry.id!);

        expect(actual, equals(updated));
      });
    });

    group('querying', () {
      test('find many by plan id', () async {
        await planDayEntryDao.insertMany(dayEntries);

        final actual = await planDayEntryDao.findManyByPlanId(plan.id!);

        expect(actual, hasLength(3));
      });

      test('find many by plan id and day', () async {
        await planDayEntryDao.insertMany(dayEntries);

        final actual = await planDayEntryDao.findManyBy(plan.id!, 2);

        expect(actual, hasLength(1));
      });

      test('find many from current plan', () async {
        await planDao.insertMany(plans);
        await planDayEntryDao.insertMany(dayEntries);
        await planDayEntryDao.insertOne(dayEntryOfPlanY);

        final actual = await planDayEntryDao.findManyFromCurrentPlan();

        expect(actual, hasLength(3));
      });
    });

    group('change multiple items', () {
      test('insert day entries', () async {
        await planDayEntryDao.insertMany(dayEntries);

        final actual = await planDayEntryDao.findAll();

        expect(actual, equals(dayEntries));
      });

      test('insert or update plans', () async {
        await planDayEntryDao.insertOrUpdateMany(dayEntries);

        final actual = await planDayEntryDao.findAll();

        expect(actual, equals(dayEntries));
      });

      test('delete day entries', () async {
        await planDayEntryDao.insertMany(dayEntries);

        await planDayEntryDao.deleteMany(dayEntries);

        final actual = await planDayEntryDao.findAll();

        expect(actual, isEmpty);
      });

      test('update day entries', () async {
        await planDayEntryDao.insertMany(dayEntries);

        final updated = dayEntries
            .map(
              (dayEntry) => dayEntry.copyWith(name: dayEntry.name.hashCode.toString()),
            )
            .toList();

        await planDayEntryDao.updateMany(updated);

        final actual = await planDayEntryDao.findAll();

        expect(actual, equals(updated));
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

final dayEntries = [
  PlanDayEntryEntity(
    id: 1,
    planId: plan.id!,
    dayOfWeek: 1,
    name: 'Math',
    start: DateTime.now().toIso8601String(),
    end: DateTime.now().toIso8601String(),
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: null,
  ),
  PlanDayEntryEntity(
    id: 2,
    planId: plan.id!,
    dayOfWeek: 1,
    name: 'History',
    start: DateTime.now().toIso8601String(),
    end: DateTime.now().toIso8601String(),
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: null,
  ),
  PlanDayEntryEntity(
    id: 3,
    planId: plan.id!,
    dayOfWeek: 2,
    name: 'Latin',
    start: DateTime.now().toIso8601String(),
    end: DateTime.now().toIso8601String(),
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: null,
  ),
];

final dayEntry = PlanDayEntryEntity(
  id: 1,
  planId: plan.id!,
  dayOfWeek: 1,
  name: 'Math',
  start: DateTime.now().toIso8601String(),
  end: DateTime.now().toIso8601String(),
  createdAt: DateTime.now().toIso8601String(),
  updatedAt: null,
);

final plans = [
  PlanEntity(
    id: 20,
    userId: 1,
    name: 'Plan Y',
    current: false,
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
  ),
  PlanEntity(
    id: 30,
    userId: 1,
    name: 'Plan Z',
    current: false,
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
  )
];

final dayEntryOfPlanY = PlanDayEntryEntity(
  id: 90,
  planId: 20,
  dayOfWeek: 1,
  name: 'Russian',
  start: DateTime.now().toIso8601String(),
  end: DateTime.now().toIso8601String(),
  createdAt: DateTime.now().toIso8601String(),
  updatedAt: null,
);
