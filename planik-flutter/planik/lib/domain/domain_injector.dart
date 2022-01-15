import 'package:get_it/get_it.dart';
import 'package:planik/domain/service/plan_service.dart';
import 'package:planik/domain/service/user_service.dart';
import 'package:planik/local/local_injector.dart';

extension DomainInjector on GetIt {
  Future<void> registerDomain() async {
    await registerLocal();

    this
      ..registerFactory(() => UserService(userLocalSource: get()))
      ..registerFactory(
        () => PlanService(
          planLocalSource: get(),
          userStore: get(),
        ),
      );
  }
}
