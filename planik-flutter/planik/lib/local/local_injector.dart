import 'package:get_it/get_it.dart';
import 'package:planik/domain/source/user_local_source.dart';
import 'package:planik/local/app_database.dart';
import 'package:planik/local/database_provider.dart';
import 'package:planik/local/mapper/user_entity_to_model_mapper.dart';
import 'package:planik/local/preference_assistant.dart';
import 'package:planik/local/source/user_local_source_impl.dart';
import 'package:planik/local/store/user_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension LocalInjector on GetIt {
  Future<void> registerLocal() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final database = await DatabaseProvider.getInstance();
    this
      .._registerMappers()
      .._registerDao()
      .._registerSources()
      ..registerSingleton(database)
      ..registerFactory<SharedPreferences>(() => sharedPreferences)
      ..registerFactory<PreferenceAssistant>(
        () => PreferenceAssistant(
          sharedPreferences: get(),
        ),
      )
      ..registerFactory<UserStore>(
        () => UserStore(
          secureStorage: get(),
        ),
      );
  }

  void _registerSources() {
    registerFactory<UserLocalSource>(
      () => UserLocalSourceImpl(
        dates: get(),
        userDao: get(),
        userStore: get(),
        userMapper: get(),
      ),
    );
  }

  void _registerMappers() {
    registerFactory(() => UserEntityToModelMapper());
  }

  void _registerDao() {
    this
      ..registerFactory(() => get<AppDatabase>().userDao)
      ..registerFactory(() => get<AppDatabase>().planDao)
      ..registerFactory(() => get<AppDatabase>().planDayEntryDao);
  }
}
