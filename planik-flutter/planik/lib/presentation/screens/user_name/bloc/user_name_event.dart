part of 'user_name_bloc.dart';

@freezed
class UserNameEvent with _$UserNameEvent {
  const factory UserNameEvent.userNameChanged({required String name}) = _UserNameChanged;

  const factory UserNameEvent.confirmed() = _UserNameConfirmed;
}
