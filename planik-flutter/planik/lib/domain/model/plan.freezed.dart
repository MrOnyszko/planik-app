// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PlanTearOff {
  const _$PlanTearOff();

  _Plan call(
      {required int id,
      required String name,
      required bool current,
      required DateTime createdAt,
      required DateTime updatedAt}) {
    return _Plan(
      id: id,
      name: name,
      current: current,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// @nodoc
const $Plan = _$PlanTearOff();

/// @nodoc
mixin _$Plan {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get current => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlanCopyWith<Plan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanCopyWith<$Res> {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) then) = _$PlanCopyWithImpl<$Res>;

  $Res call({int id, String name, bool current, DateTime createdAt, DateTime updatedAt});
}

/// @nodoc
class _$PlanCopyWithImpl<$Res> implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._value, this._then);

  final Plan _value;
  // ignore: unused_field
  final $Res Function(Plan) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? current = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      current: current == freezed
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) then) = __$PlanCopyWithImpl<$Res>;

  @override
  $Res call({int id, String name, bool current, DateTime createdAt, DateTime updatedAt});
}

/// @nodoc
class __$PlanCopyWithImpl<$Res> extends _$PlanCopyWithImpl<$Res> implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(_Plan _value, $Res Function(_Plan) _then)
      : super(_value, (v) => _then(v as _Plan));

  @override
  _Plan get _value => super._value as _Plan;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? current = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Plan(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      current: current == freezed
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_Plan implements _Plan {
  const _$_Plan(
      {required this.id,
      required this.name,
      required this.current,
      required this.createdAt,
      required this.updatedAt});

  @override
  final int id;
  @override
  final String name;
  @override
  final bool current;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Plan(id: $id, name: $name, current: $current, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Plan &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, current, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  _$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);
}

abstract class _Plan implements Plan {
  const factory _Plan(
      {required int id,
      required String name,
      required bool current,
      required DateTime createdAt,
      required DateTime updatedAt}) = _$_Plan;

  @override
  int get id;
  @override
  String get name;
  @override
  bool get current;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$PlanCopyWith<_Plan> get copyWith => throw _privateConstructorUsedError;
}
