import 'package:get_it/get_it.dart';
import 'package:planik/local/app_database.dart';
import 'package:planik/local/database_provider.dart';
import 'package:planik/local/mapper/user_entity_to_model_mapper.dart';
import 'package:planik/local/preference_assistant.dart';
import 'package:planik/local/store/user_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension LocalInjector on GetIt {
  Future<void> registerLocal() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final database = await DatabaseProvider.getInstance();
    this
      .._registerMappers()
      .._registerDao()
      ..registerSingleton(database)
      ..registerFactory<SharedPreferences>(() => sharedPreferences)
      ..registerFactory<PreferenceAssistant>(
        () => PreferenceAssistant(sharedPreferences: get()),
      )
      ..registerFactory<UserStore>(
        () => UserStore(
          secureStorage: get(),
        ),
      );
  }

  void _registerMappers() {
    this..registerFactory(() => UserEntityToModelMapper());
  }

  void _registerDao() {
    this
      ..registerFactory(() => get<AppDatabase>().userDao)
      ..registerFactory(() => get<AppDatabase>().planDao)
      ..registerFactory(() => get<AppDatabase>().planDayEntryDao);
  }
}
