import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/service/user_service.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/user_name/user_name_argument.dart';

part 'user_name_bloc.freezed.dart';

part 'user_name_event.dart';

part 'user_name_state.dart';

class UserNameBloc extends Bloc<UserNameEvent, UserNameState> {
  UserNameBloc({
    required UserService userService,
    required UserNameArgument argument,
  })  : _userService = userService,
        super(UserNameState.initial(argument: argument)) {
    on<UserNameEvent>(handler, transformer: sequential());
  }

  final UserService _userService;

  Future<void> handler(UserNameEvent event, Emitter<UserNameState> emit) async {
    await event.map(
      userNameChanged: (value) async {
        emit(state.copyWith(name: value.name));
      },
      confirmed: (_) async {
        if (state.name.isNotEmpty) {
          emit(state.copyWith(type: StateType.loading));
          await _userService
              .createUser(nickname: state.name)
              .match(
                (error) => emit(state.copyWith(type: StateType.error)),
                (_) => emit(state.copyWith(type: StateType.loaded, userHasBeenCreated: true)),
              )
              .run();
        }
      },
    );
  }
}
