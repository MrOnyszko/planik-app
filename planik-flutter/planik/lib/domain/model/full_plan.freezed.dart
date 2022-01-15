// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'full_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FullPlanTearOff {
  const _$FullPlanTearOff();

  _FullPlan call({required Plan plan, required List<Day> days}) {
    return _FullPlan(
      plan: plan,
      days: days,
    );
  }
}

/// @nodoc
const $FullPlan = _$FullPlanTearOff();

/// @nodoc
mixin _$FullPlan {
  Plan get plan => throw _privateConstructorUsedError;
  List<Day> get days => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FullPlanCopyWith<FullPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullPlanCopyWith<$Res> {
  factory $FullPlanCopyWith(FullPlan value, $Res Function(FullPlan) then) =
      _$FullPlanCopyWithImpl<$Res>;
  $Res call({Plan plan, List<Day> days});

  $PlanCopyWith<$Res> get plan;
}

/// @nodoc
class _$FullPlanCopyWithImpl<$Res> implements $FullPlanCopyWith<$Res> {
  _$FullPlanCopyWithImpl(this._value, this._then);

  final FullPlan _value;
  // ignore: unused_field
  final $Res Function(FullPlan) _then;

  @override
  $Res call({
    Object? plan = freezed,
    Object? days = freezed,
  }) {
    return _then(_value.copyWith(
      plan: plan == freezed
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as Plan,
      days: days == freezed
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
    ));
  }

  @override
  $PlanCopyWith<$Res> get plan {
    return $PlanCopyWith<$Res>(_value.plan, (value) {
      return _then(_value.copyWith(plan: value));
    });
  }
}

/// @nodoc
abstract class _$FullPlanCopyWith<$Res> implements $FullPlanCopyWith<$Res> {
  factory _$FullPlanCopyWith(_FullPlan value, $Res Function(_FullPlan) then) =
      __$FullPlanCopyWithImpl<$Res>;
  @override
  $Res call({Plan plan, List<Day> days});

  @override
  $PlanCopyWith<$Res> get plan;
}

/// @nodoc
class __$FullPlanCopyWithImpl<$Res> extends _$FullPlanCopyWithImpl<$Res>
    implements _$FullPlanCopyWith<$Res> {
  __$FullPlanCopyWithImpl(_FullPlan _value, $Res Function(_FullPlan) _then)
      : super(_value, (v) => _then(v as _FullPlan));

  @override
  _FullPlan get _value => super._value as _FullPlan;

  @override
  $Res call({
    Object? plan = freezed,
    Object? days = freezed,
  }) {
    return _then(_FullPlan(
      plan: plan == freezed
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as Plan,
      days: days == freezed
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Day>,
    ));
  }
}

/// @nodoc

class _$_FullPlan implements _FullPlan {
  const _$_FullPlan({required this.plan, required this.days});

  @override
  final Plan plan;
  @override
  final List<Day> days;

  @override
  String toString() {
    return 'FullPlan(plan: $plan, days: $days)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FullPlan &&
            (identical(other.plan, plan) || other.plan == plan) &&
            const DeepCollectionEquality().equals(other.days, days));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, plan, const DeepCollectionEquality().hash(days));

  @JsonKey(ignore: true)
  @override
  _$FullPlanCopyWith<_FullPlan> get copyWith =>
      __$FullPlanCopyWithImpl<_FullPlan>(this, _$identity);
}

abstract class _FullPlan implements FullPlan {
  const factory _FullPlan({required Plan plan, required List<Day> days}) =
      _$_FullPlan;

  @override
  Plan get plan;
  @override
  List<Day> get days;
  @override
  @JsonKey(ignore: true)
  _$FullPlanCopyWith<_FullPlan> get copyWith =>
      throw _privateConstructorUsedError;
}
