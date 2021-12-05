import 'dart:async';

import 'package:floor/floor.dart';
import 'package:planik/local/dao/plan_day_entry_dao.dart';
import 'package:planik/local/dao/user_dao.dart';
import 'package:planik/local/entity/plan_day_entry_entity.dart';
import 'package:planik/local/entity/plan_entity.dart';
import 'package:planik/local/entity/user_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/plan_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [
  UserEntity,
  PlanEntity,
  PlanDayEntryEntity,
])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;

  PlanDao get planDao;

  PlanDayEntryDao get planDayEntryDao;
}
