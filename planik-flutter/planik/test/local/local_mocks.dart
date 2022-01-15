import 'package:mocktail/mocktail.dart';
import 'package:planik/local/dao/user_dao.dart';
import 'package:planik/local/store/user_store.dart';

class MockUserDao extends Mock implements UserDao {}

class MockUserStore extends Mock implements UserStore {}
