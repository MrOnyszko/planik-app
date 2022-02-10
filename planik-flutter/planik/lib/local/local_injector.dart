import 'package:get_it/get_it.dart';
import 'package:planik/domain/source/plan_local_source.dart';
import 'package:planik/domain/source/user_local_source.dart';
import 'package:planik/local/app_database.dart';
import 'package:planik/local/database_provider.dart';
import 'package:planik/local/mapper/plan_day_entry_entity_to_model_mapper.dart';
import 'package:planik/local/mapper/plan_entity_to_model_mapper.dart';
import 'package:planik/local/mapper/user_entity_to_model_mapper.dart';
import 'package:planik/local/preference_assistant.dart';
import 'package:planik/local/source/plan_local_source_impl.dart';
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
      ..registerSingleton<UserStore>(
        UserStore(preferenceAssistant: get()),
      );
  }

  void _registerSources() {
    this
      ..registerFactory<UserLocalSource>(
        () => UserLocalSourceImpl(
          dates: get(),
          userDao: get(),
          userStore: get(),
          userMapper: get(),
        ),
      )
      ..registerFactory<PlanLocalSource>(
        () => PlanLocalSourceImpl(
          dates: get(),
          planDao: get(),
          planDayEntryDao: get(),
          planEntityToModelMapper: get(),
          playDayEntryEntityToModelMapper: get(),
        ),
      );
  }

  void _registerMappers() {
    this
      ..registerFactory(UserEntityToModelMapper.new)
      ..registerFactory(() => const PlanEntityToModelMapper())
      ..registerFactory(() => const PlayDayEntryEntityToModelMapper());
  }

  void _registerDao() {
    this
      ..registerFactory(() => get<AppDatabase>().userDao)
      ..registerFactory(() => get<AppDatabase>().planDao)
      ..registerFactory(() => get<AppDatabase>().planDayEntryDao);
  }
}
