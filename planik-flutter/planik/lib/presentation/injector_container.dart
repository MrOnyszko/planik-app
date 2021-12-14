import 'package:get_it/get_it.dart';
import 'package:planik/domain/domain_injector.dart';
import 'package:planik/foundation/foundation.dart';
import 'package:planik/presentation/screens/user_name/bloc/user_name_bloc.dart';
import 'package:planik/presentation/screens/user_name/user_name_argument.dart';

final injector = GetIt.instance;

Future<void> init() async {
  await injector.registerDomain();

  injector
    ..registerSingleton<Dates>(DatesImpl())
    ..registerFactoryParam<UserNameBloc, UserNameArgument, void>(
      (argument, _) => UserNameBloc(
        userService: injector.get(),
        argument: argument,
      ),
    );
}
