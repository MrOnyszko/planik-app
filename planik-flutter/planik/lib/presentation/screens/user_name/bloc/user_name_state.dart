part of 'user_name_bloc.dart';

@freezed
class UserNameState with _$UserNameState {
  const factory UserNameState({
    required String name,
    required bool openCreatePlanIncentiveScreen,
    required StateType type,
    required UserNameArgument argument,
  }) = _UserNameState;

  factory UserNameState.initial({
    required UserNameArgument argument,
  }) {
    return UserNameState(
      name: '',
      openCreatePlanIncentiveScreen: false,
      type: StateType.loaded,
      argument: argument,
    );
  }
}

extension UserNameStates on UserNameState {
  bool get isConfirmEnabled => name.isNotEmpty && name.length > 3;
}
