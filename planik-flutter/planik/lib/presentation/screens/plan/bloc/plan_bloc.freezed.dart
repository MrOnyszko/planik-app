// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'plan_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PlanEventTearOff {
  const _$PlanEventTearOff();

  _PlanStarted started() {
    return const _PlanStarted();
  }

  _PlanTodayRequested todayRequested() {
    return const _PlanTodayRequested();
  }

  _PlanToggleViewTypeRequested toggleViewTypeRequested() {
    return const _PlanToggleViewTypeRequested();
  }
}

/// @nodoc
const $PlanEvent = _$PlanEventTearOff();

/// @nodoc
mixin _$PlanEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() todayRequested,
    required TResult Function() toggleViewTypeRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlanStarted value) started,
    required TResult Function(_PlanTodayRequested value) todayRequested,
    required TResult Function(_PlanToggleViewTypeRequested value)
        toggleViewTypeRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanEventCopyWith<$Res> {
  factory $PlanEventCopyWith(PlanEvent value, $Res Function(PlanEvent) then) =
      _$PlanEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$PlanEventCopyWithImpl<$Res> implements $PlanEventCopyWith<$Res> {
  _$PlanEventCopyWithImpl(this._value, this._then);

  final PlanEvent _value;
  // ignore: unused_field
  final $Res Function(PlanEvent) _then;
}

/// @nodoc
abstract class _$PlanStartedCopyWith<$Res> {
  factory _$PlanStartedCopyWith(
          _PlanStarted value, $Res Function(_PlanStarted) then) =
      __$PlanStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$PlanStartedCopyWithImpl<$Res> extends _$PlanEventCopyWithImpl<$Res>
    implements _$PlanStartedCopyWith<$Res> {
  __$PlanStartedCopyWithImpl(
      _PlanStarted _value, $Res Function(_PlanStarted) _then)
      : super(_value, (v) => _then(v as _PlanStarted));

  @override
  _PlanStarted get _value => super._value as _PlanStarted;
}

/// @nodoc

class _$_PlanStarted implements _PlanStarted {
  const _$_PlanStarted();

  @override
  String toString() {
    return 'PlanEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _PlanStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() todayRequested,
    required TResult Function() toggleViewTypeRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
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
    required TResult Function(_PlanStarted value) started,
    required TResult Function(_PlanTodayRequested value) todayRequested,
    required TResult Function(_PlanToggleViewTypeRequested value)
        toggleViewTypeRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _PlanStarted implements PlanEvent {
  const factory _PlanStarted() = _$_PlanStarted;
}

/// @nodoc
abstract class _$PlanTodayRequestedCopyWith<$Res> {
  factory _$PlanTodayRequestedCopyWith(
          _PlanTodayRequested value, $Res Function(_PlanTodayRequested) then) =
      __$PlanTodayRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class __$PlanTodayRequestedCopyWithImpl<$Res>
    extends _$PlanEventCopyWithImpl<$Res>
    implements _$PlanTodayRequestedCopyWith<$Res> {
  __$PlanTodayRequestedCopyWithImpl(
      _PlanTodayRequested _value, $Res Function(_PlanTodayRequested) _then)
      : super(_value, (v) => _then(v as _PlanTodayRequested));

  @override
  _PlanTodayRequested get _value => super._value as _PlanTodayRequested;
}

/// @nodoc

class _$_PlanTodayRequested implements _PlanTodayRequested {
  const _$_PlanTodayRequested();

  @override
  String toString() {
    return 'PlanEvent.todayRequested()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _PlanTodayRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() todayRequested,
    required TResult Function() toggleViewTypeRequested,
  }) {
    return todayRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
  }) {
    return todayRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
    required TResult orElse(),
  }) {
    if (todayRequested != null) {
      return todayRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlanStarted value) started,
    required TResult Function(_PlanTodayRequested value) todayRequested,
    required TResult Function(_PlanToggleViewTypeRequested value)
        toggleViewTypeRequested,
  }) {
    return todayRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
  }) {
    return todayRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
    required TResult orElse(),
  }) {
    if (todayRequested != null) {
      return todayRequested(this);
    }
    return orElse();
  }
}

