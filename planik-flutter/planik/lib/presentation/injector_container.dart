import 'package:get_it/get_it.dart';
import 'package:planik/domain/domain_injector.dart';
import 'package:planik/foundation/foundation.dart';

final injector = GetIt.instance;

Future<void> init() async {
  await injector.registerDomain();

  injector.registerSingleton<Dates>(DatesImpl());
}
