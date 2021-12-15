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

  _UserNameChanged userNameChanged({required String name}) {
    return _UserNameChanged(
      name: name,
    );
  }

  _UserNameConfirmed confirmed() {
    return const _UserNameConfirmed();
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
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_UserNameConfirmed value) confirmed,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_UserNameConfirmed value)? confirmed,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_UserNameConfirmed value)? confirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNameEventCopyWith<$Res> {
  factory $UserNameEventCopyWith(UserNameEvent value, $Res Function(UserNameEvent) then) =
      _$UserNameEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserNameEventCopyWithImpl<$Res> implements $UserNameEventCopyWith<$Res> {
  _$UserNameEventCopyWithImpl(this._value, this._then);

  final UserNameEvent _value;

  // ignore: unused_field
  final $Res Function(UserNameEvent) _then;
}

/// @nodoc
abstract class _$UserNameChangedCopyWith<$Res> {
  factory _$UserNameChangedCopyWith(_UserNameChanged value, $Res Function(_UserNameChanged) then) =
      __$UserNameChangedCopyWithImpl<$Res>;

  $Res call({String name});
}

/// @nodoc
class __$UserNameChangedCopyWithImpl<$Res> extends _$UserNameEventCopyWithImpl<$Res>
    implements _$UserNameChangedCopyWith<$Res> {
  __$UserNameChangedCopyWithImpl(_UserNameChanged _value, $Res Function(_UserNameChanged) _then)
      : super(_value, (v) => _then(v as _UserNameChanged));

  @override
  _UserNameChanged get _value => super._value as _UserNameChanged;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_UserNameChanged(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserNameChanged implements _UserNameChanged {
  const _$_UserNameChanged({required this.name});

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
            other is _UserNameChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  _$UserNameChangedCopyWith<_UserNameChanged> get copyWith =>
      __$UserNameChangedCopyWithImpl<_UserNameChanged>(this, _$identity);

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
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_UserNameConfirmed value) confirmed,
  }) {
    return userNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_UserNameConfirmed value)? confirmed,
  }) {
    return userNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_UserNameConfirmed value)? confirmed,
    required TResult orElse(),
  }) {
    if (userNameChanged != null) {
      return userNameChanged(this);
    }
    return orElse();
  }
}

abstract class _UserNameChanged implements UserNameEvent {
  const factory _UserNameChanged({required String name}) = _$_UserNameChanged;

  String get name;

  @JsonKey(ignore: true)
  _$UserNameChangedCopyWith<_UserNameChanged> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UserNameConfirmedCopyWith<$Res> {
  factory _$UserNameConfirmedCopyWith(
          _UserNameConfirmed value, $Res Function(_UserNameConfirmed) then) =
      __$UserNameConfirmedCopyWithImpl<$Res>;
}

/// @nodoc
class __$UserNameConfirmedCopyWithImpl<$Res> extends _$UserNameEventCopyWithImpl<$Res>
    implements _$UserNameConfirmedCopyWith<$Res> {
  __$UserNameConfirmedCopyWithImpl(
      _UserNameConfirmed _value, $Res Function(_UserNameConfirmed) _then)
      : super(_value, (v) => _then(v as _UserNameConfirmed));

  @override
  _UserNameConfirmed get _value => super._value as _UserNameConfirmed;
}

/// @nodoc

class _$_UserNameConfirmed implements _UserNameConfirmed {
  const _$_UserNameConfirmed();

  @override
  String toString() {
    return 'UserNameEvent.confirmed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _UserNameConfirmed);
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
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_UserNameConfirmed value) confirmed,
  }) {
    return confirmed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_UserNameConfirmed value)? confirmed,
  }) {
    return confirmed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_UserNameConfirmed value)? confirmed,
    required TResult orElse(),
  }) {
    if (confirmed != null) {
      return confirmed(this);
    }
    return orElse();
  }
}

abstract class _UserNameConfirmed implements UserNameEvent {
  const factory _UserNameConfirmed() = _$_UserNameConfirmed;
}

