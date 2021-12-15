import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/service/user_service.dart';

part 'navigation_hub_bloc.freezed.dart';

part 'navigation_hub_event.dart';

part 'navigation_hub_state.dart';

class NavigationHubBloc extends Bloc<NavigationHubEvent, NavigationHubState> {
  NavigationHubBloc({
    required UserService userService,
  })  : _userService = userService,
        super(NavigationHubState.initial()) {
    on<NavigationHubEvent>(handler, transformer: sequential());
  }

  final UserService _userService;

  Future<void> handler(
    NavigationHubEvent event,
    Emitter<NavigationHubState> emit,
  ) async {
    await event.map(
      started: (_) async {
        await _userService
            .hasUser()
            .flatMap(
              (hasUser) => _userService
                  .hasPlan()
                  .map((hasPlan) => state.copyWith(hasUser: hasUser, hasPlan: hasPlan)),
            )
            .match((l) => emit(NavigationHubState.initial()), (newState) => emit(newState))
            .run();
      },
    );
  }
}