abstract class _PlanTodayRequested implements PlanEvent {
  const factory _PlanTodayRequested() = _$_PlanTodayRequested;
}

/// @nodoc
abstract class _$PlanToggleViewTypeRequestedCopyWith<$Res> {
  factory _$PlanToggleViewTypeRequestedCopyWith(
          _PlanToggleViewTypeRequested value,
          $Res Function(_PlanToggleViewTypeRequested) then) =
      __$PlanToggleViewTypeRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class __$PlanToggleViewTypeRequestedCopyWithImpl<$Res>
    extends _$PlanEventCopyWithImpl<$Res>
    implements _$PlanToggleViewTypeRequestedCopyWith<$Res> {
  __$PlanToggleViewTypeRequestedCopyWithImpl(
      _PlanToggleViewTypeRequested _value,
      $Res Function(_PlanToggleViewTypeRequested) _then)
      : super(_value, (v) => _then(v as _PlanToggleViewTypeRequested));

  @override
  _PlanToggleViewTypeRequested get _value =>
      super._value as _PlanToggleViewTypeRequested;
}

/// @nodoc

class _$_PlanToggleViewTypeRequested implements _PlanToggleViewTypeRequested {
  const _$_PlanToggleViewTypeRequested();

  @override
  String toString() {
    return 'PlanEvent.toggleViewTypeRequested()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlanToggleViewTypeRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() todayRequested,
    required TResult Function() toggleViewTypeRequested,
  }) {
    return toggleViewTypeRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
  }) {
    return toggleViewTypeRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? todayRequested,
    TResult Function()? toggleViewTypeRequested,
    required TResult orElse(),
  }) {
    if (toggleViewTypeRequested != null) {
      return toggleViewTypeRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PlanStarted value) started,
    required TResult Function(_PlanTodayRequested value) todayRequested,
    required TResult Function(_PlanToggleViewTypeRequested value)
        toggleViewTypeRequested,
  }) {
    return toggleViewTypeRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
  }) {
    return toggleViewTypeRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PlanStarted value)? started,
    TResult Function(_PlanTodayRequested value)? todayRequested,
    TResult Function(_PlanToggleViewTypeRequested value)?
        toggleViewTypeRequested,
    required TResult orElse(),
  }) {
    if (toggleViewTypeRequested != null) {
      return toggleViewTypeRequested(this);
    }
    return orElse();
  }
}

abstract class _PlanToggleViewTypeRequested implements PlanEvent {
  const factory _PlanToggleViewTypeRequested() = _$_PlanToggleViewTypeRequested;
}

/// @nodoc
class _$PlanStateTearOff {
  const _$PlanStateTearOff();

  _PlanState call(
      {required StateType type,
      required PlanArgument argument,
      required int? indexOfToday,
      bool isVertical = true,
      List<Day> days = const <Day>[]}) {
    return _PlanState(
      type: type,
      argument: argument,
      indexOfToday: indexOfToday,
      isVertical: isVertical,
      days: days,
    );
  }
}

/// @nodoc
const $PlanState = _$PlanStateTearOff();

/// @nodoc
mixin _$PlanState {
  StateType get type => throw _privateConstructorUsedError;
  PlanArgument get argument => throw _privateConstructorUsedError;
  int? get indexOfToday => throw _privateConstructorUsedError;
  bool get isVertical => throw _privateConstructorUsedError;
  List<Day> get days => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlanStateCopyWith<PlanState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanStateCopyWith<$Res> {
  factory $PlanStateCopyWith(PlanState value, $Res Function(PlanState) then) =
      _$PlanStateCopyWithImpl<$Res>;
  $Res call(
      {StateType type,
      PlanArgument argument,
      int? indexOfToday,
      bool isVertical,
      List<Day> days});
}

/// @nodoc
class _$PlanStateCopyWithImpl<$Res> implements $PlanStateCopyWith<$Res> {
  _$PlanStateCopyWithImpl(this._value, this._then);

  final PlanState _value;
  // ignore: unused_field
  final $Res Function(PlanState) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? argument = freezed,
    Object? indexOfToday = freezed,
    Object? isVertical = freezed,
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
              as PlanArgument,
      indexOfToday: indexOfToday == freezed
          ? _value.indexOfToday
          : indexOfToday // ignore: cast_nullable_to_non_nullable
              as int?,
      isVertical: isVertical == freezed
          ? _value.isVertical
          : isVertical // ignore: cast_nullable_to_non_nullable
              as bool,
      days: days == freezed
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
    ));
  }
}

