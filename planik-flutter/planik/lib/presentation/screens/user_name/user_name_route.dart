import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/injector_container.dart';
import 'package:planik/presentation/screens/user_name/bloc/user_name_bloc.dart';
import 'package:planik/presentation/screens/user_name/user_name_argument.dart';
import 'package:planik/presentation/screens/user_name/user_name_screen.dart';

Route<dynamic> userNameRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<UserNameBloc>(
          create: (context) => injector<UserNameBloc>(
            param1: settings.arguments ?? UserNameArgument(),
          ),
        ),
      ],
      child: const UserNameScreen(),
    ),
  );
}
