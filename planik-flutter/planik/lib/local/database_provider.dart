import 'package:planik/local/app_database.dart';

class DatabaseProvider {
  static Future<AppDatabase> getInstance({bool inMemory = false}) {
    if (inMemory) {
      return $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    }

    return $FloorAppDatabase.databaseBuilder('planik.db').build();
  }
}
