import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/_SNAKE_CASE_NAME_/_SNAKE_CASE_NAME__argument.dart';

part '_SNAKE_CASE_NAME__bloc.freezed.dart';

part '_SNAKE_CASE_NAME__event.dart';

part '_SNAKE_CASE_NAME__state.dart';

class _UPPER_CAMEL_CASE_NAME_Bloc
    extends Bloc<_UPPER_CAMEL_CASE_NAME_Event, _UPPER_CAMEL_CASE_NAME_State> {
  _UPPER_CAMEL_CASE_NAME_Bloc({
    required _UPPER_CAMEL_CASE_NAME_Argument argument,
  }) : super(_UPPER_CAMEL_CASE_NAME_State.initial(argument: argument)) {
    on<_UPPER_CAMEL_CASE_NAME_Event>(handler, transformer: sequential());
  }

  Future<void> handler(
    _UPPER_CAMEL_CASE_NAME_Event event,
    Emitter<_UPPER_CAMEL_CASE_NAME_State> emit,
  ) async {
    emit(state);
  }
}
