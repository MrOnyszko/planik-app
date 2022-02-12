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

  CreatePlanStarted started() {
    return const CreatePlanStarted();
  }

  CreatePlanNameChanged planNameChanged({required String name}) {
    return CreatePlanNameChanged(
      name: name,
    );
  }
}

/// @nodoc
const $CreatePlanEvent = _$CreatePlanEventTearOff();

/// @nodoc
mixin _$CreatePlanEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) planNameChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? planNameChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? planNameChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreatePlanStarted value) started,
    required TResult Function(CreatePlanNameChanged value) planNameChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreatePlanStarted value)? started,
    TResult Function(CreatePlanNameChanged value)? planNameChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreatePlanStarted value)? started,
    TResult Function(CreatePlanNameChanged value)? planNameChanged,
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
abstract class $CreatePlanStartedCopyWith<$Res> {
  factory $CreatePlanStartedCopyWith(
          CreatePlanStarted value, $Res Function(CreatePlanStarted) then) =
      _$CreatePlanStartedCopyWithImpl<$Res>;
}

/// @nodoc
class _$CreatePlanStartedCopyWithImpl<$Res>
    extends _$CreatePlanEventCopyWithImpl<$Res>
    implements $CreatePlanStartedCopyWith<$Res> {
  _$CreatePlanStartedCopyWithImpl(
      CreatePlanStarted _value, $Res Function(CreatePlanStarted) _then)
      : super(_value, (v) => _then(v as CreatePlanStarted));

  @override
  CreatePlanStarted get _value => super._value as CreatePlanStarted;
}

/// @nodoc

class _$CreatePlanStarted implements CreatePlanStarted {
  const _$CreatePlanStarted();

  @override
  String toString() {
    return 'CreatePlanEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CreatePlanStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) planNameChanged,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? planNameChanged,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? planNameChanged,
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
    required TResult Function(CreatePlanStarted value) started,
    required TResult Function(CreatePlanNameChanged value) planNameChanged,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreatePlanStarted value)? started,
    TResult Function(CreatePlanNameChanged value)? planNameChanged,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreatePlanStarted value)? started,
    TResult Function(CreatePlanNameChanged value)? planNameChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class CreatePlanStarted implements CreatePlanEvent {
  const factory CreatePlanStarted() = _$CreatePlanStarted;
}

/// @nodoc
abstract class $CreatePlanNameChangedCopyWith<$Res> {
  factory $CreatePlanNameChangedCopyWith(CreatePlanNameChanged value,
          $Res Function(CreatePlanNameChanged) then) =
      _$CreatePlanNameChangedCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$CreatePlanNameChangedCopyWithImpl<$Res>
    extends _$CreatePlanEventCopyWithImpl<$Res>
    implements $CreatePlanNameChangedCopyWith<$Res> {
  _$CreatePlanNameChangedCopyWithImpl(
      CreatePlanNameChanged _value, $Res Function(CreatePlanNameChanged) _then)
      : super(_value, (v) => _then(v as CreatePlanNameChanged));

  @override
  CreatePlanNameChanged get _value => super._value as CreatePlanNameChanged;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(CreatePlanNameChanged(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CreatePlanNameChanged implements CreatePlanNameChanged {
  const _$CreatePlanNameChanged({required this.name});

  @override
  final String name;

  @override
  String toString() {
    return 'CreatePlanEvent.planNameChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreatePlanNameChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  $CreatePlanNameChangedCopyWith<CreatePlanNameChanged> get copyWith =>
      _$CreatePlanNameChangedCopyWithImpl<CreatePlanNameChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) planNameChanged,
  }) {
    return planNameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? planNameChanged,
  }) {
    return planNameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? planNameChanged,
    required TResult orElse(),
  }) {
    if (planNameChanged != null) {
      return planNameChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CreatePlanStarted value) started,
    required TResult Function(CreatePlanNameChanged value) planNameChanged,
  }) {
    return planNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CreatePlanStarted value)? started,
    TResult Function(CreatePlanNameChanged value)? planNameChanged,
  }) {
    return planNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CreatePlanStarted value)? started,
    TResult Function(CreatePlanNameChanged value)? planNameChanged,
    required TResult orElse(),
  }) {
    if (planNameChanged != null) {
      return planNameChanged(this);
    }
    return orElse();
  }
}

