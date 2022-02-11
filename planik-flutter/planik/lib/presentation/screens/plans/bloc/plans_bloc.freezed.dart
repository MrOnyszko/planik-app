// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'plans_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PlansEventTearOff {
  const _$PlansEventTearOff();

  _PlansStarted started() {
    return const _PlansStarted();
  }
}

/// @nodoc
const $PlansEvent = _$PlansEventTearOff();

/// @nodoc
mixin _$PlansEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlansStarted value) started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PlansStarted value)? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlansStarted value)? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlansEventCopyWith<$Res> {
  factory $PlansEventCopyWith(
          PlansEvent value, $Res Function(PlansEvent) then) =
      _$PlansEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$PlansEventCopyWithImpl<$Res> implements $PlansEventCopyWith<$Res> {
  _$PlansEventCopyWithImpl(this._value, this._then);

  final PlansEvent _value;
  // ignore: unused_field
  final $Res Function(PlansEvent) _then;
}

/// @nodoc
abstract class _$PlansStartedCopyWith<$Res> {
  factory _$PlansStartedCopyWith(
          _PlansStarted value, $Res Function(_PlansStarted) then) =
      __$PlansStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$PlansStartedCopyWithImpl<$Res> extends _$PlansEventCopyWithImpl<$Res>
    implements _$PlansStartedCopyWith<$Res> {
  __$PlansStartedCopyWithImpl(
      _PlansStarted _value, $Res Function(_PlansStarted) _then)
      : super(_value, (v) => _then(v as _PlansStarted));

  @override
  _PlansStarted get _value => super._value as _PlansStarted;
}

/// @nodoc

class _$_PlansStarted implements _PlansStarted {
  const _$_PlansStarted();

  @override
  String toString() {
    return 'PlansEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _PlansStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlansStarted value) started,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PlansStarted value)? started,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlansStarted value)? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _PlansStarted implements PlansEvent {
  const factory _PlansStarted() = _$_PlansStarted;
}

/// @nodoc
class _$PlansStateTearOff {
  const _$PlansStateTearOff();

  _PlansState call({required StateType type, required PlansArgument argument}) {
    return _PlansState(
      type: type,
      argument: argument,
    );
  }
}

/// @nodoc
const $PlansState = _$PlansStateTearOff();

/// @nodoc
mixin _$PlansState {
  StateType get type => throw _privateConstructorUsedError;
  PlansArgument get argument => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlansStateCopyWith<PlansState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlansStateCopyWith<$Res> {
  factory $PlansStateCopyWith(
          PlansState value, $Res Function(PlansState) then) =
      _$PlansStateCopyWithImpl<$Res>;
  $Res call({StateType type, PlansArgument argument});
}

/// @nodoc
class _$PlansStateCopyWithImpl<$Res> implements $PlansStateCopyWith<$Res> {
  _$PlansStateCopyWithImpl(this._value, this._then);

  final PlansState _value;
  // ignore: unused_field
  final $Res Function(PlansState) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? argument = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StateType,
      argument: argument == freezed
          ? _value.argument
          : argument // ignore: cast_nullable_to_non_nullable
              as PlansArgument,
    ));
  }
}

/// @nodoc
abstract class _$PlansStateCopyWith<$Res> implements $PlansStateCopyWith<$Res> {
  factory _$PlansStateCopyWith(
          _PlansState value, $Res Function(_PlansState) then) =
      __$PlansStateCopyWithImpl<$Res>;
  @override
  $Res call({StateType type, PlansArgument argument});
}

/// @nodoc
class __$PlansStateCopyWithImpl<$Res> extends _$PlansStateCopyWithImpl<$Res>
    implements _$PlansStateCopyWith<$Res> {
  __$PlansStateCopyWithImpl(
      _PlansState _value, $Res Function(_PlansState) _then)
      : super(_value, (v) => _then(v as _PlansState));

  @override
  _PlansState get _value => super._value as _PlansState;

  @override
  $Res call({
    Object? type = freezed,
    Object? argument = freezed,
  }) {
    return _then(_PlansState(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StateType,
      argument: argument == freezed
          ? _value.argument
          : argument // ignore: cast_nullable_to_non_nullable
              as PlansArgument,
    ));
  }
}

/// @nodoc

class _$_PlansState implements _PlansState {
  const _$_PlansState({required this.type, required this.argument});

  @override
  final StateType type;
  @override
  final PlansArgument argument;

  @override
  String toString() {
    return 'PlansState(type: $type, argument: $argument)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlansState &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.argument, argument) ||
                other.argument == argument));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, argument);

  @JsonKey(ignore: true)
  @override
  _$PlansStateCopyWith<_PlansState> get copyWith =>
      __$PlansStateCopyWithImpl<_PlansState>(this, _$identity);
}

abstract class _PlansState implements PlansState {
  const factory _PlansState(
      {required StateType type,
      required PlansArgument argument}) = _$_PlansState;

  @override
  StateType get type;
  @override
  PlansArgument get argument;
  @override
  @JsonKey(ignore: true)
  _$PlansStateCopyWith<_PlansState> get copyWith =>
      throw _privateConstructorUsedError;
}
