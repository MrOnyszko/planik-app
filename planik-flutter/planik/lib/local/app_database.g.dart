// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  PlanDao? _planDaoInstance;

  PlanDayEntryDao? _planDayEntryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `uid` TEXT NOT NULL, `nickname` TEXT NOT NULL, `created_at` TEXT NOT NULL, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `plans` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `user_id` INTEGER NOT NULL, `name` TEXT NOT NULL, `current` INTEGER NOT NULL, `created_at` TEXT NOT NULL, `updated_at` TEXT, FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `plan_day_entries` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `plan_id` INTEGER NOT NULL, `day_of_week` INTEGER NOT NULL, `name` TEXT NOT NULL, `start` TEXT NOT NULL, `end` TEXT NOT NULL, `created_at` TEXT NOT NULL, `updated_at` TEXT, FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE INDEX `index_plans_user_id` ON `plans` (`user_id`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  PlanDao get planDao {
    return _planDaoInstance ??= _$PlanDao(database, changeListener);
  }

  @override
  PlanDayEntryDao get planDayEntryDao {
    return _planDayEntryDaoInstance ??=
        _$PlanDayEntryDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'nickname': item.nickname,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'nickname': item.nickname,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'nickname': item.nickname,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<List<UserEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            uid: row['uid'] as String,
            nickname: row['nickname'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<UserEntity?> findOneById(int id) async {
    return _queryAdapter.query('SELECT * FROM users WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            uid: row['uid'] as String,
            nickname: row['nickname'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<UserEntity?> findOneByUid(String uid) async {
    return _queryAdapter.query('SELECT * FROM users WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as int?,
            uid: row['uid'] as String,
            nickname: row['nickname'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?),
        arguments: [uid]);
  }

  @override
  Future<void> deleteOneById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM users WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertOne(UserEntity entity) {
    return _userEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateOne(UserEntity entity) {
    return _userEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMany(List<UserEntity> entities) async {
    await _userEntityDeletionAdapter.deleteList(entities);
  }
}

class _$PlanDao extends PlanDao {
  _$PlanDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _planEntityInsertionAdapter = InsertionAdapter(
            database,
            'plans',
            (PlanEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'name': item.name,
                  'current': item.current ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _planEntityUpdateAdapter = UpdateAdapter(
            database,
            'plans',
            ['id'],
            (PlanEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'name': item.name,
                  'current': item.current ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _planEntityDeletionAdapter = DeletionAdapter(
            database,
            'plans',
            ['id'],
            (PlanEntity item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.userId,
                  'name': item.name,
                  'current': item.current ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlanEntity> _planEntityInsertionAdapter;

  final UpdateAdapter<PlanEntity> _planEntityUpdateAdapter;

  final DeletionAdapter<PlanEntity> _planEntityDeletionAdapter;

  @override
  Future<List<PlanEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM plans',
        mapper: (Map<String, Object?> row) => PlanEntity(
            userId: row['user_id'] as int,
            name: row['name'] as String,
            current: (row['current'] as int) != 0,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<List<PlanEntity>> findManyBy(int lastId, int limit) async {
    return _queryAdapter.queryList(
        'SELECT * FROM plans WHERE id > ?1 ORDER BY current DESC LIMIT ?2',
        mapper: (Map<String, Object?> row) => PlanEntity(
            userId: row['user_id'] as int,
            name: row['name'] as String,
            current: (row['current'] as int) != 0,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?,
            id: row['id'] as int?),
        arguments: [lastId, limit]);
  }

  @override
  Future<PlanEntity?> findOneById(int id) async {
    return _queryAdapter.query('SELECT * FROM plans WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PlanEntity(
            userId: row['user_id'] as int,
            name: row['name'] as String,
            current: (row['current'] as int) != 0,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<PlanEntity?> findCurrent() async {
    return _queryAdapter.query('SELECT * FROM plans WHERE current = 1',
        mapper: (Map<String, Object?> row) => PlanEntity(
            userId: row['user_id'] as int,
            name: row['name'] as String,
            current: (row['current'] as int) != 0,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<void> deleteOneById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM plans WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertOne(PlanEntity entity) {
    return _planEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertMany(List<PlanEntity> entities) {
    return _planEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateOne(PlanEntity entity) {
    return _planEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateMany(List<PlanEntity> entities) {
    return _planEntityUpdateAdapter.updateListAndReturnChangedRows(
        entities, OnConflictStrategy.ignore);
  }

  @override
  Future<void> deleteMany(List<PlanEntity> entities) async {
    await _planEntityDeletionAdapter.deleteList(entities);
  }

  @override
  Future<void> insertOrUpdateOne(PlanEntity entity) async {
    if (database is sqflite.Transaction) {
      await super.insertOrUpdateOne(entity);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.planDao.insertOrUpdateOne(entity);
      });
    }
  }

  @override
  Future<void> insertOrUpdateMany(List<PlanEntity> entities) async {
    if (database is sqflite.Transaction) {
      await super.insertOrUpdateMany(entities);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.planDao.insertOrUpdateMany(entities);
      });
    }
  }
}

class _$PlanDayEntryDao extends PlanDayEntryDao {
  _$PlanDayEntryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _planDayEntryEntityInsertionAdapter = InsertionAdapter(
            database,
            'plan_day_entries',
            (PlanDayEntryEntity item) => <String, Object?>{
                  'id': item.id,
                  'plan_id': item.planId,
                  'day_of_week': item.dayOfWeek,
                  'name': item.name,
                  'start': item.start,
                  'end': item.end,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _planDayEntryEntityUpdateAdapter = UpdateAdapter(
            database,
            'plan_day_entries',
            ['id'],
            (PlanDayEntryEntity item) => <String, Object?>{
                  'id': item.id,
                  'plan_id': item.planId,
                  'day_of_week': item.dayOfWeek,
                  'name': item.name,
                  'start': item.start,
                  'end': item.end,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _planDayEntryEntityDeletionAdapter = DeletionAdapter(
            database,
            'plan_day_entries',
            ['id'],
            (PlanDayEntryEntity item) => <String, Object?>{
                  'id': item.id,
                  'plan_id': item.planId,
                  'day_of_week': item.dayOfWeek,
                  'name': item.name,
                  'start': item.start,
                  'end': item.end,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlanDayEntryEntity>
      _planDayEntryEntityInsertionAdapter;

  final UpdateAdapter<PlanDayEntryEntity> _planDayEntryEntityUpdateAdapter;

  final DeletionAdapter<PlanDayEntryEntity> _planDayEntryEntityDeletionAdapter;

  @override
  Future<List<PlanDayEntryEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM plan_day_entries',
        mapper: (Map<String, Object?> row) => PlanDayEntryEntity(
            id: row['id'] as int?,
            planId: row['plan_id'] as int,
            dayOfWeek: row['day_of_week'] as int,
            name: row['name'] as String,
            start: row['start'] as String,
            end: row['end'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<List<PlanDayEntryEntity>> findManyBy(int planId, int dayOfWeek) async {
    return _queryAdapter.queryList(
        'SELECT * FROM plan_day_entries DE WHERE DE.plan_id = ?1 AND DE.day_of_week = ?2',
        mapper: (Map<String, Object?> row) => PlanDayEntryEntity(id: row['id'] as int?, planId: row['plan_id'] as int, dayOfWeek: row['day_of_week'] as int, name: row['name'] as String, start: row['start'] as String, end: row['end'] as String, createdAt: row['created_at'] as String, updatedAt: row['updated_at'] as String?),
        arguments: [planId, dayOfWeek]);
  }

  @override
  Future<List<PlanDayEntryEntity>> findManyByPlanId(int planId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM plan_day_entries DE WHERE DE.plan_id = ?1',
        mapper: (Map<String, Object?> row) => PlanDayEntryEntity(
            id: row['id'] as int?,
            planId: row['plan_id'] as int,
            dayOfWeek: row['day_of_week'] as int,
            name: row['name'] as String,
            start: row['start'] as String,
            end: row['end'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?),
        arguments: [planId]);
  }

  @override
  Future<List<PlanDayEntryEntity>> findManyFromCurrentPlan() async {
    return _queryAdapter.queryList(
        'SELECT DE.* FROM plan_day_entries DE JOIN plans P ON DE.plan_id = P.id AND P.current',
        mapper: (Map<String, Object?> row) => PlanDayEntryEntity(
            id: row['id'] as int?,
            planId: row['plan_id'] as int,
            dayOfWeek: row['day_of_week'] as int,
            name: row['name'] as String,
            start: row['start'] as String,
            end: row['end'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<PlanDayEntryEntity?> findOneById(int id) async {
    return _queryAdapter.query('SELECT * FROM plan_day_entries WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PlanDayEntryEntity(
            id: row['id'] as int?,
            planId: row['plan_id'] as int,
            dayOfWeek: row['day_of_week'] as int,
            name: row['name'] as String,
            start: row['start'] as String,
            end: row['end'] as String,
            createdAt: row['created_at'] as String,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteOneById(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM plan_day_entries WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insertOne(PlanDayEntryEntity entity) {
    return _planDayEntryEntityInsertionAdapter.insertAndReturnId(
        entity, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertMany(List<PlanDayEntryEntity> entities) {
    return _planDayEntryEntityInsertionAdapter.insertListAndReturnIds(
        entities, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateOne(PlanDayEntryEntity entity) {
    return _planDayEntryEntityUpdateAdapter.updateAndReturnChangedRows(
        entity, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateMany(List<PlanDayEntryEntity> entities) {
    return _planDayEntryEntityUpdateAdapter.updateListAndReturnChangedRows(
        entities, OnConflictStrategy.ignore);
  }

  @override
  Future<void> deleteMany(List<PlanDayEntryEntity> entities) async {
    await _planDayEntryEntityDeletionAdapter.deleteList(entities);
  }

  @override
  Future<void> insertOrUpdateOne(PlanDayEntryEntity entity) async {
    if (database is sqflite.Transaction) {
      await super.insertOrUpdateOne(entity);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.planDayEntryDao.insertOrUpdateOne(entity);
      });
    }
  }

  @override
  Future<void> insertOrUpdateMany(List<PlanDayEntryEntity> entities) async {
    if (database is sqflite.Transaction) {
      await super.insertOrUpdateMany(entities);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.planDayEntryDao.insertOrUpdateMany(entities);
      });
    }
  }
}
