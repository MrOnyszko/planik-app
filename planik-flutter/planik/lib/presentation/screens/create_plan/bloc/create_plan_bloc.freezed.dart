// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'create_plan_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CreatePlanEventTearOff {
  const _$CreatePlanEventTearOff();

  _CreatePlanStarted started() {
    return const _CreatePlanStarted();
  }
}

/// @nodoc
const $CreatePlanEvent = _$CreatePlanEventTearOff();

/// @nodoc
mixin _$CreatePlanEvent {
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
    required TResult Function(_CreatePlanStarted value) started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CreatePlanStarted value)? started,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePlanStarted value)? started,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePlanEventCopyWith<$Res> {
  factory $CreatePlanEventCopyWith(
          CreatePlanEvent value, $Res Function(CreatePlanEvent) then) =
      _$CreatePlanEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$CreatePlanEventCopyWithImpl<$Res>
    implements $CreatePlanEventCopyWith<$Res> {
  _$CreatePlanEventCopyWithImpl(this._value, this._then);

  final CreatePlanEvent _value;
  // ignore: unused_field
  final $Res Function(CreatePlanEvent) _then;
}

/// @nodoc
abstract class _$CreatePlanStartedCopyWith<$Res> {
  factory _$CreatePlanStartedCopyWith(
          _CreatePlanStarted value, $Res Function(_CreatePlanStarted) then) =
      __$CreatePlanStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$CreatePlanStartedCopyWithImpl<$Res>
    extends _$CreatePlanEventCopyWithImpl<$Res>
    implements _$CreatePlanStartedCopyWith<$Res> {
  __$CreatePlanStartedCopyWithImpl(
      _CreatePlanStarted _value, $Res Function(_CreatePlanStarted) _then)
      : super(_value, (v) => _then(v as _CreatePlanStarted));

  @override
  _CreatePlanStarted get _value => super._value as _CreatePlanStarted;
}

/// @nodoc

class _$_CreatePlanStarted implements _CreatePlanStarted {
  const _$_CreatePlanStarted();

  @override
  String toString() {
    return 'CreatePlanEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CreatePlanStarted);
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
    required TResult Function(_CreatePlanStarted value) started,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CreatePlanStarted value)? started,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CreatePlanStarted value)? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _CreatePlanStarted implements CreatePlanEvent {
  const factory _CreatePlanStarted() = _$_CreatePlanStarted;
}

/// @nodoc
class _$CreatePlanStateTearOff {
  const _$CreatePlanStateTearOff();

  _CreatePlanState call(
      {required StateType type,
      required CreatePlanArgument argument,
      List<Day> days = const <Day>[]}) {
    return _CreatePlanState(
      type: type,
      argument: argument,
      days: days,
    );
  }
}

/// @nodoc
const $CreatePlanState = _$CreatePlanStateTearOff();

/// @nodoc
mixin _$CreatePlanState {
  StateType get type => throw _privateConstructorUsedError;
  CreatePlanArgument get argument => throw _privateConstructorUsedError;
  List<Day> get days => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreatePlanStateCopyWith<CreatePlanState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePlanStateCopyWith<$Res> {
  factory $CreatePlanStateCopyWith(
          CreatePlanState value, $Res Function(CreatePlanState) then) =
      _$CreatePlanStateCopyWithImpl<$Res>;
  $Res call({StateType type, CreatePlanArgument argument, List<Day> days});
}

/// @nodoc
class _$CreatePlanStateCopyWithImpl<$Res>
    implements $CreatePlanStateCopyWith<$Res> {
  _$CreatePlanStateCopyWithImpl(this._value, this._then);

  final CreatePlanState _value;
  // ignore: unused_field
  final $Res Function(CreatePlanState) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? argument = freezed,
    Object? days = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StateType,
      argument: argument == freezed
          ? _value.argument
          : argument // ignore: cast_nullable_to_non_nullable
              as CreatePlanArgument,
      days: days == freezed
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
    ));
  }
}

/// @nodoc
abstract class _$CreatePlanStateCopyWith<$Res>
    implements $CreatePlanStateCopyWith<$Res> {
  factory _$CreatePlanStateCopyWith(
          _CreatePlanState value, $Res Function(_CreatePlanState) then) =
      __$CreatePlanStateCopyWithImpl<$Res>;
  @override
  $Res call({StateType type, CreatePlanArgument argument, List<Day> days});
}

/// @nodoc
class __$CreatePlanStateCopyWithImpl<$Res>
    extends _$CreatePlanStateCopyWithImpl<$Res>
    implements _$CreatePlanStateCopyWith<$Res> {
  __$CreatePlanStateCopyWithImpl(
      _CreatePlanState _value, $Res Function(_CreatePlanState) _then)
      : super(_value, (v) => _then(v as _CreatePlanState));

  @override
  _CreatePlanState get _value => super._value as _CreatePlanState;

  @override
  $Res call({
    Object? type = freezed,
    Object? argument = freezed,
    Object? days = freezed,
  }) {
    return _then(_CreatePlanState(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StateType,
      argument: argument == freezed
          ? _value.argument
          : argument // ignore: cast_nullable_to_non_nullable
              as CreatePlanArgument,
      days: days == freezed
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
    ));
  }
}

/// @nodoc

class _$_CreatePlanState implements _CreatePlanState {
  const _$_CreatePlanState(
      {required this.type, required this.argument, this.days = const <Day>[]});

  @override
  final StateType type;
  @override
  final CreatePlanArgument argument;
  @JsonKey(defaultValue: const <Day>[])
  @override
  final List<Day> days;

  @override
  String toString() {
    return 'CreatePlanState(type: $type, argument: $argument, days: $days)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatePlanState &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.argument, argument) ||
                other.argument == argument) &&
            const DeepCollectionEquality().equals(other.days, days));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, argument, const DeepCollectionEquality().hash(days));

  @JsonKey(ignore: true)
  @override
  _$CreatePlanStateCopyWith<_CreatePlanState> get copyWith =>
      __$CreatePlanStateCopyWithImpl<_CreatePlanState>(this, _$identity);
}

abstract class _CreatePlanState implements CreatePlanState {
  const factory _CreatePlanState(
      {required StateType type,
      required CreatePlanArgument argument,
      List<Day> days}) = _$_CreatePlanState;

  @override
  StateType get type;
  @override
  CreatePlanArgument get argument;
  @override
  List<Day> get days;
  @override
  @JsonKey(ignore: true)
  _$CreatePlanStateCopyWith<_CreatePlanState> get copyWith =>
      throw _privateConstructorUsedError;
}
