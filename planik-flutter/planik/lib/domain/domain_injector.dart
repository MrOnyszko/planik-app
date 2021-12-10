import 'package:get_it/get_it.dart';
import 'package:planik/domain/service/user_service.dart';
import 'package:planik/local/local_injector.dart';
import 'package:planik/presentation/injector_container.dart';

extension DomainInjector on GetIt {
  Future<void> registerDomain() async {
    await registerLocal();

    registerFactory(() => UserService(userLocalSource: injector.get()));
  }
}
