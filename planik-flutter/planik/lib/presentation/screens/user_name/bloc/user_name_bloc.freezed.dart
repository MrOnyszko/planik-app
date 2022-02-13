// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_name_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserNameEventTearOff {
  const _$UserNameEventTearOff();

  UserNameChanged userNameChanged({required String name}) {
    return UserNameChanged(
      name: name,
    );
  }

  UserNameConfirmed confirmed() {
    return const UserNameConfirmed();
  }
}

/// @nodoc
const $UserNameEvent = _$UserNameEventTearOff();

/// @nodoc
mixin _$UserNameEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) userNameChanged,
    required TResult Function() confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? userNameChanged,
    TResult Function()? confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? userNameChanged,
    TResult Function()? confirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserNameChanged value) userNameChanged,
    required TResult Function(UserNameConfirmed value) confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserNameChanged value)? userNameChanged,
    TResult Function(UserNameConfirmed value)? confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserNameChanged value)? userNameChanged,
    TResult Function(UserNameConfirmed value)? confirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNameEventCopyWith<$Res> {
  factory $UserNameEventCopyWith(
          UserNameEvent value, $Res Function(UserNameEvent) then) =
      _$UserNameEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserNameEventCopyWithImpl<$Res>
    implements $UserNameEventCopyWith<$Res> {
  _$UserNameEventCopyWithImpl(this._value, this._then);

  final UserNameEvent _value;
  // ignore: unused_field
  final $Res Function(UserNameEvent) _then;
}

/// @nodoc
abstract class $UserNameChangedCopyWith<$Res> {
  factory $UserNameChangedCopyWith(
          UserNameChanged value, $Res Function(UserNameChanged) then) =
      _$UserNameChangedCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$UserNameChangedCopyWithImpl<$Res>
    extends _$UserNameEventCopyWithImpl<$Res>
    implements $UserNameChangedCopyWith<$Res> {
  _$UserNameChangedCopyWithImpl(
      UserNameChanged _value, $Res Function(UserNameChanged) _then)
      : super(_value, (v) => _then(v as UserNameChanged));

  @override
  UserNameChanged get _value => super._value as UserNameChanged;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(UserNameChanged(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserNameChanged implements UserNameChanged {
  const _$UserNameChanged({required this.name});

  @override
  final String name;

  @override
  String toString() {
    return 'UserNameEvent.userNameChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserNameChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  $UserNameChangedCopyWith<UserNameChanged> get copyWith =>
      _$UserNameChangedCopyWithImpl<UserNameChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) userNameChanged,
    required TResult Function() confirmed,
  }) {
    return userNameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? userNameChanged,
    TResult Function()? confirmed,
  }) {
    return userNameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? userNameChanged,
    TResult Function()? confirmed,
    required TResult orElse(),
  }) {
    if (userNameChanged != null) {
      return userNameChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserNameChanged value) userNameChanged,
    required TResult Function(UserNameConfirmed value) confirmed,
  }) {
    return userNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserNameChanged value)? userNameChanged,
    TResult Function(UserNameConfirmed value)? confirmed,
  }) {
    return userNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserNameChanged value)? userNameChanged,
    TResult Function(UserNameConfirmed value)? confirmed,
    required TResult orElse(),
  }) {
    if (userNameChanged != null) {
      return userNameChanged(this);
    }
    return orElse();
  }
}

abstract class UserNameChanged implements UserNameEvent {
  const factory UserNameChanged({required String name}) = _$UserNameChanged;

  String get name;
  @JsonKey(ignore: true)
  $UserNameChangedCopyWith<UserNameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNameConfirmedCopyWith<$Res> {
  factory $UserNameConfirmedCopyWith(
          UserNameConfirmed value, $Res Function(UserNameConfirmed) then) =
      _$UserNameConfirmedCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserNameConfirmedCopyWithImpl<$Res>
    extends _$UserNameEventCopyWithImpl<$Res>
    implements $UserNameConfirmedCopyWith<$Res> {
  _$UserNameConfirmedCopyWithImpl(
      UserNameConfirmed _value, $Res Function(UserNameConfirmed) _then)
      : super(_value, (v) => _then(v as UserNameConfirmed));

  @override
  UserNameConfirmed get _value => super._value as UserNameConfirmed;
}

/// @nodoc

class _$UserNameConfirmed implements UserNameConfirmed {
  const _$UserNameConfirmed();

  @override
  String toString() {
    return 'UserNameEvent.confirmed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserNameConfirmed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) userNameChanged,
    required TResult Function() confirmed,
  }) {
    return confirmed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name)? userNameChanged,
    TResult Function()? confirmed,
  }) {
    return confirmed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? userNameChanged,
    TResult Function()? confirmed,
    required TResult orElse(),
  }) {
    if (confirmed != null) {
      return confirmed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserNameChanged value) userNameChanged,
    required TResult Function(UserNameConfirmed value) confirmed,
  }) {
    return confirmed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UserNameChanged value)? userNameChanged,
    TResult Function(UserNameConfirmed value)? confirmed,
  }) {
    return confirmed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserNameChanged value)? userNameChanged,
    TResult Function(UserNameConfirmed value)? confirmed,
    required TResult orElse(),
  }) {
    if (confirmed != null) {
      return confirmed(this);
    }
    return orElse();
  }
}