/// @nodoc
class _$UserNameStateTearOff {
  const _$UserNameStateTearOff();

  _UserNameState call(
      {required String name,
      required bool userHasBeenCreated,
      required StateType type,
      required UserNameArgument argument}) {
    return _UserNameState(
      name: name,
      userHasBeenCreated: userHasBeenCreated,
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

  bool get userHasBeenCreated => throw _privateConstructorUsedError;

  StateType get type => throw _privateConstructorUsedError;

  UserNameArgument get argument => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserNameStateCopyWith<UserNameState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNameStateCopyWith<$Res> {
  factory $UserNameStateCopyWith(UserNameState value, $Res Function(UserNameState) then) =
      _$UserNameStateCopyWithImpl<$Res>;

  $Res call({String name, bool userHasBeenCreated, StateType type, UserNameArgument argument});
}

/// @nodoc
class _$UserNameStateCopyWithImpl<$Res> implements $UserNameStateCopyWith<$Res> {
  _$UserNameStateCopyWithImpl(this._value, this._then);

  final UserNameState _value;

  // ignore: unused_field
  final $Res Function(UserNameState) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? userHasBeenCreated = freezed,
    Object? type = freezed,
    Object? argument = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      userHasBeenCreated: userHasBeenCreated == freezed
          ? _value.userHasBeenCreated
          : userHasBeenCreated // ignore: cast_nullable_to_non_nullable
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
abstract class _$UserNameStateCopyWith<$Res> implements $UserNameStateCopyWith<$Res> {
  factory _$UserNameStateCopyWith(_UserNameState value, $Res Function(_UserNameState) then) =
      __$UserNameStateCopyWithImpl<$Res>;

  @override
  $Res call({String name, bool userHasBeenCreated, StateType type, UserNameArgument argument});
}

/// @nodoc
class __$UserNameStateCopyWithImpl<$Res> extends _$UserNameStateCopyWithImpl<$Res>
    implements _$UserNameStateCopyWith<$Res> {
  __$UserNameStateCopyWithImpl(_UserNameState _value, $Res Function(_UserNameState) _then)
      : super(_value, (v) => _then(v as _UserNameState));

  @override
  _UserNameState get _value => super._value as _UserNameState;

  @override
  $Res call({
    Object? name = freezed,
    Object? userHasBeenCreated = freezed,
    Object? type = freezed,
    Object? argument = freezed,
  }) {
    return _then(_UserNameState(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      userHasBeenCreated: userHasBeenCreated == freezed
          ? _value.userHasBeenCreated
          : userHasBeenCreated // ignore: cast_nullable_to_non_nullable
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
      required this.userHasBeenCreated,
      required this.type,
      required this.argument});

  @override
  final String name;
  @override
  final bool userHasBeenCreated;
  @override
  final StateType type;
  @override
  final UserNameArgument argument;

  @override
  String toString() {
    return 'UserNameState(name: $name, userHasBeenCreated: $userHasBeenCreated, type: $type, argument: $argument)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserNameState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userHasBeenCreated, userHasBeenCreated) ||
                other.userHasBeenCreated == userHasBeenCreated) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.argument, argument) || other.argument == argument));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, userHasBeenCreated, type, argument);

  @JsonKey(ignore: true)
  @override
  _$UserNameStateCopyWith<_UserNameState> get copyWith =>
      __$UserNameStateCopyWithImpl<_UserNameState>(this, _$identity);
}

abstract class _UserNameState implements UserNameState {
  const factory _UserNameState(
      {required String name,
      required bool userHasBeenCreated,
      required StateType type,
      required UserNameArgument argument}) = _$_UserNameState;

  @override
  String get name;

  @override
  bool get userHasBeenCreated;

  @override
  StateType get type;

  @override
  UserNameArgument get argument;

  @override
  @JsonKey(ignore: true)
  _$UserNameStateCopyWith<_UserNameState> get copyWith => throw _privateConstructorUsedError;
}