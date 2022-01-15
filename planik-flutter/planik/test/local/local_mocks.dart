import 'package:mocktail/mocktail.dart';
import 'package:planik/local/dao/plan_dao.dart';
import 'package:planik/local/dao/plan_day_entry_dao.dart';
import 'package:planik/local/dao/user_dao.dart';
import 'package:planik/local/store/user_store.dart';

class MockUserDao extends Mock implements UserDao {}

class MockPlanDao extends Mock implements PlanDao {}

class MockPlanDayEntryDao extends Mock implements PlanDayEntryDao {}

class MockUserStore extends Mock implements UserStore {}