abstract class CreatePlanNameChanged implements CreatePlanEvent {
  const factory CreatePlanNameChanged({required String name}) =
      _$CreatePlanNameChanged;

  String get name;
  @JsonKey(ignore: true)
  $CreatePlanNameChangedCopyWith<CreatePlanNameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$CreatePlanStateTearOff {
  const _$CreatePlanStateTearOff();

  _CreatePlanState call(
      {required StateType type,
      required CreatePlanArgument argument,
      List<Day> days = const <Day>[],
      Plan? plan = null}) {
    return _CreatePlanState(
      type: type,
      argument: argument,
      days: days,
      plan: plan,
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
  Plan? get plan => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreatePlanStateCopyWith<CreatePlanState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePlanStateCopyWith<$Res> {
  factory $CreatePlanStateCopyWith(
          CreatePlanState value, $Res Function(CreatePlanState) then) =
      _$CreatePlanStateCopyWithImpl<$Res>;
  $Res call(
      {StateType type,
      CreatePlanArgument argument,
      List<Day> days,
      Plan? plan});

  $PlanCopyWith<$Res>? get plan;
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
    Object? plan = freezed,
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
      plan: plan == freezed
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as Plan?,
    ));
  }

  @override
  $PlanCopyWith<$Res>? get plan {
    if (_value.plan == null) {
      return null;
    }

    return $PlanCopyWith<$Res>(_value.plan!, (value) {
      return _then(_value.copyWith(plan: value));
    });
  }
}

/// @nodoc
abstract class _$CreatePlanStateCopyWith<$Res>
    implements $CreatePlanStateCopyWith<$Res> {
  factory _$CreatePlanStateCopyWith(
          _CreatePlanState value, $Res Function(_CreatePlanState) then) =
      __$CreatePlanStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {StateType type,
      CreatePlanArgument argument,
      List<Day> days,
      Plan? plan});

  @override
  $PlanCopyWith<$Res>? get plan;
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
    Object? plan = freezed,
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
      plan: plan == freezed
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as Plan?,
    ));
  }
}

/// @nodoc

class _$_CreatePlanState implements _CreatePlanState {
  const _$_CreatePlanState(
      {required this.type,
      required this.argument,
      this.days = const <Day>[],
      this.plan = null});

  @override
  final StateType type;
  @override
  final CreatePlanArgument argument;
  @JsonKey(defaultValue: const <Day>[])
  @override
  final List<Day> days;
  @JsonKey(defaultValue: null)
  @override
  final Plan? plan;

  @override
  String toString() {
    return 'CreatePlanState(type: $type, argument: $argument, days: $days, plan: $plan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreatePlanState &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.argument, argument) ||
                other.argument == argument) &&
            const DeepCollectionEquality().equals(other.days, days) &&
            (identical(other.plan, plan) || other.plan == plan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, argument,
      const DeepCollectionEquality().hash(days), plan);

  @JsonKey(ignore: true)
  @override
  _$CreatePlanStateCopyWith<_CreatePlanState> get copyWith =>
      __$CreatePlanStateCopyWithImpl<_CreatePlanState>(this, _$identity);
}

abstract class _CreatePlanState implements CreatePlanState {
  const factory _CreatePlanState(
      {required StateType type,
      required CreatePlanArgument argument,
      List<Day> days,
      Plan? plan}) = _$_CreatePlanState;

  @override
  StateType get type;
  @override
  CreatePlanArgument get argument;
  @override
  List<Day> get days;
  @override
  Plan? get plan;
  @override
  @JsonKey(ignore: true)
  _$CreatePlanStateCopyWith<_CreatePlanState> get copyWith =>
      throw _privateConstructorUsedError;
}