abstract class UserNameConfirmed implements UserNameEvent {
  const factory UserNameConfirmed() = _$UserNameConfirmed;
}

/// @nodoc
class _$UserNameStateTearOff {
  const _$UserNameStateTearOff();

  _UserNameState call(
      {required String name,
      required bool openCreatePlanIncentiveScreen,
      required StateType type,
      required UserNameArgument argument}) {
    return _UserNameState(
      name: name,
      openCreatePlanIncentiveScreen: openCreatePlanIncentiveScreen,
      type: type,
      argument: argument,
    );
  }
}

/// @nodoc
const $UserNameState = _$UserNameStateTearOff();

/// @nodoc
mixin _$UserNameState {
  String get name => throw _privateConstructorUsedError;
  bool get openCreatePlanIncentiveScreen => throw _privateConstructorUsedError;
  StateType get type => throw _privateConstructorUsedError;
  UserNameArgument get argument => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserNameStateCopyWith<UserNameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNameStateCopyWith<$Res> {
  factory $UserNameStateCopyWith(
          UserNameState value, $Res Function(UserNameState) then) =
      _$UserNameStateCopyWithImpl<$Res>;
  $Res call(
      {String name,
      bool openCreatePlanIncentiveScreen,
      StateType type,
      UserNameArgument argument});
}

/// @nodoc
class _$UserNameStateCopyWithImpl<$Res>
    implements $UserNameStateCopyWith<$Res> {
  _$UserNameStateCopyWithImpl(this._value, this._then);

  final UserNameState _value;
  // ignore: unused_field
  final $Res Function(UserNameState) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? openCreatePlanIncentiveScreen = freezed,
    Object? type = freezed,
    Object? argument = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      openCreatePlanIncentiveScreen: openCreatePlanIncentiveScreen == freezed
          ? _value.openCreatePlanIncentiveScreen
          : openCreatePlanIncentiveScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StateType,
      argument: argument == freezed
          ? _value.argument
          : argument // ignore: cast_nullable_to_non_nullable
              as UserNameArgument,
    ));
  }
}

/// @nodoc
abstract class _$UserNameStateCopyWith<$Res>
    implements $UserNameStateCopyWith<$Res> {
  factory _$UserNameStateCopyWith(
          _UserNameState value, $Res Function(_UserNameState) then) =
      __$UserNameStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      bool openCreatePlanIncentiveScreen,
      StateType type,
      UserNameArgument argument});
}

/// @nodoc
class __$UserNameStateCopyWithImpl<$Res>
    extends _$UserNameStateCopyWithImpl<$Res>
    implements _$UserNameStateCopyWith<$Res> {
  __$UserNameStateCopyWithImpl(
      _UserNameState _value, $Res Function(_UserNameState) _then)
      : super(_value, (v) => _then(v as _UserNameState));

  @override
  _UserNameState get _value => super._value as _UserNameState;

  @override
  $Res call({
    Object? name = freezed,
    Object? openCreatePlanIncentiveScreen = freezed,
    Object? type = freezed,
    Object? argument = freezed,
  }) {
    return _then(_UserNameState(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      openCreatePlanIncentiveScreen: openCreatePlanIncentiveScreen == freezed
          ? _value.openCreatePlanIncentiveScreen
          : openCreatePlanIncentiveScreen // ignore: cast_nullable_to_non_nullable
              as bool,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StateType,
      argument: argument == freezed
          ? _value.argument
          : argument // ignore: cast_nullable_to_non_nullable
              as UserNameArgument,
    ));
  }
}

/// @nodoc

class _$_UserNameState implements _UserNameState {
  const _$_UserNameState(
      {required this.name,
      required this.openCreatePlanIncentiveScreen,
      required this.type,
      required this.argument});

  @override
  final String name;
  @override
  final bool openCreatePlanIncentiveScreen;
  @override
  final StateType type;
  @override
  final UserNameArgument argument;

  @override
  String toString() {
    return 'UserNameState(name: $name, openCreatePlanIncentiveScreen: $openCreatePlanIncentiveScreen, type: $type, argument: $argument)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserNameState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.openCreatePlanIncentiveScreen,
                    openCreatePlanIncentiveScreen) ||
                other.openCreatePlanIncentiveScreen ==
                    openCreatePlanIncentiveScreen) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.argument, argument) ||
                other.argument == argument));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, openCreatePlanIncentiveScreen, type, argument);

  @JsonKey(ignore: true)
  @override
  _$UserNameStateCopyWith<_UserNameState> get copyWith =>
      __$UserNameStateCopyWithImpl<_UserNameState>(this, _$identity);
}

abstract class _UserNameState implements UserNameState {
  const factory _UserNameState(
      {required String name,
      required bool openCreatePlanIncentiveScreen,
      required StateType type,
      required UserNameArgument argument}) = _$_UserNameState;

  @override
  String get name;
  @override
  bool get openCreatePlanIncentiveScreen;
  @override
  StateType get type;
  @override
  UserNameArgument get argument;
  @override
  @JsonKey(ignore: true)
  _$UserNameStateCopyWith<_UserNameState> get copyWith =>
      throw _privateConstructorUsedError;
}