/// @nodoc
abstract class _$PlanStateCopyWith<$Res> implements $PlanStateCopyWith<$Res> {
  factory _$PlanStateCopyWith(
          _PlanState value, $Res Function(_PlanState) then) =
      __$PlanStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {StateType type,
      PlanArgument argument,
      int? indexOfToday,
      bool isVertical,
      List<Day> days});
}

/// @nodoc
class __$PlanStateCopyWithImpl<$Res> extends _$PlanStateCopyWithImpl<$Res>
    implements _$PlanStateCopyWith<$Res> {
  __$PlanStateCopyWithImpl(_PlanState _value, $Res Function(_PlanState) _then)
      : super(_value, (v) => _then(v as _PlanState));

  @override
  _PlanState get _value => super._value as _PlanState;

  @override
  $Res call({
    Object? type = freezed,
    Object? argument = freezed,
    Object? indexOfToday = freezed,
    Object? isVertical = freezed,
    Object? days = freezed,
  }) {
    return _then(_PlanState(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as StateType,
      argument: argument == freezed
          ? _value.argument
          : argument // ignore: cast_nullable_to_non_nullable
              as PlanArgument,
      indexOfToday: indexOfToday == freezed
          ? _value.indexOfToday
          : indexOfToday // ignore: cast_nullable_to_non_nullable
              as int?,
      isVertical: isVertical == freezed
          ? _value.isVertical
          : isVertical // ignore: cast_nullable_to_non_nullable
              as bool,
      days: days == freezed
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
    ));
  }
}

/// @nodoc

class _$_PlanState implements _PlanState {
  const _$_PlanState(
      {required this.type,
      required this.argument,
      required this.indexOfToday,
      this.isVertical = true,
      this.days = const <Day>[]});

  @override
  final StateType type;
  @override
  final PlanArgument argument;
  @override
  final int? indexOfToday;
  @JsonKey(defaultValue: true)
  @override
  final bool isVertical;
  @JsonKey(defaultValue: const <Day>[])
  @override
  final List<Day> days;

  @override
  String toString() {
    return 'PlanState(type: $type, argument: $argument, indexOfToday: $indexOfToday, isVertical: $isVertical, days: $days)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlanState &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.argument, argument) ||
                other.argument == argument) &&
            (identical(other.indexOfToday, indexOfToday) ||
                other.indexOfToday == indexOfToday) &&
            (identical(other.isVertical, isVertical) ||
                other.isVertical == isVertical) &&
            const DeepCollectionEquality().equals(other.days, days));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, argument, indexOfToday,
      isVertical, const DeepCollectionEquality().hash(days));

  @JsonKey(ignore: true)
  @override
  _$PlanStateCopyWith<_PlanState> get copyWith =>
      __$PlanStateCopyWithImpl<_PlanState>(this, _$identity);
}

abstract class _PlanState implements PlanState {
  const factory _PlanState(
      {required StateType type,
      required PlanArgument argument,
      required int? indexOfToday,
      bool isVertical,
      List<Day> days}) = _$_PlanState;

  @override
  StateType get type;
  @override
  PlanArgument get argument;
  @override
  int? get indexOfToday;
  @override
  bool get isVertical;
  @override
  List<Day> get days;
  @override
  @JsonKey(ignore: true)
  _$PlanStateCopyWith<_PlanState> get copyWith =>
      throw _privateConstructorUsedError;
}
