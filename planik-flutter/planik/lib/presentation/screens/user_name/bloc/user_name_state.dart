part of 'user_name_bloc.dart';

@freezed
class UserNameState with _$UserNameState {
  const factory UserNameState({
    required String name,
    required bool userHasBeenCreated,
    required StateType type,
    required UserNameArgument argument,
  }) = _UserNameState;

  factory UserNameState.initial({
    required UserNameArgument argument,
  }) {
    return UserNameState(
      name: '',
      userHasBeenCreated: false,
      type: StateType.loaded,
      argument: argument,
    );
  }
}

extension UserNameStates on UserNameState {
  bool get isConfirmEnabled => name.isNotEmpty && name.length > 3;
}
