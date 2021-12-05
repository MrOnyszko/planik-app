import 'package:mockito/annotations.dart';
import 'package:planik/foundation/foundation.dart';
import 'package:planik/local/dao/user_dao.dart';
import 'package:planik/local/store/user_store.dart';

@GenerateMocks([
  Dates,
  UserDao,
  UserStore,
])
void main() {}
